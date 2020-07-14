import 'package:flutter/material.dart';

/// 多种状态切换展示布局
class MultiStateWidget extends StatefulWidget {
  /// 内容state
  static final int STATE_CONTENT = 0;

  /// 加载中state
  static final int STATE_LOADING = 1;

  /// 错误state
  static final int STATE_ERROR = 2;

  /// 空state
  static final int STATE_EMPTY = 3;

  /// 子内容布局
  Widget child;

  /// 加载中状态布局
  Widget loadingChild;

  /// 失败状态布局
  Widget errorChild;

  /// 空状态布局
  Widget emptyChild;

  /// 默认展示的布局，默认为子内容布局
  int defaultState;

  /// 控制器，页面调用此组件方法所用
  MultiStateControl controller;

  /// 加载中的文字
  String defaultLoadingText;

  /// 空状态的文字
  String defaultEmptyText;

  OnRetry onRetry;

  MultiStateWidget(
      {Key key,
      @required this.controller,
      this.errorChild,
      this.emptyChild,
      this.loadingChild,
      @required this.child,
      this.defaultState = 0,
      this.defaultLoadingText = "加载中...",
      this.defaultEmptyText = "暂无数据",
      this.onRetry})
      : super(key: key);

  MultiStateState createState() => MultiStateState(
      controller, defaultState, defaultLoadingText, defaultEmptyText);
}

class MultiStateState extends State<MultiStateWidget> {
  int state;
  String defaultLoadingText, defaultEmptyText;
  MultiStateControl controller;

  String errorMsg = "加载失败";

  MultiStateState(this.controller, this.state, this.defaultLoadingText,
      this.defaultEmptyText) {
    this.controller.changeContent = changeContent;
    this.controller.changeError = changeError;
    this.controller.changeLoading = changeLoading;
    this.controller.changeEmpty = changeEmpty;
    this.controller.getCurrentState = getCurrentState;
    if (this.controller.state == MultiStateWidget.STATE_LOADING) {
      state = MultiStateWidget.STATE_LOADING;
    } else if (this.controller.state == MultiStateWidget.STATE_ERROR) {
      errorMsg = this.controller.errorMsg;
      state = MultiStateWidget.STATE_ERROR;
    } else if (this.controller.state == MultiStateWidget.STATE_EMPTY) {
      state = MultiStateWidget.STATE_EMPTY;
    } else if (this.controller.state == MultiStateWidget.STATE_CONTENT) {
      state = MultiStateWidget.STATE_CONTENT;
    }
  }

  void changeContent() {
    setState(() {
      state = MultiStateWidget.STATE_CONTENT;
    });
  }

  void changeError(String msg) {
    setState(() {
      errorMsg = msg;
      state = MultiStateWidget.STATE_ERROR;
    });
  }

  void changeLoading() {
    setState(() {
      state = MultiStateWidget.STATE_LOADING;
    });
  }

  void changeEmpty() {
    setState(() {
      state = MultiStateWidget.STATE_EMPTY;
    });
  }

  int getCurrentState() {
    return state;
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingWidget = widget.loadingChild != null
        ? widget.loadingChild
        : Center(
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor)),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    defaultLoadingText,
                    style: TextStyle(color: Color(0xFF666666), fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          );
    Widget errorWidget = widget.errorChild != null
        ? widget.errorChild
        : Center(
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/main/images/multi-state-error.png",
                  width: 180,
                  height: 150,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    errorMsg,
                    style: TextStyle(color: Color(0xFF666666), fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: FlatButton(
                    child: Text(
                      "点击重试",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      if (widget.onRetry != null) {
                        widget.onRetry();
                      }
                    },
                  ),
                )
              ],
            ),
          );
    Widget emptyWidget = widget.emptyChild != null
        ? widget.emptyChild
        : Center(
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/main/images/multi-state-empty.png",
                  width: 180,
                  height: 150,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    defaultEmptyText,
                    style: TextStyle(color: Color(0xFF666666), fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: FlatButton(
                    child: Text(
                      "点击重试",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      if (widget.onRetry != null) {
                        widget.onRetry();
                      }
                    },
                  ),
                )
              ],
            ),
          );
    return Container(
      child: Stack(
        children: <Widget>[
          widget.child,
          state == MultiStateWidget.STATE_EMPTY
              ? Container(
                  color: Colors.white,
                  child: emptyWidget,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          state == MultiStateWidget.STATE_ERROR
              ? Container(
                  color: Colors.white,
                  child: errorWidget,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          state == MultiStateWidget.STATE_LOADING
              ? Container(
                  color: Colors.white,
                  child: loadingWidget,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
    );
  }
}

class MultiStateControl {
  int state = -1;
  String errorMsg = "";

  MultiStateControl() {
    changeContent = () {
      this.state = MultiStateWidget.STATE_CONTENT;
    };
    changeEmpty = () {
      this.state = MultiStateWidget.STATE_EMPTY;
    };
    changeLoading = () {
      this.state = MultiStateWidget.STATE_LOADING;
    };
    changeError = (String msg) {
      this.state = MultiStateWidget.STATE_ERROR;
      this.errorMsg = msg;
    };
    getCurrentState = () {
      return -1;
    };
  }

  /// 展示内容状态
  void Function() changeContent;

  /// 展示错误状态
  void Function(String msg) changeError;

  /// 展示空数据状态
  void Function() changeEmpty;

  /// 展示加载中状态
  void Function() changeLoading;

  /// 获取当前页
  int Function() getCurrentState;
}

/// 点击重试
typedef void OnRetry();
