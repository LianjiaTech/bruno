

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class SubSwitchTitleExample extends StatefulWidget {
  @override
  _SubSwitchTitleExampleState createState() => _SubSwitchTitleExampleState();
}

class _SubSwitchTitleExampleState extends State<SubSwitchTitleExample>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      initialIndex: 0,
      length: 6,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '二级标题',
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
                text: "默认颜色文字颜色0XFF222222，选中文字颜色为主题色，没有下划线，"
                    "title之间水平间距为20，只有一个标题时，不显示选中态",
              ),
              Text(
                '正常案例',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnSubSwitchTitle(
                nameList: ['二级标题'],
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
              BrnSubSwitchTitle(
                nameList: ['二级标题1', '二级标题2'],
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
              BrnSubSwitchTitle(
                nameList: ['二级标题1', '二级标题2', '二级标题3'],
                defaultSelectIndex: 0,
                onSelect: (value) {
                  BrnToast.show(value.toString(), context);
                },
              ),
              Text(
                '异常案例个数特别多',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnSubSwitchTitle(
                nameList: [
                  '二级标题1',
                  '二级标题2',
                  '二级标题3',
                  '二级标题4',
                  '二级标题5',
                  '二级标题6'
                ],
                defaultSelectIndex: 0,
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
              BrnSubSwitchTitle(
                nameList: [
                  '二级标题1',
                  '二级标题2',
                  '二级标题3',
                  '二级标题4',
                  '二级标题5',
                  '二级标题6'
                ],
                defaultSelectIndex: 0,
                controller: _controller,
                onSelect: (value) {
                  BrnToast.show(value.toString(), context);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: BrnSmallOutlineButton(
                  title: '点击选中第三个',
                  onTap: () {
                    _controller.index = 2;
                  },
                ),
              ),
              Text(
                '异常案例文案过长',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnSubSwitchTitle(
                nameList: [
                  '二级标题1',
                  '二级标题二级标题二级标题二级标题二级标题二级标题2',
                  '二级标题3',
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
              BrnSubSwitchTitle(
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
              BrnSubSwitchTitle(
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
              BrnSubSwitchTitle(
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
