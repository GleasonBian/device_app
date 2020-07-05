


import 'package:flutter/material.dart';
import 'package:flutter_template/router/application.dart';


class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: new Text('点我'),
          onPressed: () {
            Application.router.navigateTo(context, "/onePage1?id=212313");
          },
        ),
      ),
    );
  }
}
