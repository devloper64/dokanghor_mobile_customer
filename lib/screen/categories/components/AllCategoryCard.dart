import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class AllCategoryCard extends StatefulWidget {
  AllCategoryCard({
    required this.icon,
    required this.text,
    required this.id,
  });

  final int id;
  final String icon, text;

  @override
  State<StatefulWidget> createState() {
    return _StateAllCategoryCard(icon: icon, text: text, id: id);
  }
}

class _StateAllCategoryCard extends State<AllCategoryCard> {
  _StateAllCategoryCard({
    required this.icon,
    required this.text,
    required this.id,
  });

  final int id;
  final String icon, text;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(10),bottom:getProportionateScreenHeight(5) ),
      child:  SizedBox(
          width: getProportionateScreenWidth(58),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                height: getProportionateScreenWidth(50),
                width: getProportionateScreenWidth(55),
                child: id == 0
                    ? SvgPicture.asset("assets/icons/Discover.svg")
                    : Image.network(icon),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11),
              )
            ],
          ),
        ),
      );

  }
}
