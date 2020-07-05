

import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter/material.dart';
void main() {

  var configuredApp = new ENV(
    appName: '设备管理系统',
    envName: 'dev',
    baseUrl: 'https://api.apiopen.top/',
    child: new MyApp(),
  );

  runApp(configuredApp);
}