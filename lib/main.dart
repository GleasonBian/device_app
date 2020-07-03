
/// 项目入口文件

import 'package:flutter/material.dart';

import 'package:flutter_template/index.dart';
import 'package:flutter_template/public/config.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 在任何地方调用AppConfig.of（context）以获取特定于环境的配置
    //var config = AppConfig.of(context);

    return new MaterialApp(
      title: ENV.appName,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new IndexPage(),
    );
  }
}

