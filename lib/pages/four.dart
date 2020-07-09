


import 'package:flutter/material.dart';

class PageFour extends StatefulWidget {
  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('个人中心')),
      body: ListView(
        children: <Widget>[
          ListTile(
              leading:new Icon(Icons.file_download,color: Colors.blue,),
              title:Text('检查更新'),
              trailing: new Icon(Icons.arrow_forward_ios)
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
          )
        ],
      )
    );
  }
}
