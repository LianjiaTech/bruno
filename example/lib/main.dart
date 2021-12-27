import 'package:bruno/bruno.dart';
import 'package:example/sample/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  BrnInitializer.register(allThemeConfig: BrnAllThemeConfig(appBarConfig: BrnAppBarConfig(backgroundColor:Colors.orange)));
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}
