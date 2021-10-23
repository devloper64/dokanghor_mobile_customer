import 'package:ecommerce_customer_app/bloc/CartBloc.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/components/default_button.dart';
import 'package:ecommerce_customer_app/components/default_buttonCart.dart';
import 'package:ecommerce_customer_app/constants.dart';
import 'package:ecommerce_customer_app/golbal.dart';
import 'package:ecommerce_customer_app/model/hive/Cart.dart';
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import '../../../../size_config.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cartListBloc..getCarts();
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnFeedBack: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth! * 0.15,
                            right: SizeConfig.screenWidth! * 0.15,
                            bottom: getProportionateScreenWidth(40),
                            top: getProportionateScreenWidth(15),
                          ),
                          child: StreamBuilder<List<Cart>>(
                              stream: cartListBloc.subject.stream,
                              builder: (context,
                                  AsyncSnapshot<List<Cart>> snapshot) {
                                if (snapshot.hasData) {
                                  var inCart = false;
                                  List<Cart> listCart = snapshot.data!;
                                  listCart.forEach((element) {
                                    if (product.id == element.productId) {
                                      inCart = true;
                                    }
                                  });

                                  return DefaultButtonCart(
                                    color: inCart? kDisableButtonColor:kPrimaryColor,
                                    text: inCart
                                        ? "Already In Cart"
                                        : "Add To Cart",
                                    press: () async {
                                      if (!inCart) {
                                        print(
                                            '$globalColor $globalSize $globalQuantity');
                                        var box =
                                            await Hive.openBox<Cart>('cart');
                                        box.add(Cart(
                                            productId: product.id!,
                                            productName: product.name!,
                                            amount: (product.price! -
                                                    product.discount_amount!)
                                                .toString(),
                                            quantity: globalQuantity,
                                            productImage: product.image!));
                                        cartListBloc..getCarts();
                                      }else{
                                        Fluttertoast.showToast(
                                            textColor: Colors.red,
                                            msg: "Already In Cart",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM);
                                      }
                                    },
                                  );
                                } else {
                                  return LoadingWidget.buildLoadingWidget();
                                }
                              })),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
