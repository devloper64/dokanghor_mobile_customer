import 'package:ecommerce_customer_app/bloc/ProductListIdBloc.dart';
import 'package:ecommerce_customer_app/bloc/ProductTypeBloc.dart';
import 'package:ecommerce_customer_app/screen/productviewbyid/components/popular_product.dart';
import 'package:ecommerce_customer_app/screen/productviewbyid/components/product-type.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';


class Body extends StatefulWidget{
 final int id;
 Body({required this.id});
  @override
  State<StatefulWidget> createState() {
    return _BodyState(id: id);
  }
}

class _BodyState  extends State<Body> {

  final int id;
  _BodyState({required this.id});

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // productListIdBloc.drainStream();
    productListIdBloc..getProducts("id,desc",0,130,"subCategoryId.equals",id,true);
    productTypeBloc..getProductTypes(id, true);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
           children: [
             SizedBox(height: getProportionateScreenHeight(21)),
             ProductType(),
             SizedBox(height: getProportionateScreenHeight(20)),
             PopularProducts()
           ],
        ),
      ),
    );
  }
}
