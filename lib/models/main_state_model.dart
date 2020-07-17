


import 'package:flutter_template/models/save_pwd_model.dart';
import 'package:flutter_template/models/theme_state_model.dart';
/**
 * 主数据模型，需要全局使用的数据在这里添加模型
 * Create by Songlcy
 */
import 'package:scoped_model/scoped_model.dart';



class MainStateModel extends Model with ThemeStateModel {
  static MainStateModel of(context) => ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
}


