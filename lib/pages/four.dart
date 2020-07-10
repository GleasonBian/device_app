


import 'package:flutter/material.dart';
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/models/main_state_model.dart';
import 'package:flutter_template/public/local_store.dart';
import 'package:flutter_template/main.dart';
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
      appBar: AppBar(title:Text('个人中心')),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
              leading:new Icon(Icons.file_download,color: Colors.blue,),
              title:Text('检查更新'),
              trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
              leading:new Icon(Icons.color_lens,color: Colors.blue,),
              title:Text('主题颜色'),
              trailing: new Icon(Icons.arrow_forward_ios),
              onTap: _themeColorHandle,
          ),
          ListTile(
              leading:new Icon(Icons.supervisor_account,color: Colors.blue,),
              title:Text('关于我们'),
              trailing: new Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
              leading:new Icon(Icons.vpn_key,color: Colors.blue,),
              title:Text('修改密码'),
              trailing: new Icon(Icons.arrow_forward_ios)
          ),
          ListTile(
              leading:new Icon(Icons.exit_to_app,color: Colors.blue,),
              title:Text('安全退出'),
              trailing: new Icon(Icons.arrow_forward_ios)
          ),
        ]).toList(),
      )
    );
  }

  _themeColorHandle(){
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('选择'),
          children: <Widget>[
            new SimpleDialogOption(
              padding:opation,
              child: ListTile(leading:new Icon(Icons.turned_in,color: Colors.cyan), title:Text('青色 - cyan')) ,
              onPressed: (){
                MainStateModel.of(context).changeTheme(4);

              },
            ),
            new SimpleDialogOption(
              padding:opation,
              child: ListTile(leading:new Icon(Icons.turned_in,color: Colors.green), title:Text('绿色 - green')),
              onPressed: () {

              },
            ),
            new SimpleDialogOption(
              padding:opation,
              child: ListTile(leading:new Icon(Icons.turned_in,color: Colors.blue), title:Text('蓝色 - blue')),
              onPressed: () {

              },
            ),
            new SimpleDialogOption(
              padding:opation,
              child: ListTile(leading:new Icon(Icons.turned_in,color: Colors.teal), title:Text('蓝绿色 - teal')),
              onPressed: () {

              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }
}
