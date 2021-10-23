import 'package:ecommerce_customer_app/bloc/CartPriceBloc.dart';
import 'package:ecommerce_customer_app/components/rounded_icon_btn.dart';
import 'package:ecommerce_customer_app/model/hive/Cart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cart,
    required this.index,
  }) : super(key: key);

  final Cart cart;
  final int index;

  @override
  State<StatefulWidget> createState() {
    return _StateCartCard(cart: cart, index: index);
  }

}

class _StateCartCard extends State<CartCard> {
   _StateCartCard({
    required this.cart,
     required this.index,
  });

  final Cart cart;
  final int index;

  int quantity=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity=int.parse(cart.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(88),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(cart.productImage),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: getProportionateScreenWidth(220),
              child: Text(
                cart.productName,
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
            ),
            SizedBox(height: 10),
            Row(children: [

              Text(
                "\$${cart.amount}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),

              Text(" x$quantity",
                  style: Theme.of(context).textTheme.bodyText1),
              SizedBox(width: 10,),
              RoundedIconBtn(
                icon: Icons.add,
                showShadow: true,
                press: () {
                  setState(() {
                    if(quantity<5){
                      quantity++;
                      updateBox();
                      cartPriceBloc.getAmount();
                    }
                  });
                },

              ),
              SizedBox(width: 10,),
              RoundedIconBtn(
                showShadow: true,
                icon: Icons.remove,
                press: () {
                  setState(() {
                    if(quantity>1){
                      quantity--;
                      updateBox();
                      cartPriceBloc.getAmount();
                    }
                  });
                },
              ),
            ])
          ],
        )
      ],
    );
  }

   updateBox() async {
     final box = await Hive.openBox<Cart>('cart');
     Cart cartUpdate=new Cart(productId: cart.productId, productName: cart.productName, amount: cart.amount, quantity: quantity.toString(), productImage: cart.productImage);
     box.putAt(index, cartUpdate);
   }
}
