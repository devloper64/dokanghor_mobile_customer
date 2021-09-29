import 'SharedPrefsHelper.dart';

late int productPage=0;

Future<String> fcmToken() async {
  String token = await SharedPrefsHelper.getFcmToken();
  return token;
}

Future<String> getUserToken() async {
  String token = await SharedPrefsHelper.getUserToken();
  return token;
}