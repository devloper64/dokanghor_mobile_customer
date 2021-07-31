import 'package:ecommerce_customer_app/routes.dart';
import 'package:ecommerce_customer_app/screen/splash/SplashScreen.dart';
import 'package:ecommerce_customer_app/theme.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DokanGhor",
      theme: theme(),
      initialRoute: MySplashScreen.routeName,
      routes: routes,
    );
  }
  
}


