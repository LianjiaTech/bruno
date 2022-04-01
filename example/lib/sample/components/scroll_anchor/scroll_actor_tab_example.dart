

import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class ScrollActorTabExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '锚点',
      ),
      body: BrnAnchorTab(
        itemCount: 10,
        widgetIndexedBuilder: (context, index) {
          return Container(
            child: Center(child: Text('$index')),
            height: Random().nextInt(400).toDouble(),
            color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
                Random().nextInt(255), Random().nextInt(255)),
          );
        },
        tabIndexedBuilder: (context, index) {
          return BadgeTab(text: 'index $index');
        },
      ),
    );
  }
}
