

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_template/index.dart';
import 'package:flutter_template/pages/login.dart';
import 'package:flutter_template/pages/one/one_page_1.dart';


var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Login();
    });

var onePage1Handler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String message = params["message"]?.first;
  String colorHex = params["color_hex"]?.first;
  String result = params["result"]?.first;
  Color color = Color(0xFFFFFFFF);
  if (colorHex != null && colorHex.length > 0) {
//    color = Color(ColorHelpers.fromHexString(colorHex));
  }
  return OnePage1(message: message, color: color, result: result);
});

/*var demoFunctionHandler = Handler( type: HandlerType.function, handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String message = params["message"]?.first;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Hey Hey!",
          style: TextStyle(
            color: const Color(0xFF00D6F7),
            fontFamily: "Lazer84",
            fontSize: 22.0,
          ),
        ),
        content: Text("$message"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, right: 8.0),
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("OK"),
            ),
          ),
        ],
      );
    },
  );
  return;
});*/

/// Handles deep links into the app
/// To test on Android:
///
/// `adb shell am start -W -a android.intent.action.VIEW -d "fluro://deeplink?path=/message&mesage=fluro%20rocks%21%21" com.theyakka.fluro`
/*var deepLinkHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String colorHex = params["color_hex"]?.first;
      String result = params["result"]?.first;
      Color color = Color(0xFFFFFFFF);
      if (colorHex != null && colorHex.length > 0) {
        color = Color(ColorHelpers.fromHexString(colorHex));
      }
      return DemoSimpleComponent(
          message: "DEEEEEP LINK!!!", color: color, result: result);
    });*/