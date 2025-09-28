import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/core/app_string.dart';
import 'package:raktdata_app/presentation/Frontpage/FrontPage.dart';
import 'package:raktdata_app/presentation/donor_login_signUp/donor_signUp.dart';
import 'package:raktdata_app/widgets/tabBar.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:raktdata_app/presentation/donor_login_signUp/donor_login.dart';
import '../enums/user_role.dart';
import '../models/user_models.dart';
import '../widgets/auth_helper.dart';
import '../widgets/disposable_provider.dart';
import '../widgets/splash_screen.dart';
import '../widgets/util.dart';

class AuthViewModel extends DisposableProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _donorsCollection =
      FirebaseFirestore.instance.collection('donor');
  bool _loading = false;
  bool otpSent = false;
  String verificationId = "";

  bool get loading => _loading;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Future<void> updateBloodDonationDate(DateTime? bloodDonationDate) async {
    try {
      await _donorsCollection
          .doc(Util.user['docId'])
          .update({'bloodDonationDate': bloodDonationDate});
      Util.getSnackBar("Successfully Updated".trTrans,
          color: AppColors.lightGreen);
    } catch (e) {
      Util.getSnackBar("Error updating blood donation date".trTrans);

      print('Error updating blood donation date: $e');
    }
  }

  Future<void> updateToken(String token) async {
    try {
      String? uid = Util.user['docId'];

      if (uid != null) {
        // Attempt to get the document
        DocumentReference docRef = _donorsCollection.doc(uid);
        DocumentSnapshot donorSnapshot = await docRef.get();

        if (donorSnapshot.exists) {
          // Document exists, attempt to update token
          await docRef.set({'token': token}, SetOptions(merge: true));
        } else {
          // Document doesn't exist, create it with the token
          await docRef.set({'token': token});
        }
      }
    } catch (e) {
      print('Error updating token: $e');
      print('Token is null');
    }
  }

  Future<void> signUp(
    String name,
    String email,
    String city,
    String mobileNumber,
    String bloodGroup,
    DateTime? bloodDonationDate,
    String newDocId,
  ) async {
    try {
      if (!isEmailValid(email)) {
        Util.getSnackBar('Please enter a valid email.'.trTrans);
        return;
      }

      if (!validateName(name)) {
        Util.getSnackBar('Please enter valid name'.trTrans);
        return;
      }

      if (!validateCityName(city)) {
        Util.getSnackBar('Please enter valid  city name'.trTrans);
        return;
      }

      if (bloodGroup == AppStrings.NA) {
        Util.getSnackBar('Please select your blood group'.trTrans);
        return;
      }

      if (bloodDonationDate == null) {
        bloodDonationDate = null;
      }

      if (name.isEmpty) {
        Util.getSnackBar('Name cannot be empty.'.trTrans);
        return;
      }

      setLoading(true);
      await _donorsCollection.doc(newDocId).set({
        'docId': newDocId,
        'name': name,
        'city': city,
        'email': email,
        'bloodGroup': bloodGroup,
        'bloodDonationDate': bloodDonationDate,
        'mobileNumber': mobileNumber,
      });
      await AuthHelper.logout();

      DocumentSnapshot documentSnapshot =
          await _donorsCollection.doc(newDocId).get();

      if (documentSnapshot.exists) {
        await AuthHelper.saveUserData(documentSnapshot.data() as Map, false);
        currentUserRole = UserRole.donor;
        Get.offAll(() => CustomTabBar());
      } else {
        Util.getSnackBar("Something went wrong".trTrans);
      }
    } catch (e) {
      String errorMessage = 'Error signing up. Please try again.'.trTrans;

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'email is already registered.'.trTrans;
            break;
          case 'weak-password':
            errorMessage = 'Password is too weak.'.trTrans;
            break;
        }
      }
      Util.getSnackBar(errorMessage);
      print('Error signing up: $e');
    }
    setLoading(false);
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

    return emailRegex.hasMatch(email);
  }

  bool validateIndianPhoneNumber(String phoneNumber) {
    // Define a regular expression pattern for Indian phone numbers
    RegExp regex = RegExp(r'^[6789]\d{9}$');

    // Use the hasMatch method to check if the input matches the pattern
    return regex.hasMatch(phoneNumber);
  }

  bool validateName(String name) {
    // Define a regular expression pattern for names (alphabetic characters only)
    RegExp regex = RegExp(r'^[a-zA-Z ]+$');

    // Use the hasMatch method to check if the input matches the pattern
    return regex.hasMatch(name) && name.isNotEmpty && name.length >= 3;
  }

  bool validateCityName(String city) {
    // Define a regular expression pattern for city names in India
    RegExp regex = RegExp(r'^[a-zA-Z ]+$');

    // Check if the input matches the pattern and is not empty
    return regex.hasMatch(city) && city.isNotEmpty;
  }

  Future<void> loginOrSignup(String phoneNo, String otp) async {
    setLoading(true);
    try {
      String? uid = await verifyOtp(otp);
      if (uid == null) {
        Util.getSnackBar("Please enter valid OTP.".trTrans);
      } else {
        DocumentSnapshot documentSnapshot =
            await _donorsCollection.doc(uid).get();

        if (documentSnapshot.exists) {
          await AuthHelper.saveUserData(documentSnapshot.data() as Map, false);
          currentUserRole = UserRole.donor;
          Get.offAll(() => CustomTabBar());
        } else {
          Get.off(() => DonorSignUp(newDocId: uid, phoneNo: phoneNo));
        }
      }
    } catch (e) {
      print('Error logging in: $e');
    }
    notifyListeners();
    setLoading(false);
  }

  Future<String?> verifyOtp(String otp) async {
    // return "AXJkpyAGZ0dw8j309E5Ka5Va01y2";
    var credentials =
        await _auth.signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ));
    print("userCredential.user?.uid");
    print(credentials.user?.uid);
    return credentials.user?.uid;
  }

  sendOtp(String phoneNumber) async {
    // phoneNumber = "9340953578";
    setLoading(true);
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (credentials) async {
        // await _auth.signInWithCredential(credentials);
      },
      verificationFailed: (e) {
        print("verificationFailed +91$phoneNumber");
        print("${e.message} ${e.code} ${e.stackTrace.toString()}");
        Util.getSnackBar("${e.message} ${e.code} ${e.stackTrace.toString()}");
        setLoading(false);
      },
      codeSent: (verificationId, resendToken) {
        print("codeSent +91$phoneNumber");
        this.verificationId = verificationId;
        otpSent = true;
        setLoading(false);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  String getCurrentUserDocId() {
    return Util.user['docId'] ?? "";
  }

  @override
  void disposeValues() {
    _loading = false;
    otpSent = false;
    verificationId = "";
  }
}
