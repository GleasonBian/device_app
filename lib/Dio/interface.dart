


import 'package:flutter_template/Dio/http.dart';

class Fetch {
  // 登录接口
  static login(params)=> main(url: 'login',type: 'post', data:params);
  /// 获取overview
  static overview(params) => main(url: 'overview',type: 'get', data:params);
  /// 获取overview
  static equipment(params) => main(url: 'overview',type: 'get', data:params);
}