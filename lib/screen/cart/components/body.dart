import 'package:ecommerce_customer_app/model/hive/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {


  List<Cart> listCart = [];

  void getCarts() async {
    final box = await Hive.openBox<Cart>('cart');
    setState(() {
      listCart = box.values.toList();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCarts();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: listCart.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(listCart[index].productId.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async {
              final box = await Hive.openBox<Cart>('cart');
              box.deleteAt(index);
              setState(()  {
                listCart.removeAt(index);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cart: listCart[index],index: index,),
          ),
        ),
      ),
    );
  }
}
