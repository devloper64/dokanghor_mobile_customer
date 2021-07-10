import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_customer_app/model/reponse/intro/IntroResponse.dart';

class AppRepository{

  static String baseUrl="https://dokanghor.herokuapp.com/api";
  final Dio _dio = Dio();
  var getIntroUrl = '$baseUrl/getMobileIntros';


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


}