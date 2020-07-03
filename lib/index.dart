

import 'package:flutter/material.dart';
import 'package:flutter_template/public/config.dart';
import 'package:flutter_template/public/interface.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String data;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(ENV.appName),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text('app name: ${ENV.envName}.'),
            new Text('env name: ${ENV.baseUrl}.'),
            new Text('res data: $data'),
          ],
        ),
      ),
    );
  }

  void loadData() async{
    var result = await Fetch.login({'userid':'bianliuzhu', 'password':'bianliuzhu'});
    setState(() {
      data = result.toString();
    });
  }
}