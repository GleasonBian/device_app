
/// 这里封装的 请求方法 支持 restful 规范
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/public/local_store.dart';

final dio = Dio(BaseOptions(
  baseUrl: ENV.baseUrl,
  connectTimeout: 2000,
  receiveTimeout: 100000,
  contentType:"application/json; charset=utf-8",
));

tokenInter(){
  dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options){
        // 在发送请求之前做一些预处理
        // 我这边是在发送前到SharedPreferences（本地存储）中取出token的值，然后添加到请求头中
        // dio.lock()是先锁定请求不发送出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去
        dio.lock();
        Future<dynamic> future = Future(()async{
          Future<String> result = LocalStore.getString('Authorization');
          return result;
        });
        return future.then((value) {
          if (value != null)  options.headers["Authorization"] = value;
          return options;
        }).whenComplete(() => dio.unlock()); // unlock the dio
      },
      onResponse:(Response response) async{
        // 在返回响应数据之前做一些预处理

        LocalStore.setString('Authorization',"${response.headers["Authorization"]}");
        return response; // continue
      },
      onError: (DioError e) {
        // 当请求失败时做一些预处理
        EasyLoading.showError('Dio 错误!');
        return e;//continue
      }
  ));
}

Future main({String url = '', String type = "get", Map<String,dynamic>data, Loading = true,}) async {
  Loading ? EasyLoading.show(status: 'loading...'):'';
  // 添加请求 token
  tokenInter();
  // 将请求类型 转为 大写
  type = type.toUpperCase();
  // 打印请求参数
  print('请求参数: url:$url,type:$type,body:$data');
  // 请求参数转换, 为 restful 使用
    data.containsKey('id') ? url = url + '/' + data['id'] : url = url;

  /**
   * @date: 2020/7/3
   * @author: Gleason
   * @content: post 请求
   */
  if (type == 'POST') {
    Response response;
    await dio.post(url,data: data).then((res) {
      response = res;
    }).catchError((err) => throw Exception("$url: ----->$err"));
    EasyLoading.dismiss();
    return response.data;

  }

  /**
   * @date: 2020/7/3
   * @author: Gleason
   * @content: get 请求
   */
  if (type == "GET"){
    List getParams = [];
    if (data !=null && data.containsKey('param')) {
      data['param'].forEach((k,v)=> getParams.add("$k=$v"));
      String str =  getParams.join('&');
      url += '?' + str;
    }
    Response response;
    await dio.get(url).then((res) {
      response = res;
    }).catchError((err) => throw Exception("$url: ----->$err"));
    EasyLoading.dismiss();
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
    }).catchError((err) => throw Exception("$url: ----->$err"));
    EasyLoading.dismiss();
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
    }).catchError((err) => throw Exception("$url: ----->$err"));
    EasyLoading.dismiss();
    return response.data;
  }
}




