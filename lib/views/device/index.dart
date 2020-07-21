

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/common/message.dart';
import 'package:flutter_template/views/common/setting.dart';
import 'package:flutter_template/views/device/workbench.dart';
import 'package:flutter_template/views/operator/report_forms.dart';


class deviceIndexPage extends StatefulWidget {
  @override
  _deviceIndexPageState createState() => new _deviceIndexPageState();
}

class _deviceIndexPageState extends State<deviceIndexPage> {
  dynamic data;

  // 当前页面
  int _currentIndex = 0;

  // 页面控制器
  final  PageController _controller = PageController (
    initialPage: 0,// 初始页面
  );


  @override
  Widget build(BuildContext context) {
    // 定义 颜色常量
    final _defaultColor = Colors.grey;
    final _activeColor = Theme.of(context).primaryColor;
    return Scaffold (

      body: PageView(
        controller: _controller,
        onPageChanged: (val) => setState((){
          _currentIndex = val;
        }),
        children: [
          messagePage(),
          reportForms(),
          RefuelPlanPage(),
          settingPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 当前所在的页面
        currentIndex: _currentIndex,
        // 点击的回调函数 当前页面 的index
        onTap: (index) {
          // 跳转到选择的页面
          _controller.jumpToPage(index);
          // 设置 index
          setState(() {
            _currentIndex = index;
          });
        },
        // bottom navigation bar 的文字 非 选中时 显示
        type: BottomNavigationBarType.fixed,
        items: [
          // 注意 index 从 0 开始
          BottomNavigationBarItem(
            icon: Icon( Icons.message,  color: _defaultColor),
            activeIcon: Icon( Icons.message, color: _activeColor ),
            title: Text('消息',style: TextStyle(color: _currentIndex != 0 ? _defaultColor : _activeColor )),
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.insert_chart,  color: _defaultColor),
            activeIcon: Icon( Icons.insert_chart, color: _activeColor ),
            title: Text('报表',style: TextStyle(color: _currentIndex != 1 ? _defaultColor : _activeColor )),
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.work,  color: _defaultColor),
            activeIcon: Icon( Icons.work, color: _activeColor ),
            title: Text('工作台',style: TextStyle(color: _currentIndex != 2 ? _defaultColor : _activeColor )),
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.settings,  color: _defaultColor),
            activeIcon: Icon( Icons.settings, color: _activeColor ),
            title: Text('设置',style: TextStyle(color: _currentIndex != 3 ? _defaultColor : _activeColor )),
          ),
        ],
      ),
    );
  }

  void loadData() async{
  }
}
