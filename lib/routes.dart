import 'package:ecommerce_customer_app/screen/home/HomeScreen.dart';
import 'package:ecommerce_customer_app/screen/intro/IntroScreen.dart';
import 'package:ecommerce_customer_app/screen/splash/SplashScreen.dart';
import 'package:flutter/widgets.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  MySplashScreen.routeName: (context) => MySplashScreen(),
  IntroScreen.routeName: (context) => IntroScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
