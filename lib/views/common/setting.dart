
import 'package:flutter/material.dart';
import 'package:flutter_template/models/main_state_model.dart';
import 'package:flutter_template/models/save_pwd_model.dart';
import 'package:flutter_template/router/routers.dart';
import 'package:flutter_template/router/navigator_util.dart';
import 'package:scoped_model/scoped_model.dart';

class settingPage extends StatefulWidget {
  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  final SimpleDialogPadding = EdgeInsets.symmetric(vertical: 0, horizontal: 0);
  // 保存密码模型
  SavePwdModel savePwdModel;
  // 初始化模型
  _getSavePwdModel() async{
    if(savePwdModel == null) {
      savePwdModel = SavePwdModel();
    }
    return savePwdModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    _getSavePwdModel();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('个人中心')),
        body: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
              child: ScopedModelDescendant<SavePwdModel>(
                  builder: (context, child, model) {
                    return ListTile(
                      leading:  Image.network('https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1462597699,2457940300&fm=26&gp=0.jpg'),
                      title: Text(model.userName),
                      subtitle: Text(model.roleName),
                      trailing: new Icon(Icons.arrow_forward_ios),
                    );
                  }
              ),
            ),
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
                trailing: new Icon(Icons.arrow_forward_ios),
              onTap:  _onBackPressed,
            ),
          ]).toList(),
        ),
    );
  }

  /**
   * @date: 2020/7/16 14:27
   * @author: Gleason
   * @content: 主题颜色切换
   */
  _themeColorHandle() {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('选择'),
          children: <Widget>[
            new SimpleDialogOption(
              padding: SimpleDialogPadding,
              child: ListTile(
                  leading: new Icon(Icons.turned_in, color: Colors.black),
                  title: Text('黑色 - black')),
              onPressed: () {
                MainStateModel.of(context).changeTheme(1);
              },
            ),
            new SimpleDialogOption(
              padding: SimpleDialogPadding,
              child: ListTile(
                  leading: new Icon(Icons.turned_in, color: Colors.green),
                  title: Text('绿色 - green')),
              onPressed: () {
                MainStateModel.of(context).changeTheme(3);
              },
            ),
            new SimpleDialogOption(
              padding: SimpleDialogPadding,
              child: ListTile(
                  leading: new Icon(Icons.turned_in, color: Colors.blue),
                  title: Text('蓝色 - blue')),
              onPressed: () {
                MainStateModel.of(context).changeTheme(0);
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  /**
   * @date: 2020/7/16 14:27
   * @author: Gleason
   * @content: 退出程序
   */
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('确定退出程序吗?'),
            actions: <Widget>[
              FlatButton(
                child: Text('暂不'),
                onPressed: () => Navigator.pop(context, false),
              ),
              FlatButton(
                child: Text('确定'),
                onPressed: ()=> jump.push(context, Routes.root, replace: true,clearStack : true) ,
              ),
            ],
          ),
    );
  }
}



