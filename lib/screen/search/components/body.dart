import 'package:ecommerce_customer_app/bloc/SearchProductListBloc.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/components/default_button.dart';
import 'package:ecommerce_customer_app/components/product_card.dart';
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/screen/home/components/section_title_without_see_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateBody();
  }
}

class StateBody extends State<Body> {
  bool _loadStart=false;
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchProductBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
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
                      onPressed: () => {Navigator.pop(context)},
                      child: SvgPicture.asset(
                        "assets/icons/Back ICon.svg",
                        height: 15,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(20))),
                  Container(
                    width: SizeConfig.screenWidth! * 0.7,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      autofocus: true,
                      onChanged: (value) => {
                        setState(() {
                          _loadStart=true;
                          searchProductBloc
                            ..getSearchProducts("id,desc", value);
                        })
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                              vertical: getProportionateScreenWidth(9)),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Search product",
                          prefixIcon: Icon(Icons.search)),
                    ),
                  )
                ],
              )),
          SizedBox(height: getProportionateScreenHeight(20)),
          _loadStart? StreamBuilder<List<Product>>(
              stream: searchProductBloc.subject.stream,
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingWidget.buildLoadingWidget();
                  }
                  return _buildProductWidget(snapshot.data!);
                } else {
                  return LoadingWidget.buildLoadingWidget();
                }
              }):Container()
        ],
      )),
    );
  }

  Widget _buildProductWidget(List<Product> data) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitleWithOutSeeMore(title: "Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: ScrollPhysics(),
          children: [
            ...List.generate(
              data.length,
              (index) {
                return ProductCard(product: data[index]);
              },
            ),
          ],
        ),
      ],
    );
  }
}
