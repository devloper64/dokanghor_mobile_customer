import 'package:ecommerce_customer_app/screen/search/SearchScreen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          SearchScreen.routeName,
        ),
        child: Container(
            height: getProportionateScreenHeight(48),
            width: SizeConfig.screenWidth! * 0.6,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Padding(padding: EdgeInsets.only(left: getProportionateScreenWidth(20))),
                Icon(Icons.search),
                Padding(padding: EdgeInsets.only(left: getProportionateScreenWidth(20))),
                Text("Search Product"),
              ],
            )));
  }
}
