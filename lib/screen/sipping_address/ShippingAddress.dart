
import 'package:flutter/material.dart';

import 'components/Body.dart';



class ShippingAddressScreen extends StatelessWidget {
  static String routeName = "/shipping-address";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body()
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Shipping Address",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
