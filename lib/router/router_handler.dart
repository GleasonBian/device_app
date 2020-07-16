

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_template/index.dart';
import 'package:flutter_template/pages/login.dart';
import 'package:flutter_template/pages/one/one_page_1.dart';
/**
 * @date: 2020/7/16 10:36
 * @author: Gleason
 * @content: 路由跳转 带参示范
 */
var onePage1Handler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String message = params["message"]?.first;
  String colorHex = params["color_hex"]?.first;
  String result = params["result"]?.first;
  Color color = Color(0xFFFFFFFF);
  if (colorHex != null && colorHex.length > 0) {
//    color = Color(ColorHelpers.fromHexString(colorHex));
  }
  return OnePage1(message: message, color: color, result: result);
});

/**
 * @date: 2020/7/16 10:35
 * @author: Gleason
 * @content: 登录页 / 根路由
 */
var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Login();
    },
);

/**
 * @date: 2020/7/16 10:36
 * @author: Gleason
 * @content: 首页
 */
var indexHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return IndexPage();
  },
);





