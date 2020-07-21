


import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/router/application.dart';
/**
 * @date: 2020/7/16 11:03
 * @author: Gleason
 * @content: 使用示例
 */
/*
    不需要穿参数的
    jump.push(context, LoginRouter.loginPage, replace: true);
*/

/*
  // 需要传参数的
    jump.push(
      context,
      '${Routes.webViewPage}?param1=${Uri.encodeComponent(content1)}&param2=${Uri.encodeComponent(content2)}',
       replace: true,
    );
*/

/*
  // 有返回值跳转
  jump.pushResult(context, AccountRouter.citySelectPage, (result){
    setState(() {
      // result是返回的结果
      TestModel model = result;
      _name = model.name;
    });
  });
*/

/*
  返回上一级
  jump.goBack(context);
*/

class jump {

  /**
   * @date: 2020/7/16 10:58
   * @author: Gleason
   * @content: 不需要页面返回值的跳转
   */
  static push(BuildContext context, String path, {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  /**
   * @date: 2020/7/16 10:58
   * @author: Gleason
   * @content: 需要页面返回值的跳转
   */
  static pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}
  ) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result){
      // 页面返回result为null
      if (result == null){
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  /**
   * @date: 2020/7/16 10:57
   * @author: Gleason
   * @content: 返回
   */
  static void goBack(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context);
  }

  /**
   * @date: 2020/7/16 10:58
   * @author: Gleason
   * @content: 带参返回
   */
  static void BackWithParams(BuildContext context, result) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context, result);
  }

}