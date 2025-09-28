import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/View_model/admin_view_model.dart';
import 'package:raktdata_app/core/app_string.dart';
import 'package:raktdata_app/presentation/Frontpage/FrontPage.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums/user_role.dart';
import '../models/user_models.dart';
import '../presentation/adminPage/adminPage.dart';
import '../widgets/auth_helper.dart';
import '../widgets/disposable_provider.dart';
import '../widgets/util.dart';

class AuthAdminViewModel extends DisposableProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _adminCollection =
      FirebaseFirestore.instance.collection('admin');
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    setLoading(true);
    try {
      QuerySnapshot querySnapshot = await _adminCollection
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await AuthHelper.saveUserData(
            querySnapshot.docs[0].data() as Map, true);
        currentUserRole = UserRole.admin;
        Get.offAll(() => AdminPage());
      } else {
        print(querySnapshot.docs);
        Util.getSnackBar('Please check your Email and Password'.trTrans);
      }
    } catch (e) {
      print('Error logging in: $e');
    }
    notifyListeners();
    setLoading(false);
  }

  Future<void> updateToken(String token) async {
    try {
      String? uid = Util.user['docId'];
      print("Uid => $uid");
      if (uid != null) {
        DocumentReference docRef = _adminCollection.doc(uid);
        DocumentSnapshot adminSnapshot = await docRef.get();

        if (adminSnapshot.exists) {
          await docRef.set({'token': token}, SetOptions(merge: true));
        } else {
          await docRef.set({'token': token});
        }
      }
    } catch (e) {
      print('Error updating token: $e');
      print('Token is null');
    }
  }

  Future<void> signOut() async {
    setLoading(true);
    try {
      await _auth.signOut();
      Provider.of<AuthAdminViewModel>(Get.context!, listen: false)
          .disposeValues();
      currentUserRole = UserRole.none;
      notifyListeners();
      await AuthHelper.logout();
      Get.offAll(() => FrontPage());
    } catch (e) {
      Util.getSnackBar(
          AppStrings.somethingWentWrongPleaseTryAgainLater.trTrans);
      print('Error signing out: $e');
    }
    setLoading(false);
  }

  @override
  void disposeValues() {
    _loading = false;
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Old Data?"),
          content: Text(
              "Are you sure you want to delete the Needs that are older then 1 Month"),
          actions: [
            TextButton(
              child: Text("NO"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                deleteOldNeeds();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void onDeletePressed() {
    showAlertDialog(Get.context!);
  }

  Future<void> deleteOldNeeds() async {
    setLoading(true);
    try {
      DateTime threeMonthsAgo = DateTime.now().subtract(Duration(days: 1 * 30));

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Need')
          .where('date',
              isLessThanOrEqualTo: Timestamp.fromDate(threeMonthsAgo))
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        try {
          Reference storageRef = FirebaseStorage.instance
              .ref()
              .child('prescriptions/${document.id}.jpg');
          await storageRef.delete();
        } catch (e) {}
        removeDocFromDonorLists(document.id);
        await FirebaseFirestore.instance
            .collection('Need')
            .doc(document.id)
            .delete();
      }
    } catch (e) {
      print('Error deleting old documents: $e');
    }
    await Provider.of<NeedViewModel>(Get.context!, listen: false).fetchData();
    setLoading(false);
  }

  Future<void> removeDocFromDonorLists(String id) async {
    QuerySnapshot pendingIdDocs = await FirebaseFirestore.instance
        .collection('donor')
        .where('pendingIds', arrayContains: id)
        .get();
    QuerySnapshot acceptedIdDocs = await FirebaseFirestore.instance
        .collection('donor')
        .where('acceptedIds', arrayContains: id)
        .get();

    for (var element in pendingIdDocs.docs) {
      await FirebaseFirestore.instance
          .collection('donor')
          .doc(element.id)
          .update({
        'pendingIds': FieldValue.arrayRemove([id]),
      });
    }
    for (var element in acceptedIdDocs.docs) {
      await FirebaseFirestore.instance
          .collection('donor')
          .doc(element.id)
          .update({
        'acceptedIds': FieldValue.arrayRemove([id]),
      });
    }
  }
}
