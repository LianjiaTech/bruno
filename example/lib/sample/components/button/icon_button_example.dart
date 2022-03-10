import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// @desc    图片和文字随意组合

class BrnIconBtnExample extends StatefulWidget {
  @override
  _BrnIconBtnExampleState createState() => _BrnIconBtnExampleState();
}

class _BrnIconBtnExampleState extends State<BrnIconBtnExample>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '图文组合示列',
      ),
      body: SingleChildScrollView(
        child: iconButton(),
      ),
    );
  }

  Widget iconButton() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 50, bottom: 50),
          child: Center(
            child: BrnIconButton(
                name: '文字在下',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF999999),
                ),
                direction: Direction.bottom,
                padding: 4,
                iconHeight: 30,
                iconWidth: 30,
                iconWidget: Icon(Icons.arrow_upward),
                onTap: () {
                  BrnToast.show('按钮被点击', context);
                }),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 50),
          child: Center(
            child: BrnIconButton(
                name: '文字在上',
                direction: Direction.top,
                padding: 4,
                iconWidget: Icon(Icons.assignment),
                onTap: () {
                  BrnToast.show('按钮被点击', context);
                }),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 50),
          child: Center(
            child: BrnIconButton(
                name: '文字在右',
                direction: Direction.right,
                padding: 4,
                iconWidget: Icon(Icons.autorenew),
                onTap: () {
                  BrnToast.show('按钮被点击', context);
                }),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 50),
          child: Center(
            child: BrnIconButton(
                name: '文字在左',
                direction: Direction.left,
                padding: 4,
                iconWidget: Icon(Icons.backspace),
                onTap: () {
                  BrnToast.show('按钮被点击', context);
                }),
          ),
        )
      ],
    );
  }
}
