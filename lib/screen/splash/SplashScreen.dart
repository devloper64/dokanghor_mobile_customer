import 'dart:async';
import 'dart:ui';
import 'package:ecommerce_customer_app/screen/intro/IntroScreen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../HomeScreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

//background: #DB3022;
class _SplashState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => IntroScreen()))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: SPLASH_BACK,
        child: Image.asset("assets/images/splash_icon.png"));
  }
}
