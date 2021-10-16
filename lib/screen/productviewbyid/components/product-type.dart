import 'package:ecommerce_customer_app/bloc/ProductListIdBloc.dart';
import 'package:ecommerce_customer_app/bloc/ProductTypeBloc.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/constants.dart';
import 'package:ecommerce_customer_app/model/response/producttype/ProductTypeResponse.dart';
import 'package:flutter/cupertino.dart';

import '../../../size_config.dart';

class ProductType extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateProductType();
  }
}

class _StateProductType extends State<ProductType> {
  int selectIndex = -1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: productTypeBloc.isLoading,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return Container();
          } else {
            return StreamBuilder<List<ProductTypeResponse>>(
                stream: productTypeBloc.subject.stream,
                builder: (context,
                    AsyncSnapshot<List<ProductTypeResponse>> snapshot) {
                  if (snapshot.hasData) {
                    return productType(snapshot.data!, context);
                  } else {
                    return Container();
                  }
                });
          }
        });
  }

  Widget productType(List<ProductTypeResponse> types, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: getProportionateScreenWidth(10),
          left: getProportionateScreenWidth(20)),
      child:  GridView.count(
          crossAxisCount: 6,
          shrinkWrap: true,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          physics: ScrollPhysics(),
          children: [
            ...List.generate(
              types.length,
              (index) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIndex = index;
                         productListIdBloc.drainStream();
                         productListIdBloc..getProducts("id,desc",0,130,"productTypeId.equals",types[index].id!,true);
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: selectIndex == index
                              ? kPrimaryColor
                              : AllCategoryBack,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(child:Text(types[index].name!)),

                    )
                );
              },
            ),
          ],
        ),

    );
  }
}
