import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecommerce_customer_app/model/response/product/Product.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';


class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    required this.pressOnFeedBack,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback pressOnFeedBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            product.name!,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              color:
                 Color(0xFFFFE6E6) ,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/Heart Icon_2.svg",
              color:
                  Color(0xFFFF4848) ,
              height: getProportionateScreenWidth(16),
            ),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Text(
                "Brand:"+product.productDetails!.brand!,
                maxLines: 3,
              ),

            ),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Text(
                product.productDetails!.style!.replaceAll(new RegExp(r"\s+"), "").replaceAll("->", "\n"),
                maxLines: 3,
              ),

            ),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Text(
                "Size:"+product.productDetails!.size_mesaurments!,
                maxLines: 3,
              ),

            ),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Text(
                product.productDetails!.size_details!.replaceAll(new RegExp(r"\s+"), "").replaceAll("->", "\n"),
                maxLines: 3,
              ),

            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "See Product Feed Back",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
