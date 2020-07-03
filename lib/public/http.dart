import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_template/public/config.dart';

final dio = Dio(BaseOptions(
  baseUrl: ENV.baseUrl,
  connectTimeout: 5000,
  receiveTimeout: 100000,
  contentType:"application/json; charset=utf-8",
));

Future main({String url = '', String type = "get", dynamic data}) async {
  type = type.toUpperCase();
  print('请求参数: url:$url,type:$type,body:$data');
  if (type == 'POST') {
    Response response;
    await dio.post(url,data: data).then((res) {
      response = res;
      print("$url: ------>$res");
    }).catchError((err) => throw Exception("$url: ----->$err"));
    return response.data;
  }
  if (type == "Get"){

  }
}
