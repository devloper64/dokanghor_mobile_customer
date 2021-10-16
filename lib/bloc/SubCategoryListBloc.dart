import 'package:ecommerce_customer_app/model/response/SubCategory/SubCategoryResponse.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:rxdart/rxdart.dart';

import '../constants.dart';

class SubCategoryListBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<List<SubCategoryResponse>> _subject = BehaviorSubject<List<SubCategoryResponse>>();
  final BehaviorSubject<bool> _isRefresh = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();

  getSubCategoryList(String sort,int page,int size,int categoryId,bool isRefresh) async {
    _isLoading.add(true);
    List<SubCategoryResponse> response = await _appRepository.getSubCategoryList(sort,page,size,categoryId);
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

  BehaviorSubject<List<SubCategoryResponse>> get subject => _subject;
  BehaviorSubject<bool> get isRefresh => _isRefresh;
  BehaviorSubject<bool> get isLoading => _isLoading;
}

final subCategoryListBloc = SubCategoryListBloc();
