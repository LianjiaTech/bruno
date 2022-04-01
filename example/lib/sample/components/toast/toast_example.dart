

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class ToastExample extends StatefulWidget {
  @override
  _ToastExampleState createState() => _ToastExampleState();
}

class _ToastExampleState extends State<ToastExample>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'BrnToast示例',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  BrnToast.show(
                    "普通长Toast",
                    context,
                    duration: BrnDuration.long,
                    gravity: BrnToastGravity.center,
                  );
                },
                child: Text("普通长Toast"),
              ),
              ElevatedButton(
                onPressed: () {
                  BrnToast.show(
                    "失败图标Toast",
                    context,
                    preIcon: Image.asset(
                      "assets/image/icon_toast_fail.png",
                      width: 24,
                      height: 24,
                    ),
                    duration: BrnDuration.short,
                  );
                },
                child: Text("失败图标Toast"),
              ),
              ElevatedButton(
                onPressed: () {
                  BrnToast.show(
                    "成功图标Toast",
                    context,
                    preIcon: Image.asset(
                      "assets/image/icon_toast_success.png",
                      width: 24,
                      height: 24,
                    ),
                    duration: BrnDuration.short,
                  );
                },
                child: Text("成功图标Toast"),
              ),
              ElevatedButton(
                onPressed: () {
                  BrnToast.show("自定义位置Toast", context,
                      duration: BrnDuration.short,
                      verticalOffset: 100,
                      gravity: BrnToastGravity.bottom);
                },
                child: Text("自定义位置Toast"),
              ),
              ElevatedButton(
                onPressed: () {
                  BrnToast.show(
                    "自定义时长Toast",
                    context,
                    duration: Duration(seconds: 5),
                  );
                },
                child: Text("自定义时长Toast(5s)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
