import 'package:ecommerce_customer_app/components/coustom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {

  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
