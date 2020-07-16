import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template/Dio/interface.dart';
import 'package:flutter_template/public/local_store.dart';
import 'package:flutter_template/router/navigator_util.dart';
import 'package:flutter_template/router/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool pwdShow = false; //密码是否明文
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();
  var check = false;
  //声明焦点
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();

  // 记住密码
  var pwdState;
  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("登 录"),
        centerTitle: true,
      ),
      body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              color:Theme.of(context).primaryColor,
              height: focusNode1.hasFocus || focusNode2.hasFocus ? 0 : 200,
              child: Image.asset(
                'assets/images/login.png',
                scale: 1.3,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 20, 25, 20),
              padding: EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  //卡片阴影
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 10.0,
                  )
                ],
              ),
              child: Form(
                autovalidate: true,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: TextFormField(
                          controller: _userIdController,
                          decoration: InputDecoration(
                            hintText: "请输入您的用户名",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (v) {
                            return v.trim().isNotEmpty ? null : "用户名不能为空";
                          },
                          focusNode: focusNode1
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: TextFormField(
                        controller: _passWordController,
                        decoration: InputDecoration(
                          hintText: "请输入您的登录密码",
                          prefixIcon: Icon(Icons.lock),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                pwdShow = !pwdShow;
                              });
                            },
                          ),
                        ),
                        obscureText: !pwdShow,
                        textInputAction: TextInputAction.done,
                        validator: (v) {
                          return v.trim().isNotEmpty ? null : "密码不能少于6位";
                        },
                        focusNode: focusNode2
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: CheckboxListTile(
                        title: const Text('记住账号密码'),
                        value: this.check,
                        onChanged: (bool value) {
                          setState(() {
                            this.check = !this.check;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text("登  录"),
                        onPressed: _onLogin,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  _onLogin() async{
      if((_formKey.currentState as FormState).validate()){
        Map response = await Fetch.login({'userid':_userIdController.text, 'password':_passWordController.text});
        if (response['Data'] != null){
          jump.push(context, Routes.index,replace:true);
          LocalStore.setString('Authorization',response['Data']);
        } else {
          EasyLoading.showInfo(response['message']);
        }
      }else{
        EasyLoading.showInfo('请输入账号密码!');
      }
  }

  Future _validateLogin() async{
    Future<dynamic> future = Future(()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("Authorization");
    });
    future.then((val){
      if(val == null){
        setState(() {
          pwdState = 0;
        });
      }else{
        setState(() {
          pwdState = 1;
        });
      }
    }).catchError((_){
      EasyLoading.showError('登录状态失效!');
      jump.push(context, Routes.root,replace:true);
    });
  }
}
