import 'package:ecommerce_customer_app/components/rounded_icon_btn.dart';
import 'package:ecommerce_customer_app/golbal.dart';
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class ColorDots extends StatefulWidget {
  ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  State<StatefulWidget> createState() {
    return StateColorDots(product: product);
  }
}

class StateColorDots extends State<ColorDots> {
  StateColorDots({
    required this.product,
  });

  final Product product;

  int selectedColor = 0;
  int quantity=1;

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            product.productDetailsResponse!.colors!.length,
            (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                    globalColor=product.productDetailsResponse!.colors![index];
                  });
                },
                child: Container(
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      border: Border.all(color: selectedColor == index ? kPrimaryColor : Colors.transparent),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ColorDot(
                        color: getColor(product.productDetailsResponse!.colors![index]),
                      ),
                    ))),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              setState(() {
                if(quantity>1){
                  quantity--;
                  globalQuantity=quantity.toString();
                }
              });
            },
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Text('$quantity',style: TextStyle(color: Colors.black),),
          SizedBox(width: getProportionateScreenWidth(10)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                if(quantity<5){
                  quantity++;
                  globalQuantity=quantity.toString();
                }
              });
            },

          ),
        ],
      ),
    );
  }

  Color getColor(String color) {
    String fc = color.replaceAll("#", "0xFF");
    return Color(int.parse(fc));
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(20),
      width: getProportionateScreenWidth(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
