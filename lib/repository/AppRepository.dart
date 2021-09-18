import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_customer_app/model/response/intro/IntroResponse.dart';
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/model/response/product_image/ProductImageResponse.dart';

import '../constants.dart';

class AppRepository{

  static String baseUrl="https://dokanghor.herokuapp.com/api";
  final Dio _dio = Dio();
  var getIntroUrl = '$baseUrl/getMobileIntros';
  var productsList= '$baseUrl/productsList';
  var productImages= '$baseUrl/product_images_by_product_id';

  Future <List<IntroResponse>> getIntros() async{

      Response response = await _dio.get(getIntroUrl);
      if(response.statusCode==200){
        print("Intro Api Success");
        return (response.data as List)
            .map((value) => IntroResponse.fromJson(value))
            .toList();
      }else{
        var code=response.statusCode;
        throw Exception('Failed to load jobs from API $code');
      }
  }


  Future <List<Product>> getProducts(String sort,int page,int size) async{
    Response response = await _dio.get(productsList+"?sort=$sort&page=$page&size=$size");
    if(response.statusCode==200){
      print("get product Api Success");
      return (response.data as List)
          .map((value) => Product.fromJson(value))
          .toList();
    }else{
      var code=response.statusCode;
      throw Exception('Failed to load jobs from API $code');
    }
  }

  Future <List<Product>> getSearchProducts(String sort,String query) async{
    Response response = await _dio.get(productsList+"?sort=$sort&name.contains=$query");
    if(response.statusCode==200){
      print("get product Search Api Success");
      return (response.data as List)
          .map((value) => Product.fromJson(value))
          .toList();
    }else{
      var code=response.statusCode;
      throw Exception('Failed to load jobs from API $code');
    }
  }


  Future <List<ProductImageResponse>> getProductImages(int productId) async{

    Response response = await _dio.get(productImages+'/$productId');
    if(response.statusCode==200){
      print("get product image api Success");
      return (response.data as List)
          .map((value) => ProductImageResponse.fromJson(value))
          .toList();
    }else{
      var code=response.statusCode;
      throw Exception('Failed to load jobs from API $code');
    }
  }


}