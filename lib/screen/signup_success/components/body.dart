import 'package:ecommerce_customer_app/components/default_button.dart';
import 'package:ecommerce_customer_app/screen/home/HomeScreen.dart';
import 'package:ecommerce_customer_app/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight! * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight! * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.08),
        Text(
          "Please check your email to activate your account",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          child: DefaultButton(
            text: "Login",
            press: () {
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
