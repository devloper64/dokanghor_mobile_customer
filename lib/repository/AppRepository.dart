import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_customer_app/model/body/gmaillogin/GmailLoginBody.dart';
import 'package:ecommerce_customer_app/model/body/login/LoginBody.dart';
import 'package:ecommerce_customer_app/model/body/phonelogin/PhoneLoginBody.dart';
import 'package:ecommerce_customer_app/model/body/sign-up/SignUpBody.dart';
import 'package:ecommerce_customer_app/model/response/SubCategory/SubCategoryResponse.dart';
import 'package:ecommerce_customer_app/model/response/intro/IntroResponse.dart';
import 'package:ecommerce_customer_app/model/response/login/LoginResponse.dart';
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/model/response/product_image/ProductImageResponse.dart';
import 'package:ecommerce_customer_app/model/response/producttype/ProductTypeResponse.dart';
import 'package:ecommerce_customer_app/model/response/sign-up/SignUpCustom.dart';
import 'package:ecommerce_customer_app/model/response/category/CategoryListResponse.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';
import 'DioExceptions.dart';

class AppRepository{

  static String baseUrl="https://dokanghor.herokuapp.com/api";
  final Dio _dio = Dio();
  var getIntroUrl = '$baseUrl/getMobileIntros';
  var productsList= '$baseUrl/productsList';
  var productImages= '$baseUrl/product_images_by_product_id';
  var registerUrl= '$baseUrl/register';
  var loginUrl= '$baseUrl/authenticate';
  var gmailLoginUrl= '$baseUrl/gmail-login';
  var phoneLoginUrl= '$baseUrl/phone-login';
  var categoryListUrl= '$baseUrl/categoryList';
  var subCategoryListUrl= '$baseUrl/subCategoriesList';
  var productTypeUrl= '$baseUrl/getAllProductTypes';


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


  Future <List<Product>> getProductsById(String sort,int page,int size,String param,int id) async{
    Response response = await _dio.get(productsList+"?sort=$sort&page=$page&size=$size&$param=$id");
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


  Future <List<CategoryListResponse>> getCategories(String sort,int page,int size) async{
    Response response = await _dio.get(categoryListUrl+"?sort=$sort&page=$page&size=$size");
    if(response.statusCode==200){
      print("get product Api Success");
      return (response.data as List)
          .map((value) => CategoryListResponse.fromJson(value))
          .toList();
    }else{
      var code=response.statusCode;
      throw Exception('Failed to load jobs from API $code');
    }
  }



  Future <List<SubCategoryResponse>> getSubCategoryList(String sort,int page,int size,int categoryId) async{
    try{
      Response response = await _dio.get(subCategoryListUrl+"?sort=$sort&page=$page&size=$size&categoryId.equals=$categoryId");
        print("get subCategory Api Success:"+categoryId.toString());
        return (response.data as List)
            .map((value) => SubCategoryResponse.fromJson(value))
            .toList();
    }catch(e){
      final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
      print(errorMessage);
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      throw Exception('Failed to load jobs from API $e');
    }
  }


  Future <List<ProductTypeResponse>> getProductType(int subCategoryId) async{
    try{
      Response response = await _dio.get(productTypeUrl+"?subCategoryId.equals=$subCategoryId");
      print("get ProductType Api Success:"+subCategoryId.toString());
      return (response.data as List)
          .map((value) => ProductTypeResponse.fromJson(value))
          .toList();
    }catch(e){
      final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
      print(errorMessage);
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      throw Exception('Failed to load jobs from API $e');
    }
  }




  Future<SignUpCustom> register(SignUpBody signUpBody) async{

    try{
     Response response = await _dio.post(registerUrl,data: signUpBody.toJson());
     if(response.statusCode==201){
       return SignUpCustom(message: "Register Success",code: response.statusCode);
     }else{
       return SignUpCustom(message: "Something Wrong",code: response.statusCode);
     }

    }catch(e){
      final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
      print(errorMessage);
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);

      return SignUpCustom(message: "Something Wrong",code: e.response!.statusCode);
    }


  }

  Future<LoginResponse> login(LoginBody loginBody) async{

    try{
      Response response = await _dio.post(loginUrl,data: loginBody.toJson());
      return LoginResponse.fromJson(response.data);
    }catch(e){
      final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
      print(errorMessage);
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);

      return LoginResponse(id_token: "");

    }


  }


  Future<LoginResponse> loginGmail(GmailLoginBody gmailLoginBody) async{

    try{
      Response response = await _dio.post(gmailLoginUrl,data: gmailLoginBody.toJson());
      return LoginResponse.fromJson(response.data);
    }catch(e){
      final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
      print(errorMessage);
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);

      return LoginResponse(id_token: "");

    }


  }


  Future<LoginResponse> loginPhone(PhoneLoginBody phoneLoginBody) async{

    try{
      Response response = await _dio.post(phoneLoginUrl,data: phoneLoginBody.toJson());
      return LoginResponse.fromJson(response.data);
    }catch(e){
      final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
      print(errorMessage);
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);

      return LoginResponse(id_token: "");

    }


  }




}