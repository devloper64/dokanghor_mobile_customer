
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:rxdart/rxdart.dart';

import '../constants.dart';

class SearchProductListBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<List<Product>> _subject = BehaviorSubject<List<Product>>();
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();

  getSearchProducts(String sort,String query) async {
    _isLoading.add(true);
    List<Product> response = await _appRepository.getSearchProducts(sort,query);
    _subject.sink.add(response);
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
  BehaviorSubject<bool> get isLoading => _isLoading;
}

final searchProductBloc = SearchProductListBloc();
