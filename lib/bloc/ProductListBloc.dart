
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:rxdart/rxdart.dart';

class ProductListBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<List<Product>> _subject = BehaviorSubject<List<Product>>();


  getProducts(String sort,int page,int size) async {
    List<Product> response = await _appRepository.getProducts(sort,page,size);
    _subject.sink.add(response);
  }
  dispose() {
    _subject.close();
  }
  BehaviorSubject<List<Product>> get subject => _subject;

}

final productBloc = ProductListBloc();
