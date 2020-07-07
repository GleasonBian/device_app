import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_template/Dio/interface.dart';
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/router/application.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool pwdShow = false; //密码是否明文
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();

  //声明焦点(1/4)
  FocusNode focusNode1 = new FocusNode();
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    focusNode1.addListener(() {
      print("焦点1是否被选中：" + focusNode1.hasFocus.toString());
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
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
          controller: _controller,
          children: [
            Container(
              color: Colors.blue,
              height: 200,
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
                          focusNode: focusNode1),
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
                            icon: Icon(pwdShow
                                ? Icons.videocam_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(
                                () {
                                  pwdShow = !pwdShow;
                                },
                              );
                            },
                          ),
                        ),
                        obscureText: !pwdShow,
                        textInputAction: TextInputAction.done,
                        validator: (v) {
                          return v.trim().isNotEmpty ? null : "密码不能少于6位";
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
                    )
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
        Map result = await Fetch.login({'userid':_userIdController.text, 'password':_passWordController.text});
        if (result['code'] == 200){
          Application.router.navigateTo(context, "/index");
        }
      }else{
        print(2);
      }
  }
}
