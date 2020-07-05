

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/pages/one/one_page_1.dart';

Handler onePage1Handle = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params) {
      String id = params["id"].first;
    print("router_handler -> params: $id");
    return new OnePage1(id);
}
);