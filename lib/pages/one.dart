


import 'package:flutter/material.dart';
import 'package:flutter_template/Dio/interface.dart';
import 'package:flutter_template/router/application.dart';


class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {

  @override
  Widget build(BuildContext context) {
    var menuWidgets = <Widget>[
      menuButton(context, 'assets/images/ic_transform_native_hz.png', "原生动画", "native"),
      menuButton(context, 'assets/images/ic_transform_fade_in_hz.png', "预设（淡入）", "preset-fade"),
      menuButton(context, 'assets/images/ic_transform_global_hz.png', "预设（全局过渡）", "fixed-trans"),
      menuButton(context, 'assets/images/ic_transform_custom_hz.png', "自定义过渡", "custom"),
      menuButton(context, 'assets/images/ic_result_hz.png', "导航器结果", "pop-result"),
      menuButton(context, 'assets/images/ic_function_hz.png', "函数调用", "function-call"),
    ];
    final size = MediaQuery.of(context).size;

    final childRatio = (size.width / size.height) * 2.5;
    return Scaffold(
      body:SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25, bottom: 35, left: 25),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GridView.count(
                  childAspectRatio: childRatio,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  children: menuWidgets,
                ),
              ),
            ),
//            Padding(
//              padding: EdgeInsets.only(top: 35.0, bottom: 25),
//              child: Center(
//                child: ConstrainedBox(
//                  constraints: BoxConstraints.tightFor(height: 60.0),
//                  child: deepLinkWidget(context),
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }

  Widget menuButton( BuildContext context, String assetSrc, String title, String key) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Container(
        height: 42.0,
        child: FlatButton(
          color: Colors.white,
          highlightColor: const Color(0x11FFFFFF),
          splashColor: const Color(0x22FFFFFF),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 36,
                  child: Image.asset(
                    assetSrc,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xAA001133),
                ),
              )
            ],
          ),
          onPressed: () {
            tappedMenuButton(context, key);
          },
        ),
      ),
    );
  }

  // 动作
  void tappedMenuButton(BuildContext context, String key) {
    print("$key");
    String message = "";
    String hexCode = "#FFFFFF";
    String result;
//    TransitionType transitionType = TransitionType.native;
    if (key != "custom" && key != "function-call" && key != "fixed-trans") {
      if (key == "native") {
        hexCode = "#F76F00";
        message = Uri.encodeComponent("该屏幕应该已经使用当前操作系统的默认抖动动画出现了");
      } else if (key == "preset-from-left") {
        hexCode = "#5BF700";
        message = Uri.encodeComponent("该屏幕应该已经出现，并且从左过渡开始有幻灯片");
//        transitionType = TransitionType.inFromLeft;
      } else if (key == "preset-fade") {
        hexCode = "#F700D2";
        message = Uri.encodeComponent("该屏幕本应带有淡入淡出的过渡");
//        transitionType = TransitionType.fadeIn;
      } else if (key == "pop-result") {
//        transitionType = TransitionType.native;
        hexCode = "#7d41f4";
        message = Uri.encodeComponent("关闭此屏幕时，您应该会看到星期几");
//        result = "Today is ${_daysOfWeek[DateTime.now().weekday - 1]}!";
      }

      String route = "/demo?message=$message&color_hex=$hexCode";

      if (result != null) {
        route = "$route&result=$result";

      }
      loadData();
      Application.router.navigateTo(context, route,).then((result) {
        if (key == "pop-result") {
          Application.router.navigateTo(context, "/demo/func?message=$result");
        }
      });
    } else if (key == "custom") {
      hexCode = "#DFF700";
      message = Uri.encodeComponent("该屏幕应该已经出现了疯狂的自定义过渡");
      var transition = (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return ScaleTransition(
          scale: animation,
          child: RotationTransition(
            turns: animation,
            child: child,
          ),
        );
      };
      Application.router.navigateTo(
        context,
        "/demo?message=$message&color_hex=$hexCode",
//        transition: TransitionType.custom,
//        transitionBuilder: transition,
        transitionDuration: const Duration(milliseconds: 600),
      );
    } else if (key == "fixed-trans") {
      Application.router.navigateTo(context, "/demo/fixedtrans?message=Hello!&color_hex=#f4424b");
    } else {
      message = Uri.encodeComponent("您点击了功能按钮！");
      Application.router.navigateTo(context, "/demo/func?message=$message");
    }
  }
  void loadData() async{
    var result = await Fetch.overview({'id':'c50dc1de-86e1-4b85-8ff9-f710055d7d9a'});
    print("result: $result");
  }
}
