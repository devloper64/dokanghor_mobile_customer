import 'package:ecommerce_customer_app/constants.dart';
import 'package:flutter/material.dart';

import '../../../../size_config.dart';

class DiscountBanner extends StatelessWidget {

   final String tittle;
   final String image;
   final String highLightTittle;
   final GestureTapCallback press;


   DiscountBanner({Key? key, required this.tittle, required this.image, required this.highLightTittle, required this.press,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image.isEmpty?GestureDetector(
    onTap: press,
    child:Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: tittle+"\n"),
            TextSpan(
              text: highLightTittle,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    )):GestureDetector(
        onTap: press,
    child:Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(
                  image
              ),
              fit: BoxFit.cover
          )
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: kPrimaryColor),
          children: [
            TextSpan(text: tittle+"\n"),
            TextSpan(
              text: highLightTittle,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
