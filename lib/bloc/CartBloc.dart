
import 'package:ecommerce_customer_app/model/hive/Cart.dart';
import 'package:ecommerce_customer_app/model/response/intro/IntroResponse.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class CartListBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<List<Cart>> _subject = BehaviorSubject<List<Cart>>();


  getCarts() async {
    final box = await Hive.openBox<Cart>('cart');
    _subject.sink.add(box.values.toList());
  }



  dispose() {
    _subject.close();
  }
  BehaviorSubject<List<Cart>> get subject => _subject;

}

final cartListBloc = CartListBloc();
