

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BorderTagExample extends StatefulWidget {
  @override
  _BorderTagExampleState createState() => _BorderTagExampleState();
}

class _BorderTagExampleState extends State<BorderTagExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: "带边框的标签",
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '规则',
          style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        BrnBubbleText(maxLines: 4, text: ' 文字大小 11，上下左右间距 3'),
        Text(
          '正常案例',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 28,
          ),
        ),
        BrnTagCustom.buildBorderTag(
          tagText: '已盘点',
        ),
        Text(
          '正常案例1',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 28,
          ),
        ),
        BrnTagCustom.buildBorderTag(
          tagText: '认证通过',
          textColor: Colors.red,
          borderColor: Colors.red,
          borderWidth: 2,
          fontSize: 24,
          textPadding: EdgeInsets.all(6),
        ),
      ],
    );
  }
}
