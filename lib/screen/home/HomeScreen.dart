import 'dart:ffi';

import 'package:ecommerce_customer_app/bloc/ProductListBloc.dart';
import 'package:ecommerce_customer_app/components/coustom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {

  static String routeName = "/home";
  @override
  State<StatefulWidget> createState() {
   return _StateHomeScreen();
  }
}

class _StateHomeScreen  extends State<HomeScreen>{



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productBloc..getProducts("id,desc",0,6);
  }

  Future _refresh() async{
    await Future.delayed(Duration(seconds: 3));
    productBloc..getProducts("id,desc",0,6);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: RefreshIndicator(
        child: Body(),
        onRefresh: _refresh,
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
  
}
