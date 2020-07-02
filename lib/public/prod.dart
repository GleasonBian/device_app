


import 'package:flutter_template/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/public/config.dart';
void main() {
  var configuredApp = new ENV(
    appName: '设备管理系统',
    envName: 'prod',
    baseUrl: 'http://crcc.sjgtw.com:8090/',
    child: new MyApp(),
  );

  runApp(configuredApp);
}
