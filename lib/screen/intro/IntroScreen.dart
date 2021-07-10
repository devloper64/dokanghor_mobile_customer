import 'package:ecommerce_customer_app/screen/intro/components/IntroScreenBody.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class IntroScreen extends StatelessWidget{


  static String routeName = "/intro";


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: IntroScreenBody(),
    );
  }

}