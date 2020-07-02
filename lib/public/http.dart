import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_template/public/config.dart';

final dio = Dio(BaseOptions(
  baseUrl: ENV.baseUrl,
  connectTimeout: 5000,
  receiveTimeout: 100000,
  contentType:"application/json; charset=utf-8",
));

Future main({String url = '', String type = "get", dynamic body}) async {
  type = type.toUpperCase();
  print('请求参数: url:$url,type:$type,body:$body');
  if (type == 'POST') {

//     await dio.(url).then((value) => value).catchError((e)=>e);
    Response response = await dio.post(url,data: body);
    return response.data;
  }
}
/*
class fetch{
  String url='url';
  String type="get";
  Map<String,dynamic> body;

    factory fetch({ String url='url', String type="get", Map<String,dynamic> body}){
      return
    }
}*/
