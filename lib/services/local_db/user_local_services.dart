import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/constants/shared_pref_key.dart';
import 'package:todo/model/user.dart';

class UserLocalServices {
  static Future<bool> isUserLoggedIn() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(SharedPrefKeys.keyUserLogInStatus) ??
        false;
  }

  static Future<UserModel?> getLoggedUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? userDate =
        sharedPreferences.getString(SharedPrefKeys.keyLogUserInData);
    return userDate != null ? UserModel.fromJson(userDate) : null;
  }

  static Future saveUserDate({required UserModel userDate}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(SharedPrefKeys.keyUserLogInStatus, true);
    sharedPreferences.setString(
        SharedPrefKeys.keyLogUserInData, userDate.toJson());
  }

  static Future<void> clearUserDataOnLogOut() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
