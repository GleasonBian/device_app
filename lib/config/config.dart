import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

///
/// 项目中 通过 ENV 获取环境变量
///

class ENV extends InheritedWidget {
  static String appName; // 系统名称
  static String envName; // 运行环境
  static String baseUrl; // 基础url

  ENV({
    @required String appName,
    @required String envName,
    @required String baseUrl,
    @required Widget child,
  }) : super(child: child){
    ENV.appName = appName;
    ENV.envName = envName;
    ENV.baseUrl = baseUrl;
  }
  static ENV of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: ENV);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

Future<int> getTheme() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  int themeIndex = sp.getInt("themeIndex");
  if (themeIndex != null) {
    return themeIndex;
  }
  return 0;
}
/**
 * @date: 2020/7/10 10:12
 * @author: Gleason
 * @content: showToast("删除成功！");
 */
//void showToast(String text, {gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_SHORT}) {
//  Fluttertoast.showToast(
//    msg: text, // 显示消息
//    toastLength: Toast.LENGTH_SHORT, // 显示
//    gravity: ToastGravity.TOP, // 位置
//    backgroundColor: Colors.grey[600], // 背景
//    fontSize: 16.0, // 大小
//  );
//}

/**
 * @date: 2020/7/10 10:42
 * @author: Gleason
 * @content: showLoading(context, '删除中，请等待......');
 */
void showLoading(context, [String text]) {
  text = text ?? "Loading...";
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

/**
 * @date: 2020/7/10 10:43
 * @author: Gleason
 * @content:
 * showConfirmDialog(context, '确认删除该数据吗？', () {
 * print('点击了确定删除......');
 * // 执行确定操作后的逻辑
 * });
 */
void showConfirmDialog(BuildContext context,String content, Function confirmCallback) {
  showDialog(
      context: context,
      builder: (context) {
        return new AlertDialog(
          title: new Text("提示"),
          content: new Text(content),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                confirmCallback();
                Navigator.of(context).pop();
              },
              child: new Text("确认"),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text("取消"),
            ),
          ],
        );
      },
  );
}


/**
 * @date: 2020/7/10 17:29
 * @author: Gleason
 * @content: 全局key
 */
final GlobalKey<_AppContainerFinderState> _keyFinder = GlobalKey(debugLabel: 'overlay_support');
/// 全局overlayState
OverlayState get _overlayState{
  final context = _keyFinder.currentContext;
  if (context == null) return null;
  NavigatorState navigator;
  void visitor(Element element) {
    if (navigator != null) return;
    /// 如果是一个页面路由
    if (element.widget is Navigator) {
      /// navigator返回他的state
      navigator = (element as StatefulElement).state;
    } else {
      /// 否则递归
      element.visitChildElements(visitor);
    }
  }
  /// 就是总能找到最后一页的overlay
  context.visitChildElements(visitor);
  return navigator.overlay;
}

/// 静态app容器
class AppContainer extends StatelessWidget {
  final Widget child;
  AppContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return AppContainerFinder(child: child, key: _keyFinder);
  }
}
/// 动态app容器内容
class AppContainerFinder extends StatefulWidget {
  final Widget child;
  @override
  AppContainerFinder({Key key,this.child}) : super(key: key);
  _AppContainerFinderState createState() => _AppContainerFinderState();
}

class _AppContainerFinderState extends State<AppContainerFinder> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/**
 * @date: 2020/7/10 17:28
 * @author: Gleason
 * @content: 土司提示
 */
showToast(msg) {
  OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
    //外层使用Positioned进行定位，控制在Overlay中的位置
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.7,
        child: Material(
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(msg),
                ),
                color: Colors.grey,
              ),
            ),
          ),
        ));
  });
  //往Overlay中插入插入OverlayEntry
  _overlayState.insert(overlayEntry);
  //两秒后，移除Toast
  Future.delayed(Duration(seconds: 2)).then((value) {
    overlayEntry.remove();
  });
}

/**
 * @date: 2020/7/10 17:30
 * @author: Gleason
 * @content: showModal 仿微信API
 */
showModal(String msg, {onConfirm, onCancel}) {
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(builder: (context) {
    //外层使用Positioned进行定位，控制在Overlay中的位置
    return Container(
      color: Color(0x66333333),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 100,
              width: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
              child: Text('$msg', style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0
              ),),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Material(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(20),
                              child: Text('取消'),
                            ),
                            onTap: () {
                              overlayEntry.remove();
                              return onCancel != null ? onCancel() : false;
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(20),
                              child: Text('确定'),
                            ),
                            onTap: () {
                              overlayEntry.remove();
                              return onConfirm != null ? onConfirm() : false;
                            },
                          ),
                        ),

                      ],
                    ))
            )
          ],
        ),
      ),
    );
  });
  //往Overlay中插入插入OverlayEntry
  _overlayState.insert(overlayEntry);
  //两秒后，移除Toast
  // Future.delayed(Duration(seconds: 2)).then((value) {
  //   overlayEntry.remove();
  // });
}

