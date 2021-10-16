import 'package:ecommerce_customer_app/model/args/SubCategoryArguments.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ProductViewByIdScreen extends StatelessWidget {
  static String routeName = "/product-view";
  @override
  Widget build(BuildContext context) {
    final SubCategoryArguments agrs = ModalRoute.of(context)!.settings.arguments as SubCategoryArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Products",style: TextStyle(color: Colors.black,fontSize: 15),),
      ),
      body: Body(id: agrs.subCategoryId,),
    );
  }
}
