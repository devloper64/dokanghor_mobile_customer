
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:rxdart/rxdart.dart';

import '../constants.dart';

class ProductListIdBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<List<Product>> _subject = BehaviorSubject<List<Product>>();
  final BehaviorSubject<bool> _isRefresh = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();

  getProducts(String sort,int page,int size,String param,int id,bool isRefresh) async {
    _isLoading.add(true);
    List<Product> response = await _appRepository.getProductsById(sort,page,size,param,id);
    _subject.sink.add(response);
    _isRefresh.add(isRefresh);
    if(response.isNotEmpty){
      _isLoading.add(false);
    }
    if(response.isEmpty){
      _isLoading.add(false);
    }
  }
  drainStream() {
    _subject.value = [];
  }
  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<Product>> get subject => _subject;
  BehaviorSubject<bool> get isRefresh => _isRefresh;
  BehaviorSubject<bool> get isLoading => _isLoading;
}

final productListIdBloc = ProductListIdBloc();
