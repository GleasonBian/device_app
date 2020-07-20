

import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/models/theme_state_model.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  int themeIndex = await ThemeStateModel.getTheme();
  var configuredApp = new ENV(
    appName: 'app 名称',
    envName: 'prod',
    baseUrl: 'http://crcc.sjgtw.com:8090/',
    child: new App(themeIndex),
  );

  runApp(configuredApp);
}
