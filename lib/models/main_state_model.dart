


import 'package:flutter_template/models/save_pwd_model.dart';
import 'package:flutter_template/models/theme_state_model.dart';
import 'package:scoped_model/scoped_model.dart';

/**
 * @date: 2020/7/21 11:51
 * @author: Gleason
 * @content: 主题 main 模型
 */
class MainStateModel extends Model with ThemeStateModel,SavePwdModel {
  static MainStateModel of(context) => ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
}


