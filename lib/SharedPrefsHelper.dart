import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper{


  static void storeFirstTimeOpenStatus(bool isLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('firstTime', isLoggedIn);
  }

  static Future<bool> getFirstTimeOpenStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('firstTime') ?? false;
  }


  static void storeFcmToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('fcm', token);
  }

  static Future<String> getFcmToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('fcm') ?? "";
  }

  static void storeUserToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  static Future<String> getUserToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? "";
  }


}