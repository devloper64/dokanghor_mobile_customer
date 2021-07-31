
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/model/response/product_image/ProductImageResponse.dart';
import 'package:ecommerce_customer_app/repository/AppRepository.dart';
import 'package:rxdart/rxdart.dart';

class ProductImagesListBloc{

  final AppRepository _appRepository=AppRepository();
  final BehaviorSubject<List<ProductImageResponse>> _subject = BehaviorSubject<List<ProductImageResponse>>();


  getProductImages(int productId) async {
    List<ProductImageResponse> response = await _appRepository.getProductImages(productId);
    _subject.sink.add(response);

  }
  drainStream() {
    _subject.value = [];
  }
  dispose() {
    _subject.close();
  }
  BehaviorSubject<List<ProductImageResponse>> get subject => _subject;

}

final productImageBloc = ProductImagesListBloc();
