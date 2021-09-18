import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: Body(),
    );
  }
}
