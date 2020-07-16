import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/pages/login.dart';
import 'package:flutter_template/router/router_handler.dart';

class Routes {
  static String root = "/";
  static String demoSimple = "/demo";
  static String index = "/index";
  static String demoSimpleFixedTrans = "/demo/fixedtrans";
  static String demoFunc = "/demo/func";
  static String deepLink = "/message";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return Login();
        });
    router.define(root, handler: rootHandler);
    router.define(index, handler: indexHandler);
    router.define(demoSimple, handler: onePage1Handler);
//    router.define(demoSimpleFixedTrans, handler: onePage1, transitionType: TransitionType.inFromLeft);
//    router.define(demoFunc, handler: demoFunctionHandler);
//    router.define(deepLink, handler: deepLinkHandler);
  }
}