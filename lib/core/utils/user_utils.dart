
import '../../enums/user_role.dart';
import '../../models/user_models.dart';

bool isAdmin() {
  return currentUserRole == UserRole.admin;
}

bool isDonor() {
  return currentUserRole == UserRole.donor;
}

bool isNeed() {
  return currentUserRole == UserRole.need;
}
