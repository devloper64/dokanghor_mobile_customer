import 'package:ecommerce_customer_app/screen/home/HomeScreen.dart';
import 'package:ecommerce_customer_app/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../size_config.dart';


class CustomAppBar extends PreferredSize {

  CustomAppBar() : super(child: AppBar(),preferredSize: Size.fromHeight(AppBar().preferredSize.height),);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                color: Colors.white,
                padding: EdgeInsets.zero,
                onPressed: () => {
                  Navigator.pushNamed(context, ProfileScreen.routeName)
                },
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            Text("Login",style: TextStyle(fontSize: 18),)

          ],
        ),
      ),
    );
  }

}
