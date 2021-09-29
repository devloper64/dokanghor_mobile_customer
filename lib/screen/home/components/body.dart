import 'package:ecommerce_customer_app/bloc/ProductListBloc.dart';
import 'package:flutter/material.dart';

import '../../../golbal.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';


class Body extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState  extends State<Body> {
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productPage=0;
    productBloc..getProducts("id,desc",productPage,30,true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        productPage++;
         _fetch();
      }
    });
  }

  Future _fetch() async{
    productBloc..getProducts("id,desc",productPage,30,false);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
           children: [
             SizedBox(height: getProportionateScreenHeight(20)),
             HomeHeader(),
             SizedBox(height: getProportionateScreenWidth(10)),
             DiscountBanner(),
             Categories(),
             SpecialOffers(),
             SizedBox(height: getProportionateScreenWidth(30)),
             PopularProducts(),
             SizedBox(height: getProportionateScreenWidth(30)),
           ],
        ),
      ),
    );
  }
}
