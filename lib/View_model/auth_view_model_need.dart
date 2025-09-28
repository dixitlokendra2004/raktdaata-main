import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/presentation/Frontpage/FrontPage.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import '../core/app_string.dart';
import '../widgets/disposable_provider.dart';
import '../widgets/splash_screen.dart';
import '../widgets/util.dart';
import 'donor_view_model.dart';

class AuthViewModelNeed extends DisposableProvider {
  final CollectionReference _needCollection =
      FirebaseFirestore.instance.collection('Need');
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Future<void> signUp(
    String patientName,
    String disease,
    String hospitalName,
    String hospitalAddress,
    String mobileNumber,
    String city,
    String bloodGroup,
    String bloodUnits,
    String attendersName,
    File? prescription,
    // User? currentU,
  ) async {
    try {
      print("entered try ");
      if (!validateIndianPhoneNumber(mobileNumber)) {
        Util.getSnackBar('Please enter valid mobile number'.trTrans);
        return;
      }

      if (mobileNumber.length != 10) {
        Util.getSnackBar('Please enter valid mobile number'.trTrans);
        return;
      }

      if (prescription == null) {
        Util.getSnackBar('Please choose a file'.trTrans);
        return;
      }

      if (!validatePatientName(patientName)) {
        Util.getSnackBar('Please enter valid name'.trTrans);
        return;
      }

      if (disease.isEmpty) {
        Util.getSnackBar('Please enter disease'.trTrans);
        return;
      }

      if (bloodUnits.isEmpty) {
        Util.getSnackBar('Please enter blood Unit'.trTrans);
        return;
      }

      if (bloodGroup == AppStrings.NA) {
        Util.getSnackBar('Please select your blood group'.trTrans);
        return;
      }

      if (!validateAttenderName(attendersName)) {
        Util.getSnackBar('Please enter attender name'.trTrans);
        return;
      }

      if (!validateHospitalName(hospitalName)) {
        Util.getSnackBar('Please enter hospital name'.trTrans);
        return;
      }

      if (hospitalAddress.isEmpty) {
        Util.getSnackBar('Please enter hospital address'.trTrans);
        return;
      }

      if (!validateCityName(city)) {
        Util.getSnackBar('Please enter valid city name'.trTrans);
        return;
      }

      setLoading(true);
      final needData = {
        'patientName': patientName,
        'disease': disease,
        'hospitalName': hospitalName,
        'hospitalAddress': hospitalAddress,
        'mobileNumber': mobileNumber,
        'city': city,
        'bloodGroup': bloodGroup,
        'date': DateTime.now(),
        'bloodUnits': int.tryParse(bloodUnits),
        'attendersName': attendersName,
        'status': 'Pending',
        // 'prescription':prescription,
      };

      print('Generated needData: $needData');

      final newDocRef = _needCollection.doc();
      await newDocRef.set(needData);
      String docId = newDocRef.id;
      print("docId");
      print(docId);

      print("entered try1");
      if (prescription != null) {
        final prescriptionUrl = await uploadPrescription(docId, prescription);
        // needData['prescriptionUrl'] = prescriptionUrl;
        await newDocRef.update({'prescriptionUrl': prescriptionUrl});
        print("Prescription URL uploaded successfully.");
        print(prescriptionUrl);
      }

      //function to send messages
      // List<String> phoneNumbers = ['917477015841', '918770820133', '919399767395'];
      // await sendWhatsAppMessage(phoneNumbers);

      //from here whatsapp messages will called
      // await sendWhatsAppMessage();

      notifyAdmins(city);
      Util.getSnackBar(
        'You have successfully registered!'.trTrans,
        color: AppColors.lightGreen,
        // Set the text color
      );

      Get.off(() => FrontPage());

      // }
    } catch (e) {
      String errorMessage = 'Error signing up. Please try again.'.trTrans;
      Util.getSnackBar(errorMessage);
      print('Error signing up: $e');
    }
    setLoading(false);
  }

  Future<String> uploadPrescription(String userId, File prescription) async {
    try {
      // print("bbbbbbbbbbbbbbb");
      //  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      // String fileName = '$userId$timestamp.jpg';

      String fileName = '$userId.jpg'; // Customize the file name if needed
      Reference storageReference =
          FirebaseStorage.instance.ref().child('prescriptions/$fileName');
      UploadTask uploadTask = storageReference.putFile(prescription);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("aaaaaaaaaaaaaaaaaaa");
      print(downloadUrl);
      print("downloadUrl");
      return downloadUrl;
    } catch (e) {
      print('Error uploading file to Firebase Storage: $e');
      throw e; // You can handle the error as needed
    }
  }

  bool validateIndianPhoneNumber(String phoneNumber) {
    // Define a regular expression pattern for Indian phone numbers
    RegExp regex = RegExp(r'^[6789]\d{9}$');

    // Use the hasMatch method to check if the input matches the pattern
    return regex.hasMatch(phoneNumber);
  }

  bool validatePatientName(String name) {
    // Define a regular expression pattern for names (alphabetic characters only)
    RegExp regex = RegExp(r'^[a-zA-Z ]+$');

    // Use the hasMatch method to check if the input matches the pattern
    return regex.hasMatch(name) && name.isNotEmpty && name.length >= 3;
  }

  bool validateHospitalName(String hospitalName) {
    // Define a regular expression pattern for names (alphabetic characters only)
    RegExp regex = RegExp(r'^[a-zA-Z ]+$');

    // Use the hasMatch method to check if the input matches the pattern
    return regex.hasMatch(hospitalName) &&
        hospitalName.isNotEmpty &&
        hospitalName.length >= 3;
  }

  bool validateAttenderName(String attenderName) {
    // Define a regular expression pattern for names (alphabetic characters only)
    RegExp regex = RegExp(r'^[a-zA-Z ]+$');

    // Use the hasMatch method to check if the input matches the pattern
    return regex.hasMatch(attenderName) &&
        attenderName.isNotEmpty &&
        attenderName.length >= 3;
  }

  bool validateCityName(String city) {
    // Define a regular expression pattern for city names in India
    RegExp regex = RegExp(r'^[a-zA-Z ]+$');

    // Check if the input matches the pattern and is not empty
    return regex.hasMatch(city) && city.isNotEmpty;
  }

  @override
  void disposeValues() {
    _loading = false;
  }

  Future<void> notifyAdmins(String city) async {
    List<String> tokens = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('admin').get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        final data = document.data() as Map<String, dynamic>?;
        String? token = data?['token'];
        if (token != null) {
          tokens.add(token);
        }
      }

      String title =
          "New Blood Requirement Generated - Please check Dasahboard";
      String body =
          "A new blood requirement has been generated from $city. Please review this request in your dashboard for further action.";

      await Util.sendFCMNotification(tokens, title, body);
    } catch (e) {
      print("Error: $e");
    }
  }
}
