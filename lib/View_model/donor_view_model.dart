import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/View_model/admin_view_model.dart';
import 'package:raktdata_app/View_model/auth_admin.dart';
import 'package:raktdata_app/widgets/auth_helper.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import '../core/app_colors.dart';
import '../models/donor_model.dart';
import '../widgets/disposable_provider.dart';
import '../widgets/util.dart';

class DonorListViewModel extends DisposableProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Stream<List<DonorModel>> getDonorsByBloodGroup(String bloodGroup) {
    return _firestore
        .collection('donor')
        .where('bloodGroup', isEqualTo: bloodGroup) // Filter by blood group
        .orderBy('mobileNumber')
        .snapshots()
        .map((querySnapshot) {
      final donors = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return DonorModel(
          name: data['name'],
          mobileNumber: data['mobileNumber'],
          bloodGroup: data['bloodGroup'],
        );
      }).toList();
      return donors;
    });
  }

  Future<void> acceptReq(
    String bloodGroup,
    String acceptedNeedId,
  ) async {
    setLoading(true);
    try {
      final DocumentSnapshot<Map<String, dynamic>> needSnapshot =
          await FirebaseFirestore.instance
              .collection('Need')
              .doc(acceptedNeedId)
              .get();

      if (needSnapshot.exists) {
        int bloodUnits = needSnapshot.data()?['bloodUnits'] ?? 0;
        if (bloodUnits > 0) {
          bloodUnits--;
          await FirebaseFirestore.instance
              .collection('Need')
              .doc(acceptedNeedId)
              .update({'bloodUnits': bloodUnits});

          await _firestore
              .collection('donor')
              .doc(Util.user['docId'])
              .update({
            'acceptedIds': FieldValue.arrayUnion([acceptedNeedId]),
            'pendingIds': FieldValue.arrayRemove([acceptedNeedId]),
            'bloodDonationDate': FieldValue.serverTimestamp(),
          });

          if (bloodUnits == 0) {
            QuerySnapshot<Map<String, dynamic>> donorsSnapshot =
                await _firestore
                    .collection('donor')
                    .where('pendingIds', arrayContains: acceptedNeedId)
                    .get();

            for (QueryDocumentSnapshot<Map<String, dynamic>> donorDoc
                in donorsSnapshot.docs) {
              donorDoc.reference.update({
                'pendingIds': FieldValue.arrayRemove([acceptedNeedId]),
              });
            }
          }

          await Provider.of<NeedViewModel>(Get.context!, listen: false)
              .fetchPendingData(Util.user['docId'] ?? "");
          await Provider.of<NeedViewModel>(Get.context!, listen: false)
              .fetchAcceptedData(Util.user['docId'] ?? "");
          AuthHelper.saveDonorDataById(Util.user['docId']);
        } else {
          print("1ERR");
          Util.getSnackBar("Something went wrong".trTrans);
        }
      } else {
        print("2ERR");
        Util.getSnackBar("Something went wrong".trTrans);
      }
    } catch (e) {
      print("3ERR");
      Util.getSnackBar("Something went wrong".trTrans);
      print('Error sending needId to donors: $e');
    }
    setLoading(false);
  }

  @override
  void disposeValues() {
    _loading = false;
  }
}

// DonorListViewModel().getDonorsByBloodGroup('A+').listen((List<DonorModel> donors) {
//     List<String> mobileNumbers = donors.map((donor) => donor.mobileNumber).toList();});
//     print('Mobile Numbers: $mobileNumbers');

//to call Stream<List<DonorModel>> aPositiveDonorsStream = DonorListViewModel().getDonorsByBloodGroup('A+');
