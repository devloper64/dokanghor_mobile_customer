import 'package:ecommerce_customer_app/bloc/CategoryListBloc.dart';
import 'package:ecommerce_customer_app/screen/home/components/CategoryCard.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/model/response/category/CategoryListResponse.dart';
import 'package:ecommerce_customer_app/screen/categories/AllCategoriesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Categories extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    bool zeroFound=false;
    List<CategoryListResponse> data=[];
    return StreamBuilder<List<CategoryListResponse>>(
        stream: categoryListBloc.subject.stream,
        builder: (context, AsyncSnapshot<List<CategoryListResponse>> snapshot) {
          if (snapshot.hasData) {
            data.clear();
            data = snapshot.data!;
            data.forEach((element) {
              if(element.id==0){
                zeroFound=true;
              }
            });
            if(!zeroFound){
              data.insert(data.length, new CategoryListResponse(id: 0, name: "more", image: "not Found"));
            }
            return body(data,context);
          } else {
            return Container();
          }
        });
  }

  Widget body(List<CategoryListResponse> categories,BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index].image!,
            text: categories[index].name!,
            id: categories[index].id!,
            press: () {
              if(categories[index].id==0){
                Navigator.pushNamed(context, AllCategoriesScreen.routeName);
              }else{
                print("Action");
              }
            },
          ),
        ),
      ),
    );
  }
}


