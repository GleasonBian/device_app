
import 'package:flutter_template/public/http.dart';

class Fetch {
  // 登录接口
  static login(params)=> main(url: 'login',type: 'post', data:params);
  /// 获取网易新闻
  static getWangYiNews(params) => main(url: 'getWangYiNews',type: 'post', data: params);
}