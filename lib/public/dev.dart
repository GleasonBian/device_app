

import 'package:flutter_template/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/public/config.dart';
void main() {

  var configuredApp = new ENV(
    appName: '设备管理系统',
    envName: 'dev',
    baseUrl: 'https://dev.com/',
    child: new MyApp(),
  );

  runApp(configuredApp);
}