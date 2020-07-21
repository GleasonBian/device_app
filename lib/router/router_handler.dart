

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_template/views/common/login.dart';
import 'package:flutter_template/views/device/index.dart';
import 'package:flutter_template/views/operator/index.dart';

/**
 * @date: 2020/7/16 10:36
 * @author: Gleason
 * @content: 路由跳转 带参示范
 */
//var onePage1Handler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//  String message = params["message"]?.first;
//  String colorHex = params["color_hex"]?.first;
//  String result = params["result"]?.first;
//  Color color = Color(0xFFFFFFFF);
//  if (colorHex != null && colorHex.length > 0) {
//    color = Color(ColorHelpers.fromHexString(colorHex));
//  }
//  return Login(param1,param2,param3);
//});

/**
 * @date: 2020/7/16 10:35
 * @author: Gleason
 * @content: 登录页 / 根路由
 */
var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) => Login()
);

/**
 * @date: 2020/7/16 10:36
 * @author: Gleason
 * @content: 设备首页
 */
var deviceIndexHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) => deviceIndexPage()
);

/**
 * @date: 2020/7/21 10:55
 * @author: Gleason
 * @content: 操作员(司机首页)
 */
var operatorIndexHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) => operatorIndexPage()
);





