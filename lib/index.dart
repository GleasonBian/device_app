

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/public/config.dart';
import 'package:flutter_template/public/dev.dart';
import 'package:flutter_template/public/interface.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String name;
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
            new Text('env name: $name.'),
          ],
        ),
      ),
    );
  }

  void loadData() async{
    Map result = await Fetch.getData({'userid':'bianliuzhu', 'password':'bianliuzhu'});
    print('result:${result}');

    setState(() {
      name = result['user'].toString();

    });
  }
}