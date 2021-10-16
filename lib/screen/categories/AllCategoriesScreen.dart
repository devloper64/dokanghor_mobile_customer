import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/AllCategoriesBody.dart';

class AllCategoriesScreen extends StatelessWidget{


  static String routeName = "/all_category";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories",style: TextStyle(color: Colors.black,fontSize: 14),),
      ),
      body: AllCategoriesBody(),
    );
  }

}