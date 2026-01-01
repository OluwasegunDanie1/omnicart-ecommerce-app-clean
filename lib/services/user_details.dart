import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefhelper {
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userImageKey = "USERIMAGEKEY";

  Future<bool> saveUserId(String getUserId) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserImage(String getUserImage) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userImageKey, getUserImage);
  }

  //to get

  Future<String?> getuserId() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userIdKey);
  }

  Future<String?> getuserName() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }

  Future<String?> getuserEmail() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }

  Future<String?> getuserImage() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userImageKey);
  }
}
