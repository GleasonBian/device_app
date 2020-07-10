


import 'package:flutter/material.dart';
import 'package:flutter_template/models/counter.dart';
import 'package:scoped_model/scoped_model.dart';

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 首先，创建一个“ ScopedModel”小部件。这将提供
    // 给请求它的孩子的模型
    return new ScopedModel<CounterModel>(
        model: new CounterModel(),
        child: new Column(children: [
          // 创建一个ScopedModelDescendant, 此小部件将从最近的ScopedModel <CounterModel>获取CounterModel。
          // 它将模型交给我们的构建器方法，并在CounterModel更改时（即在我们在模型中的“ notifyListeners”之后）重新构建。
          new ScopedModelDescendant<CounterModel>(
            builder: (context, child, model) => Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text('${model.counter??0}'),
                ),
              ],
            )
          ),
          new Text("另一个不依赖 CounterModel 的小部件")
        ])
    );
  }
}

