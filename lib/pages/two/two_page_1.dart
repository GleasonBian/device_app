

import 'package:flutter/material.dart';

class TwoPage2 extends StatefulWidget {
  @override
  _TwoPage2State createState() => _TwoPage2State();
}

class _TwoPage2State extends State<TwoPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('one page 1')),
      body: Center(
        child: Text('one page 1'),
      ),
    );
  }
}
