
import 'package:ecommerce_customer_app/model/hive/Cart.dart';
import 'package:ecommerce_customer_app/model/response/intro/IntroResponse.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class CartPriceBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<double> _subject = BehaviorSubject<double>();


  getAmount() async {
    final box = await Hive.openBox<Cart>('cart');
    List<Cart> listCart=box.values.toList();
    double amount=0;
    listCart.forEach((element) {
      amount+=(double.parse(element.amount)*int.parse(element.quantity));
    });
    subject.sink.add(amount);
  }



  dispose() {
    _subject.close();
  }
  BehaviorSubject<double> get subject => _subject;

}

final cartPriceBloc = CartPriceBloc();
