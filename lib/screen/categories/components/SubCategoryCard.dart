import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SubCategoryCard extends StatelessWidget {
  const SubCategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.id,
    required this.press,
  }) : super(key: key);

  final int id;
  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: CategoryBack,
                borderRadius: BorderRadius.circular(10),
              ),
              child:id==0? SvgPicture.asset("assets/icons/Discover.svg"):Image.network(icon),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center,style: TextStyle(fontSize: 11),)
          ],
        ),
      ),
    );
  }
}