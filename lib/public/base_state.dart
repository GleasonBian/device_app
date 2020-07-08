import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

///
/// State基类,封装了常用的界面交互的方法
/// author: shijian   email: shijianit@163.com
///

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  /// 网络请求的取消Token
  var cancelToken;

  YYDialog progressDialog;
  YYDialog listRadioDialog;

  /// If you override this, make sure your method starts with a call to
  /// super.initState().
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    cancelToken = CancelToken();
  }

  PreferredSize getAppBar({
    Widget title,
    String titleText,
    bool showBack = true,
    List<Widget> actions,
  }) {
    return PreferredSize(
        child: AppBar(
          centerTitle: true,
          title: titleText != null
              ? Text(
                  titleText,
                  style: TextStyle(fontSize: 18),
                )
              : title,
          actions: actions,
          leading: showBack
              ? IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : null,
        ),
        preferredSize: Size.fromHeight(46));
  }

  /// 土司提示
  void showToast(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0x88000000),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  /// 展示Loading弹框
  void showProgressDialog() {
    showProgressTextDialog("加载中...");
  }

  /// 展示可定义文字的Loading弹框
  void showProgressTextDialog(var text) {
    progressDialog = YYDialog().build(context)
      ..width = 200
      ..borderRadius = 4.0
      ..circularProgress(
        padding: EdgeInsets.all(24.0),
        valueColor: Colors.blue,
      )
      ..text(
        padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 12.0),
        text: text,
        alignment: Alignment.center,
        color: Color(0xff666666),
        fontSize: 18.0,
      );
    progressDialog.show();
  }

  /// 关闭Loading弹框
  void closeProgressDialog() {
    if (progressDialog != null) {
      progressDialog.dismiss();
      progressDialog = null;
    }
  }

  /// 展示内容消息弹框
  void showMessageDialog(String message) {
    showTitleMessageDialog(null, message);
  }

  /// 展示带标题的消息弹框
  void showTitleMessageDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
              title: title != null ? Text(title) : null,
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("确定"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ]);
        });
  }

  /// 展示标题内容的确认框
  void showConfirmDialog(
      String title, String message, VoidCallback confirm, VoidCallback cancel) {
    showConfirmDialogFull(title, message, "确定", "取消", confirm, cancel);
  }

  /// 可自定义确定,取消按钮文字的确认框
  void showConfirmDialogFull(String title, String message, String confirmText,
      String cancelText, VoidCallback confirm, VoidCallback cancel) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    cancelText,
                    style: TextStyle(color: Color(0xff666666)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    cancel();
                  },
                ),
                FlatButton(
                  child: Text(confirmText),
                  onPressed: () {
                    Navigator.of(context).pop();
                    confirm();
                  },
                ),
              ]);
        });
  }

  /// 单项选择弹框
  void showRadioListDialog(String title, List<RadioItem> list,int defaultIndex, Function(int, RadioItem item) confirmCallback) {
    int selectIndex = defaultIndex;
    RadioItem selectItem;
    if(defaultIndex != -1){
      selectItem = list[defaultIndex];
    }
    listRadioDialog = YYDialog().build(context)
      ..width = 280
      ..borderRadius = 4.0
      ..text(
        padding: EdgeInsets.fromLTRB(18.0, 22.0, 18.0, 18.0),
        text: title,
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      )
      ..divider()
      ..listViewOfRadioButton(
          items: list,
          height: 370,
          intialValue: defaultIndex,
          color: Colors.white,
          activeColor: Colors.deepPurpleAccent,
          onClickItemListener: (index) {
            selectIndex = index;
            selectItem = list[index];
          })
      ..divider()
      ..doubleButton(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        gravity: Gravity.right,
        text1: "取消",
        color1: Color(0xff666666),
        fontSize1: 14.0,
        fontWeight1: FontWeight.bold,
        text2: "确定",
        color2: Colors.deepPurpleAccent,
        fontSize2: 14.0,
        fontWeight2: FontWeight.bold,
        isClickAutoDismiss: false,
        onTap1: (){
          listRadioDialog.dismiss();
        },
        onTap2: (){
          if(selectIndex <= 0){
            showToast("请先选择后，再点击确定");
            return;
          }
          listRadioDialog.dismiss();
          confirmCallback(selectIndex, selectItem);
        }
      );
    listRadioDialog.show();
  }

  /// If you override this, make sure your method starts with a call to
  /// super.dispose().
  @protected
  @mustCallSuper
  void dispose() {
    super.dispose();
    cancelToken.cancel("cancelled");
  }
}
