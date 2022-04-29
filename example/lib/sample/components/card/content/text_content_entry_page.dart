

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/card/content/keyvalue_align_content_example.dart';
import 'package:example/sample/components/card/content/keyvalue_close_content_example.dart';
import 'package:example/sample/components/card/content/number_item_example.dart';
import 'package:example/sample/components/card/content/text_value_arrow_example.dart';
import 'package:example/sample/components/card/content/brn_two_rich_content_example.dart';
import 'package:example/sample/components/card/content/brn_two_text_content_example.dart';
import 'package:example/sample/components/card/content/brn_two_text_expanded_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

class TextContentEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: "文本内容示例",
      ),
      body: ListView(
        children: [
          ListItem(
            title: "单列左对齐",
            isShowLine: false,
            isSupportTheme: true,
            describe: 'key宽度最多92，value是左对齐的',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return TextContentExample();
                },
              ));
            },
          ),
          ListItem(
            title: "单列紧贴着key名",
            isSupportTheme: true,
            describe: 'Value紧贴着Key，Key和value都是一行展示',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return KeyTextCloseContentExample();
                },
              ));
            },
          ),
          ListItem(
            title: "两列纯文本",
            isShowLine: false,
            isSupportTheme: true,
            describe: '两组key-value展示',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return BrnTextRIchContentExample();
                },
              ));
            },
          ),
          ListItem(
            title: "两列复杂元素",
            isShowLine: false,
            isSupportTheme: true,
            describe: '元素中可以携带问号等',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return BrnTwoRichContentExample();
                },
              ));
            },
          ),
          ListItem(
            title: "强化数字信息",
            isShowLine: false,
            isSupportTheme: true,
            describe: '数字是大字体',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return NumberItemRowExample();
                },
              ));
            },
          ),
          ListItem(
            title: "纯文本展示可收起",
            isShowLine: false,
            isSupportTheme: true,
            describe: '展开收起文本',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return BrnTextExpandedContentExample();
                },
              ));
            },
          ),
          ListItem(
            title: "文本+跳转操作",
            isShowLine: false,
            describe: 'value带有跳转箭头',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return TextValueArrowContentExample();
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
