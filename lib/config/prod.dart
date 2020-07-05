

import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter/material.dart';
void main() {
  var configuredApp = new ENV(
    appName: 'app 名称',
    envName: 'prod',
    baseUrl: 'http://crcc.sjgtw.com:8090/',
    child: new MyApp(),
  );

  runApp(configuredApp);
}
