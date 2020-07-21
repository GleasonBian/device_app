
/// 此文件 非 入口文件
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_template/config/theme.dart';
import 'package:flutter_template/models/main_state_model.dart';
import 'package:flutter_template/router/routers.dart';
import 'package:flutter_template/router/application.dart';
import 'package:flutter_template/views/common/login.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class App extends StatefulWidget {
  // 接收 theme index
  final int themeIndex;
  // 初始化
  App(this.themeIndex);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  MainStateModel mainStateModel;

  @override
  void initState() {
    mainStateModel = MainStateModel();
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainStateModel>(
      model: mainStateModel,
      child: ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
          return FlutterEasyLoading(
            child: MaterialApp(
              debugShowCheckedModeBanner: false, // 去除 DEBUG 标签
              theme: ThemeData(
                platform: TargetPlatform.iOS,
                primaryColor: themeList[model.themeIndex != null
                    ? model.themeIndex
                    : widget.themeIndex],
              ),
              home: Login(),
              onGenerateRoute: Application.router.generator,
            ),
          );
        },
      ),
    );
  }
}
