import '../SharedPrefsHelper.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class IntroButton extends StatelessWidget {
  const IntroButton({
    Key? key,
    required this.text,
    required this.routeName,
  }) : super(key: key);
  final String text;
  final String routeName;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kPrimaryColor,
        onPressed: (){
          Navigator.pushNamed(context, routeName);
          SharedPrefsHelper.storeFirstTimeOpenStatus(true);
      },
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
