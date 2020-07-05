import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/router/router_handler.dart';

class Routes {
  static String root = "/";
  static String onePage1 = '/onePage1';
  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String,List<String>> params) {
        // 跳回首页 / 404 页面
        print('page 404');
        return;
      }
    );
    router.define(onePage1, handler:onePage1Handle);
  }
}
