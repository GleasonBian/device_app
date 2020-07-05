

import 'package:flutter/material.dart';

class TwoPage2 extends StatelessWidget {

  final String param;

  const TwoPage2({Key key, this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('one page 1')),
      body: Center(
        child: Text('参数: $param'),
      ),
    );
  }
}
