import 'dart:async';
import 'dart:ffi';
import 'package:connectivity_plus/connectivity_plus.dart';
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

  late StreamSubscription<ConnectivityResult> subscription;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentStatus();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result==ConnectivityResult.none){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No Internet Connection!'),
          duration:  Duration(seconds: 100),
        ));
      }else if(result==ConnectivityResult.mobile){
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);

      } else if(result==ConnectivityResult.wifi){
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }

    });
    productBloc.drainStream();
  }


  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  Future _refresh() async{
    await Future.delayed(Duration(seconds: 3));
    productBloc..getProducts("id,desc",0,30,true);
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

  currentStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult==ConnectivityResult.none){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No Internet Connection!'),
          duration: Duration(seconds: 100),
        ));
      }

  }


  
}
