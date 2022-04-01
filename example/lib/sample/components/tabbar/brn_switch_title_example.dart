

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BrnSwitchTitleExample extends StatefulWidget {
  @override
  _BrnSwitchTitleExampleState createState() => _BrnSwitchTitleExampleState();
}

class _BrnSwitchTitleExampleState extends State<BrnSwitchTitleExample>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      initialIndex: 1,
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '一级标题',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
              BrnBubbleText(
                maxLines: 4,
                text: "默认颜色文字颜色0XFF243238，选中文字颜色为主题色，title之间水平间距为20，"
                    "上下间距为14，title下面有分割线。只有一个标题时，不显示下划线、分割线和选中态",
              ),
              Text(
                '正常案例',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnSwitchTitle(
                nameList: ['标题内容'],
                onSelect: (value) {
                  BrnToast.show(value.toString(), context);
                },
              ),
              Text(
                '正常案例',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnSwitchTitle(
                nameList: ['标题内容1', '标题内容2'],
                indicatorWeight: 0,
                indicatorWidth: 0,
                padding: EdgeInsets.all(0),
                selectedTextStyle: TextStyle(fontSize: 24),
                unselectedTextStyle: TextStyle(fontSize: 12),
                onSelect: (value) {
                  BrnToast.show(value.toString(), context);
                },
              ),
              Text(
                '正常案例:外部调用tab切换',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnSwitchTitle(
                nameList: ['标题内容1', '标题内容2', '标题内容3'],
                defaultSelectIndex: 0,
                controller: _controller,
                onSelect: (value) {
                  BrnToast.show(value.toString(), context);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: BrnSmallOutlineButton(
                  title: '点击选中第二个',
                  onTap: () {
                    _controller.index = 1;
                  },
                ),
              ),
              Text(
                '异常案例个数特别多',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnSwitchTitle(
                nameList: [
                  '标题内容1',
                  '标题内容2',
                  '标题内容3',
                  '标题内容4',
                  '标题内容5',
                  '标题内容6'
                ],
                defaultSelectIndex: 0,
                onSelect: (value) {
                  BrnToast.show(value.toString(), context);
                },
              ),
              Text(
                '异常案例文案过长',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnSwitchTitle(
                nameList: [
                  '标题内容1',
                  '标题内容标题内容标题内容标题内容标题内容标题内容2',
                  '标题内容3',
                ],
                defaultSelectIndex: 0,
                onSelect: (value) {
                  BrnToast.show(value.toString(), context);
                },
              ),
              Text(
                '异常案例文案长度为1',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnSwitchTitle(
                nameList: [
                  '1',
                  '2',
                  '3',
                ],
                defaultSelectIndex: 0,
                onSelect: (value) {
                  BrnToast.show(value.toString(), context);
                },
              ),
              Text(
                '异常案例文案长度为0',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnSwitchTitle(
                nameList: [
                  '1',
                  '2',
                  '3',
                ],
                defaultSelectIndex: 0,
                onSelect: (value) {
                  BrnToast.show(value.toString(), context);
                },
              ),
              BrnSwitchTitle(
                nameList: [
                  '1',
                  '',
                  '3',
                ],
                defaultSelectIndex: 0,
                onSelect: (value) {
                  BrnToast.show(value.toString(), context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
