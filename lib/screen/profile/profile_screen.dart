import 'package:ecommerce_customer_app/components/coustom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../../SharedPrefsHelper.dart';
import '../../enums.dart';
import '../../golbal.dart';
import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  @override
  State<StatefulWidget> createState() {
    return _StateProfileScreen();
  }





}

class _StateProfileScreen extends State<ProfileScreen>{

  String token="";

  _StateProfileScreen(){
    getUserToken().then((value) =>
        setState(() {
          token = value;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body:  Body(token: token,),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }

}
