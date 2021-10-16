import 'dart:ffi';

import 'package:ecommerce_customer_app/bloc/AllCategoryListBloc.dart';
import 'package:ecommerce_customer_app/bloc/SubCategoryListBloc.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/model/args/SubCategoryArguments.dart';
import 'package:ecommerce_customer_app/model/response/SubCategory/SubCategoryResponse.dart';
import 'package:ecommerce_customer_app/model/response/category/CategoryListResponse.dart';
import 'package:ecommerce_customer_app/screen/productviewbyid/ProductViewByIdScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'AllCategoryCard.dart';
import 'SubCategoryCard.dart';

class AllCategoriesBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateAllCategoriesBody();
  }
}

class _StateAllCategoriesBody extends State<AllCategoriesBody> {

  int selectIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCategoryListBloc..getCategoryList("id,asc", 0, 100, false);
    subCategoryListBloc..getSubCategoryList("id,asc", 0, 100,1751,false);
  }

  @override
  Widget build(BuildContext context) {

    List<CategoryListResponse> dataList = [];

    return StreamBuilder<bool>(
        stream: allCategoryListBloc.isLoading,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return LoadingWidget.buildLoadingWidget();
          } else {
            return StreamBuilder<List<CategoryListResponse>>(
                stream: allCategoryListBloc.subject.stream,
                builder: (context,
                    AsyncSnapshot<List<CategoryListResponse>> snapshot) {
                  if (snapshot.hasData) {
                    dataList = snapshot.data!;
                    return categoryBody(dataList, context);
                  } else {
                    return LoadingWidget.buildLoadingWidget();
                  }
                });
          }
        });
  }

  Widget categoryBody(List<CategoryListResponse> categories, BuildContext context) {

    return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.only(right: getProportionateScreenWidth(10),left: getProportionateScreenWidth(10),top: getProportionateScreenWidth(10),bottom: getProportionateScreenWidth(50)),
                color: AllCategoryBack,
                child: Column(
                  children: [
                    ...List.generate(
                      categories.length,
                          (index) {
                        return  GestureDetector(
                            onTap: (){
                              setState(() {
                                selectIndex=index;
                                subCategoryListBloc.drainStream();
                                subCategoryListBloc..getSubCategoryList("id,asc", 0, 100,categories[index].id!,false);
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color:selectIndex==index?CategoryBack:AllCategoryBack,
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child: AllCategoryCard(
                                    icon: categories[index].image!,
                                    text: categories[index].name!,
                                    id: categories[index].id!
                                )

                            ));
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              ),
            ),



            Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(10)),
                Container(width:getProportionateScreenWidth(270),child: Center(child:Text("Sub Categories",style: TextStyle(color: kPrimaryColor,fontSize: 16,fontWeight: FontWeight.bold),))),
                SizedBox(height: getProportionateScreenHeight(5)),
                StreamBuilder<bool>(
                    stream: subCategoryListBloc.isLoading,
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data == true) {
                        return Container(
                          width: getProportionateScreenWidth(250),
                          height: getProportionateScreenHeight(250),
                          child: Center(
                            child: LoadingWidget.buildLoadingWidget(),
                          ),
                        );
                      } else {
                        return StreamBuilder<List<SubCategoryResponse>>(
                            stream: subCategoryListBloc.subject.stream,
                            builder: (context,
                                AsyncSnapshot<List<SubCategoryResponse>> snapshot) {
                              if (snapshot.hasData) {
                                return subCategoryList(snapshot.data!);
                              } else {
                                return Container();
                              }
                            });
                      }
                    })
              ],
            )

          ],
        ));
  }

  Widget subCategoryList(List<SubCategoryResponse> list) {
    return Container(
      width: getProportionateScreenWidth(270),
      padding: EdgeInsets.only(
          top: getProportionateScreenHeight(20),
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20)),
      child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: 0.70,
          padding: const EdgeInsets.all(6.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          physics: ScrollPhysics(),
          children: [
            ...List.generate(
              list.length,
                  (index) => SubCategoryCard(
                icon: list[index].image!,
                text: list[index].name!,
                id: list[index].id!,
                press: () {
                  Navigator.pushNamed(context, ProductViewByIdScreen.routeName,arguments: SubCategoryArguments(subCategoryId: list[index].id!));
                },
              ),
            )
          ]),
    );
  }
}
