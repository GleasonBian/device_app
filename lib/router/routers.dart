import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/router/router_handler.dart';
import 'package:flutter_template/views/common/login.dart';

class Routes {
  static String root = "/";
  static String deviceIndex = "/device";
  static String operatorIndex = "/operator";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => Login()
    );

    /// 登录页 / 根路由
    router.define(root, handler: rootHandler);

    /// 设备首页
    router.define(deviceIndex, handler: deviceIndexHandler);

    /// 操作员(司机)首页
    router.define(operatorIndex, handler: operatorIndexHandler);
  }
}
