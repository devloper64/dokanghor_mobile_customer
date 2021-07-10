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

}