import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
///
/// 项目中 通过 ENV 获取环境变量
///
class ENV extends InheritedWidget {
  static String appName; // 系统名称
  static String envName; // 运行环境
  static String baseUrl; // 基础url

  ENV({
    @required String appName,
    @required String envName,
    @required String baseUrl,
    @required Widget child,
  }) : super(child: child){
    ENV.appName = appName;
    ENV.envName = envName;
    ENV.baseUrl = baseUrl;
  }

  static ENV of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: ENV);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}