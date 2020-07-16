import 'package:flutter_template/public/click_widget.dart';
import 'package:flutter_template/public/list_helper_widget.dart';
import 'package:flutter_template/public/base_state.dart';
import 'package:flutter/material.dart';

/// 加油计划页面
class RefuelPlanPage extends StatefulWidget {
  static const String ROUTE_NAME = "/refuel/plan";

  RefuelPlanPage({Key key}) : super(key: key);

  PageState createState() => PageState();
}

class PageState extends BaseState<RefuelPlanPage> {
  void initState() {
    super.initState();
  }

  void toAdd() {}
  var listHelperControl = ListHelperControl();
  List list = [];
  void onLoad(int page) {
    Future.delayed(Duration(milliseconds: 2000), () {
      //模拟网络请求结果
      List list = [];
      for (int i = 0; i < 10; i++) {
        list.add({
          "name": "车辆名称+车牌号$i",
          "id": "$i",
          "group": "$i号项目部",
          "company": "$i号公司",
          "department": "$i号部门",
          "driver": "$i号司机",
          "principal": "$i号负责人",
          "time": "2020-06-29",
        });
      }
      listHelperControl.loadSuccess(list, 30);
    });
  }

  TextEditingController textEditCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('加油计划'),
          actions: <Widget>[
            ClickWidget(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '添加',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
              onClick: () => toAdd(),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: textEditCtrl,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10), helperText: '关键字'),
                autofocus: false,
              ),
            ),
            Container(
                child: Expanded(
              flex: 1,
              child: ListHelperWidget(
                controller: listHelperControl,
                initialRefresh: true,
                onLoad: onLoad,
                itemBuilder: (context, index, list) {
                  Map data = list[index];
                  var textEditCtrl;
                  return Column(
                    children: <Widget>[
                      ClickWidget(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    data['name'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "调度编号: " + data['id'],
                                    style: TextStyle(
                                        color: Color(0xff666666), fontSize: 13),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "项目名称: " + data['group'],
                                    style: TextStyle(
                                        color: Color(0xff666666), fontSize: 13),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "所属公司: " + data['company'],
                                    style: TextStyle(
                                        color: Color(0xff666666), fontSize: 13),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "使用部门: " + data['department'],
                                    style: TextStyle(
                                        color: Color(0xff666666), fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onClick: () {
                          showToast("点击了第$index个");
                        },
                      ),
                    ],
                  );
                },
              ),
            ))
          ],
        ));
  }
}
