import 'package:ecommerce_customer_app/golbal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecommerce_customer_app/model/response/product/Product.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';


class ProductDescription extends StatefulWidget {
  ProductDescription({required this.product, required this.pressOnFeedBack,});

  final Product product;
  final GestureTapCallback pressOnFeedBack;

  @override
  State<StatefulWidget> createState() {
   return _StateProductDescription(product: product,pressOnFeedBack: pressOnFeedBack);
  }

}

class _StateProductDescription extends State<ProductDescription> {


  int selectIndex=0;


  _StateProductDescription({required this.product, required this.pressOnFeedBack,});

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
        
        SizedBox(height: getProportionateScreenHeight(10),),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            product.productDetailsResponse!.size_mesaurments!.isNotEmpty?Padding(padding: EdgeInsets.only(left: getProportionateScreenWidth(13)),child: buildList(sizeList( product.productDetailsResponse!.size_mesaurments!)),):Container(),

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
          ],
        ),

        SizedBox(height: getProportionateScreenHeight(10),),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Text(
                "Brand:"+product.productDetailsResponse!.brand!,
                maxLines: 3,
              ),

            ),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    product.productDetailsResponse!.styles!.length,
                        (index) {
                        return getStringFromArray( product.productDetailsResponse!.styles![index]);
                    },
                  ),
                ],
              )

            ),

            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    product.productDetailsResponse!.size_details!.length,
                        (index) {
                      return getStringFromArray( product.productDetailsResponse!.size_details![index]);
                    },
                  ),
                ],
              )

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

  Widget getStringFromArray(String value){
    return Text(
      value,
      maxLines: 3,
    );
  }


  Widget buildList(List<String> list) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(list.length, (index) {
            return GestureDetector(
              onTap: (){
                setState(() {
                  selectIndex=index;
                  globalSize=list[index];
                });

              },
              child:Container(
              width: getProportionateScreenWidth(40),
              margin: EdgeInsets.only(left: getProportionateScreenWidth(7)),
              height: getProportionateScreenHeight(40),
              child: Material(
                child: Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: selectIndex==index?kPrimaryColor:kSecondaryColor)
                  ),
                  child: Center(child:Text(list[index],style: TextStyle(color: selectIndex==index?kPrimaryColor:kSecondaryColor),)),
                )
              ),
              ),);
          }),
        ],
      ),
    );
  }

  List<String> sizeList(String sizeList){
    return sizeList.split(",");
  }


}
