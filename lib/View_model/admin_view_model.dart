import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import '../core/app_colors.dart';
import '../models/need_model.dart';
import '../widgets/disposable_provider.dart';
import '../widgets/util.dart';
import 'package:http/http.dart' as http;

class NeedViewModel extends DisposableProvider {
  // List<NeedModel> _categories = [];
  List<NeedModel> _needDetails = [];
  List<NeedModel> _pendingNeedDetails = [];
  List<NeedModel> _acceptedNeedDetails = [];

  List<NeedModel> get requirementDetails => _needDetails;

  List<NeedModel> get pendingDetails => _pendingNeedDetails;

  List<NeedModel> get acceptedDetails => _acceptedNeedDetails;

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void deleteDocument(String documentId, bool status) async {
    try {
      setLoading(true);
      print("documnetId $documentId");
      // Delete the document from Firestore
      await FirebaseFirestore.instance
          .collection("Need")
          .doc(documentId)
          .delete();

      // Delete the corresponding image from Firebase Storage
      try {
        Reference storageRef =
        FirebaseStorage.instance.ref().child('prescriptions/$documentId.jpg');
        await storageRef.delete();
      } catch(e) {

      }

      notifyListeners();
      await fetchData();
      setLoading(false);

      if (status) {
        Util.getSnackBar("Accepted".trTrans, color: AppColors.lightGreen);
      } else if (!status) {
        Util.getSnackBar("Rejected".trTrans, color: AppColors.deepRed);
      }
    } catch (error) {
      print('Error deleting document: $error');
      Util.getSnackBar("Something went wrong".trTrans,
          color: AppColors.deepRed);
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchPendingData(String donorId) async {
    print("Entered fetchPendingData method $donorId");
    // try {
    final DocumentSnapshot<Map<String, dynamic>> donorSnapshot =
        await FirebaseFirestore.instance.collection('donor').doc(donorId).get();
    if (!donorSnapshot.exists) {
      print('Donor not found');
      return;
    }

    final List<dynamic> pendingIds = donorSnapshot.data()?['pendingIds'] ?? [];

    print("pendingIds=>");
    print(pendingIds);

    if (pendingIds.isEmpty) {
      _pendingNeedDetails.clear();
      return;
    }
    final QuerySnapshot<Map<String, dynamic>> pendingDocsSnapshot =
        await FirebaseFirestore.instance
            .collection('Need')
            .where(FieldPath.documentId, whereIn: pendingIds)
            .get();

    final List<NeedModel> fetchedPendingNeedModels = pendingDocsSnapshot.docs
        .map((doc) => NeedModel.fromJson(doc.data(), doc.id))
        .toList();

    _pendingNeedDetails = fetchedPendingNeedModels;
    print("Fetched Pending Data:");
    print(_pendingNeedDetails);
    notifyListeners();
    // } catch (error) {
    //   print("Error fetching pending data: $error");
    // }
  }

  Future<void> fetchAcceptedData(String donorId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> donorSnapshot =
          await FirebaseFirestore.instance
              .collection('donor')
              .doc(donorId)
              .get();

      if (!donorSnapshot.exists) {
        print('Donor not found');
        return;
      }

      final List<dynamic> acceptedIds =
          donorSnapshot.data()?['acceptedIds'] ?? [];

      if (acceptedIds.isEmpty) {
        _acceptedNeedDetails.clear();
        return;
      }

      final QuerySnapshot<Map<String, dynamic>> acceptedDocsSnapshot =
          await FirebaseFirestore.instance
              .collection('Need')
              .where(FieldPath.documentId, whereIn: acceptedIds)
              .get();

      print("AcceptedSnashot=>");
      print(acceptedDocsSnapshot);
      final List<NeedModel> fetchedAcceptedNeedModels = acceptedDocsSnapshot
          .docs
          .map((doc) => NeedModel.fromJson(doc.data(), doc.id))
          .toList();

      _acceptedNeedDetails = fetchedAcceptedNeedModels;
      print("Fetched Pending Data:");
      print(_acceptedNeedDetails);

      notifyListeners();
    } catch (error) {
      print("Error fetching pending data: $error");
    }
  }

  Future<void> fetchData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> needSnapshot =
          await FirebaseFirestore.instance
              .collection('Need')
              .where('status', isNotEqualTo: "Approved")
              .get();

      final List<NeedModel> fetchedNeedModels = needSnapshot.docs
          .map((doc) => NeedModel.fromJson(doc.data(), doc.id))
          .toList();

      _needDetails = fetchedNeedModels;
      notifyListeners();
    } catch (error) {
      print("Error fetching data: $error");

      Util.getSnackBar('Something went wrong.'.trTrans);
    }
  }

  Future<bool> sendNeedIdToDonors(
    String bloodGroup,
    int units,
    String city,
    String pendingNeedId,
  ) async {
    List<String> tokens = [];
    String title =
        "Urgent Blood Donation Needed in $city – $units Units Required";
    String body =
        "Blood donors urgently needed in $city. $units units needed. Your donation can save lives. Please visit check you dashboard now to help. Thank you.";
    DateTime fourMonthsAgo = DateTime.now().subtract(Duration(days: 4 * 30));
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await _firestore
          .collection('donor')
          .where('bloodGroup', isEqualTo: bloodGroup)
          .where('bloodDonationDate', isLessThanOrEqualTo: Timestamp.fromDate(fourMonthsAgo))
          .get();

      List<DocumentSnapshot> filteredDocs = querySnapshot.docs.where((doc) {
        return (doc['city'].toString()).trim().toLowerCase().contains(city.trim().toLowerCase());
      }).toList();
      print("TOTAL DOCS: ${querySnapshot.docs.length}");
      print("FILTERED DOCS: ${filteredDocs.length}");
      for (DocumentSnapshot document in filteredDocs) {
        print(document.id);
        String? token = (document.data() as Map?)?['token'];
        print((document.data() as Map?)?['name']);
        List pendingIds = (document.data() as Map?)?['pendingIds'] ?? [];
        pendingIds.add(pendingNeedId);

        if (token != null) {
          tokens.add(token);
        }
        _firestore
            .collection('donor')
            .doc(document.id)
            .update({'pendingIds': pendingIds});

      }
      Util.sendFCMNotification(tokens, title, body);
    } catch (e) {
      print('Error sending needId to donors: $e');
      return false;
      // Handle error as needed
    }
    await fetchData();
    setLoading(false);
    return true;
  }

  updateStatus(String documentId, String status) async {
    try {
      setLoading(true);
      print("documentId $documentId");

      // Update the 'status' field in the document
      await FirebaseFirestore.instance
          .collection("Need")
          .doc(documentId)
          .update({'status': status});

      notifyListeners();
      // fetchData(); // Optionally fetch data again after the update

      Util.getSnackBar("Accepted".trTrans, color: AppColors.lightGreen);
    } catch (error) {
      print('Error updating status: $error');
      Util.getSnackBar("Something went wrong".trTrans,
          color: AppColors.deepRed);
    } finally {
      setLoading(false);
    }
  }

  @override
  void disposeValues() {
    _needDetails = [];
  }
}
