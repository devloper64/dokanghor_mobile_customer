import 'dart:async';
import 'dart:ui';
import 'package:ecommerce_customer_app/SharedPrefsHelper.dart';
import 'package:ecommerce_customer_app/screen/home/HomeScreen.dart';
import 'package:ecommerce_customer_app/screen/intro/IntroScreen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class MySplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashState createState() => new _SplashState();
}

//background: #DB3022;
class _SplashState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () async {
      bool isFirstTimeOpen = await SharedPrefsHelper.getFirstTimeOpenStatus();
      if (!isFirstTimeOpen) {
        Navigator.pushNamed(context, IntroScreen.routeName);
      } else {
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: SPLASH_BACK,
        child: Image.asset("assets/images/splash_icon.png"));
  }
}
