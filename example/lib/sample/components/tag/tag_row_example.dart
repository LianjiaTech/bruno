

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class RowTagExample extends StatefulWidget {
  @override
  _RowTagExampleState createState() => _RowTagExampleState();
}

class _RowTagExampleState extends State<RowTagExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '标签组合',
      ),
      body: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        children: [
          BrnTagCustom(
            tagText: '自定义标签',
          ),
          BrnTagCustom(
            tagText: '标签',
          ),
          BrnTagCustom.buildBorderTag(tagText: '标签1'),
          BrnTagCustom.buildBorderTag(tagText: '标签2'),
          BrnTagCustom.buildBorderTag(tagText: '特长长长长长长的标签'),
          BrnTagCustom(tagText: '一级标签'),
          BrnTagCustom(tagText: '二级标签'),
          BrnTagCustom(tagText: '其他标签'),
          BrnTagCustom(tagText: '二级标签'),
          BrnTagCustom(tagText: '一级标签'),
          BrnTagCustom(tagText: '二级标签'),
        ],
        spacing: 5,
        runSpacing: 5,
      ),
    );
  }
}
