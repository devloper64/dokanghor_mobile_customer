import 'package:ecommerce_customer_app/bloc/ProductListBloc.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/components/product_card.dart';
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/screen/home/components/section_title_without_see_more.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class PopularProducts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PopularProductsState();
  }
}


class _PopularProductsState extends State<PopularProducts> {

  late int _page;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _page=0;
    productBloc..getProducts("id,desc",_page,6);
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: productBloc.subject.stream,
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return _buildProductWidget(snapshot.data!);
          }else{
            return LoadingWidget.buildLoadingWidget();
          }
        }
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
            SizedBox(width: getProportionateScreenWidth(20)),
          ],
        )
      ],
    );
  }
}
