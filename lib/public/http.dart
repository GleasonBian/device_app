
/// 这里封装的 请求方法 支持 restful 规范
import 'package:dio/dio.dart';
import 'package:flutter_template/public/config.dart';

final dio = Dio(BaseOptions(
  baseUrl: ENV.baseUrl,
  connectTimeout: 5000,
  receiveTimeout: 100000,
  contentType:"application/json; charset=utf-8",
));

Future main({String url = '', String type = "get", Map<String,dynamic>data}) async {
  type = type.toUpperCase();
  data.containsKey('id') ? url = url + '/' + data['id'] : url = url;
  print('请求参数: url:$url,type:$type,body:$data');
  /**
   * @date: 2020/7/3
   * @author: Gleason
   * @content: post 请求
   */
  if (type == 'POST') {
    Response response;
    await dio.post(url,data: data).then((res) {
      response = res;
      print("$url: ------>$res");
    }).catchError((err) => throw Exception("$url: ----->$err"));
    return response.data;
  }

  /**
   * @date: 2020/7/3
   * @author: Gleason
   * @content: get 请求
   */
  if (type == "GET"){
    List getParams = [];
    // ignore: unnecessary_statements

    if (data.containsKey('param')) {
      data['param'].forEach((k,v)=> getParams.add("$k=$v"));
      String str =  getParams.join('&');
      url += '?' + str;
    }
    Response response;
    await dio.get(url).then((res) {
      response = res;
      print("$url: ------>$res");
    }).catchError((err) => throw Exception("$url: ----->$err"));
    return response.data;
  }

  /**
   * @date: 2020/7/3
   * @author: Gleason
   * @content: put 请求
   */
  if(type == "PUT") {
    Response response;
    await dio.put(url,data:data).then((res) {
      response = res;
      print("$url: ------>$res");
    }).catchError((err) => throw Exception("$url: ----->$err"));
    return response.data;
  }

  /**
   * @date: 2020/7/3 16:07
   * @author: Gleason
   * @content: delete 请求
   */
  if (type == "DELETE") {
    Response response;
    await dio.delete(url,data:data).then((res) {
      response = res;
      print("$url: ------>$res");
    }).catchError((err) => throw Exception("$url: ----->$err"));
    return response.data;
  }
}
