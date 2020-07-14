/*
 * @Descripttion: 
 * @Author: LF
 * @Date: 2020-07-10 14:41:31
 * @LastEditTime: 2020-07-14 08:40:02
 */

import 'package:flutter/material.dart';
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/models/main_state_model.dart';
import 'package:flutter_template/public/local_store.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/router/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageFour extends StatefulWidget {
  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  final opation = EdgeInsets.symmetric(vertical: 0, horizontal: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('个人中心')),
        body: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              leading: new Icon(
                Icons.file_download,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('检查更新'),
              trailing: new Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: new Icon(
                Icons.color_lens,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('主题颜色'),
              trailing: new Icon(Icons.arrow_forward_ios),
              onTap: _themeColorHandle,
            ),
            ListTile(
                leading: new Icon(
                  Icons.supervisor_account,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('关于我们'),
                trailing: new Icon(Icons.arrow_forward_ios)),
            ListTile(
                leading: new Icon(
                  Icons.vpn_key,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('修改密码'),
                trailing: new Icon(Icons.arrow_forward_ios)),
            ListTile(
                leading: new Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('安全退出'),
                trailing: new Icon(Icons.arrow_forward_ios)),
          ]).toList(),
        ));
  }

  _themeColorHandle() {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('选择'),
          children: <Widget>[
            new SimpleDialogOption(
              padding: opation,
              child: ListTile(
                  leading: new Icon(Icons.turned_in, color: Colors.black),
                  title: Text('黑色 - black')),
              onPressed: () {
                MainStateModel.of(context).changeTheme(1);
              },
            ),
            new SimpleDialogOption(
              padding: opation,
              child: ListTile(
                  leading: new Icon(Icons.turned_in, color: Colors.green),
                  title: Text('绿色 - green')),
              onPressed: () {
                MainStateModel.of(context).changeTheme(3);
              },
            ),
            new SimpleDialogOption(
              padding: opation,
              child: ListTile(
                  leading: new Icon(Icons.turned_in, color: Colors.blue),
                  title: Text('蓝色 - blue')),
              onPressed: () {
                MainStateModel.of(context).changeTheme(0);
              },
            ),
            // new SimpleDialogOption(
            //   padding: opation,
            //   child: ListTile(
            //       leading: new Icon(Icons.turned_in, color: Colors.teal),
            //       title: Text('蓝绿色 - teal')),
            //   onPressed: () {},
            // ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  void _signOut() {
    print("调用");
  }
}
