import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:ecommerce_customer_app/model/response/category/CategoryListResponse.dart';
import 'package:rxdart/rxdart.dart';

import '../constants.dart';

class CategoryListBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<List<CategoryListResponse>> _subject = BehaviorSubject<List<CategoryListResponse>>();
  final BehaviorSubject<bool> _isRefresh = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();

  getCategoryList(String sort,int page,int size,bool isRefresh) async {
    _isLoading.add(true);
    List<CategoryListResponse> response = await _appRepository.getCategories(sort,page,size);
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

  BehaviorSubject<List<CategoryListResponse>> get subject => _subject;
  BehaviorSubject<bool> get isRefresh => _isRefresh;
  BehaviorSubject<bool> get isLoading => _isLoading;
}

final categoryListBloc = CategoryListBloc();
