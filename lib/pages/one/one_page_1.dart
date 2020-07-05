

import 'package:flutter/material.dart';


class OnePage1 extends StatelessWidget {

  final String id;

  OnePage1(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('one page 1')),
      body: Center(
        child: Text('参数: $id'),
      ),
    );
  }
}