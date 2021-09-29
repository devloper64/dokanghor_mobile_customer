import 'package:ecommerce_customer_app/screen/intro/components/IntroScreenBody.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class NotificationScreen extends StatelessWidget{


  static String routeName = "/notification";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(child: Text("Notification"),),),
    );
  }

}