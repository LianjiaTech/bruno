

import 'dart:async';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// @desc    弱引导example
class SoftGuideExample extends StatefulWidget {
  SoftGuideExample({Key? key}) : super(key: key);

  @override
  _SoftGuideExampleState createState() => _SoftGuideExampleState();
}

class _SoftGuideExampleState extends State<SoftGuideExample> {
  late BrnGuide intro;

  _SoftGuideExampleState() {
    /// init Guide
    intro = BrnGuide(
      stepCount: 7,
      introMode: GuideMode.soft,

      /// use defaultTheme, or you can implement widgetBuilder function yourself
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        tipInfo: [
          BrnTipInfoBean("标题栏", "这里是标题栏，显示当前页面的名称", ""),
          BrnTipInfoBean("标签组件", "这里是标签组件，你可以动态添加或者删除组件，当你点击后会将结果给你回传", ""),
          BrnTipInfoBean("左边的按钮", "这里是按钮，点击他试试", ""),
          BrnTipInfoBean("右边的按钮", "这里是按钮，点击他试试", ""),
          BrnTipInfoBean("左边的文本 ", "这是一个朴实无华的文本", ""),
          BrnTipInfoBean("右边文本 ", "这是一个枯燥文本", ""),
          BrnTipInfoBean("开始按钮 ", "点击开启引导动画", ""),
        ],
      ),
    );
  }

  List<String> nameList = [
    '这是一条很长很长很长很长很长很长很长很长很长很长的标签',
    '标签么么么么么',
    '标签么么没没没么么么',
    '标签么么么么么',
    '标签么么么么么'
  ];

  @override
  void initState() {
    super.initState();
    Timer(Duration(microseconds: 0), () {
      /// start the intro
      intro.start(context);
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: BrnAppBar(
          title: Text(
            '弱引导组件example',
            key: intro.keys[0],
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BrnSelectTagWidget',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '流式布局的自适应标签(最小宽度75)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                BrnSelectTag(
                    key: intro.keys[1],
                    tags: nameList,
                    tagWidth: (MediaQuery.of(context).size.width - 40 - 24) / 3,
                    fixWidthMode: false,
                    onSelect: (index) {
                      BrnToast.show("$index is selected", context);
                    }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      key: intro.keys[2],
                      onPressed: () {},
                      child: Text("需求1"),
                    ),
                    ElevatedButton(
                      key: intro.keys[3],
                      onPressed: () {},
                      child: Text("需求2"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 14,
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Text(
                        '左边的文字',
                        key: intro.keys[4],
                      ),
                    ),
                    Container(
                      width: 14,
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Text(
                        '右边的文字',
                        key: intro.keys[5],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: intro.keys[6],

          /// 1st guide
          child: Icon(
            Icons.play_arrow,
          ),
          onPressed: () {
            intro.start(context);
          },
        ),
      ),
      onWillPop: () async {
        // destroy guide page when tap back key
        intro.dispose();
        return true;
      },
    );
  }
}
