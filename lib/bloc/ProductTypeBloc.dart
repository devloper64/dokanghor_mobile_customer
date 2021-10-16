import 'package:ecommerce_customer_app/model/response/producttype/ProductTypeResponse.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:rxdart/rxdart.dart';

import '../constants.dart';

class ProductTypeBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<List<ProductTypeResponse>> _subject = BehaviorSubject<List<ProductTypeResponse>>();
  final BehaviorSubject<bool> _isRefresh = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();

  getProductTypes(int subCategoryId,bool isRefresh) async {
    _isLoading.add(true);
    List<ProductTypeResponse> response = await _appRepository.getProductType(subCategoryId);
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

  BehaviorSubject<List<ProductTypeResponse>> get subject => _subject;
  BehaviorSubject<bool> get isRefresh => _isRefresh;
  BehaviorSubject<bool> get isLoading => _isLoading;
}

final productTypeBloc = ProductTypeBloc();
