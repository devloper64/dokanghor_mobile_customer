import 'package:ecommerce_customer_app/bloc/ProductListBloc.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/components/product_card.dart';
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/screen/home/components/section_title_without_see_more.dart';
import 'package:flutter/material.dart';
import '../../../golbal.dart';
import '../../../size_config.dart';

class PopularProducts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopularProductsState();
  }
}

class _PopularProductsState extends State<PopularProducts> {
  List<Product>? items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: productBloc.isRefresh.stream,
        builder: (context, AsyncSnapshot<bool> snapshot1) {
          if (snapshot1.data == true) {
            items!.clear();
            productBloc.drainStream();
            productPage = 0;
          }
          return StreamBuilder<List<Product>>(
              stream: productBloc.subject.stream,
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingWidget.buildLoadingWidget();
                  }
                  items!.addAll(snapshot.data!);
                  return _buildProductWidget(items!);
                } else {
                  return LoadingWidget.buildLoadingWidget();
                }
              });
        });
  }

  Widget _buildProductWidget(List<Product> data) {
    return data.isNotEmpty?Column(
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
        StreamBuilder<bool>(
            stream: productBloc.isLoading.stream,
            builder: (context, AsyncSnapshot<bool> snapshot1) {
              if (snapshot1.data == true) {
                return LoadingWidget.buildLoadingWidget();
              } else {
                return Center(
                  child: SizedBox(width: getProportionateScreenWidth(20)),
                );
              }
            }),
      ],
    ):LoadingWidget.buildLoadingWidget();
  }
}
