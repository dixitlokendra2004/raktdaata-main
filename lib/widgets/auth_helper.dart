import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raktdata_app/widgets/extensions.dart';

class AuthHelper {
  static const String isLoggedInKey = 'isLoggedIn';
  static const String isAdminKey = 'isAdminKey';

  static Future<void> saveUserData(Map data, bool isAdmin) async {
    print("saveUserData ${data}");
    try {
      data['bloodDonationDate'] = (data['bloodDonationDate'] as Timestamp)
          .toDate()
          .formatDate;
    } catch (e) {
      data['bloodDonationDate'] = "";
    }
    await GetStorage().write('user', data);
    await GetStorage().write(isAdminKey, isAdmin);
  }

  static Future<void> saveDonorDataById(var id) async {
    DocumentSnapshot documentSnapshot =
    await FirebaseFirestore.instance.collection('donor')
        .doc(id.toString())
        .get();
    if (documentSnapshot.exists) {
      Map data = (documentSnapshot.data() as Map);
      try {
        data['bloodDonationDate'] = (data['bloodDonationDate'] as Timestamp)
            .toDate()
            .formatDate;
      } catch (e) {
        data['bloodDonationDate'] = "";
      }
      await GetStorage().write('user', data);
    }
  }

  static Future<void> logout() async {
    await GetStorage().erase();
  }

  static bool isLoggedIn() {
    print("isLogged ${GetStorage().read('user')}");
    return (GetStorage().read('user') != null);
  }

  static bool isAdmin() {
    return GetStorage().read(isAdminKey) ?? false;
  }
}
