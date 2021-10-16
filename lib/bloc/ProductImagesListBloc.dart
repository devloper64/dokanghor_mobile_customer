
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/model/response/product_image/ProductImageResponse.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:rxdart/rxdart.dart';

class ProductImagesListBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<List<ProductImageResponse>> _subject = BehaviorSubject<List<ProductImageResponse>>();
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();


  getProductImages(int productId) async {
    _isLoading.add(true);
    List<ProductImageResponse> response = await _appRepository.getProductImages(productId);
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
    _isLoading.close();
  }
  BehaviorSubject<List<ProductImageResponse>> get subject => _subject;
  BehaviorSubject<bool> get isLoading => _isLoading;


}

final productImageBloc = ProductImagesListBloc();
