
/// 项目入口文件

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/index.dart';
import 'package:flutter_template/router/routers.dart';
import 'package:flutter_template/router/application.dart';

import 'package:flutter_template/pages/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 在任何地方调用AppConfig.of（context）以获取特定于环境的配置
    //var config = AppConfig.of(context);
    // 初始化 fluro
    final  router = Router();
    Routes.configureRoutes(router);
    // 路由静态化
    Application.router = router;
    return new MaterialApp(
      title: ENV.appName,
      onGenerateRoute: Application.router.generator,
      home: Login(),
    );
  }
}

