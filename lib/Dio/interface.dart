


import 'package:flutter_template/Dio/http.dart';

class Fetch {
  // 登录接口
  static login(params)=> main(url: 'login',type: 'post', data:params);
  /// 获取网易新闻
  static getWangYiNews(params) => main(url: 'getWangYiNews',type: 'post', data: params);
  /// 段子详情
  static getSingleJoke(params) => main(url: 'getSingleJoke',type: 'get', data: params);
}