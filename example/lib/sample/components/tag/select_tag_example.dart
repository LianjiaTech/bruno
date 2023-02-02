import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

///标签选择view
class SelectTagExamplePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectTagExamplePageState();
}

class SelectTagExamplePageState extends State<SelectTagExamplePage> {
  List<String> tagList = [
    '这是一条很长很长很长很长很长很长很长很长很长很长的标签',
    '标签信息',
    '标签信息标签信息',
    '标签信息',
    '标签信息标签信息标签信息标签信息'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'BrnSelectTag',
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[_selectButtonExampleWidget(context)],
        ),
      ),
    );
  }

  Widget _selectButtonExampleWidget(context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'BrnSelectTag',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            '单选功能',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          BrnSelectTag(
              tags: tagList,
              spacing: 12,
              tagWidth: _getTagWidth(context),
              initTagState: [true],
              onSelect: (selectedIndexes) {
                BrnToast.show(selectedIndexes.toString(), context);
              }),
          Text(
            '多选功能',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          BrnSelectTag(
              isSingleSelect: false,
              tags: tagList,
              spacing: 12,
              tagWidth: _getTagWidth(context),
              initTagState: [true, false, true],
              onSelect: (selectedIndexes) {
                BrnToast.show(selectedIndexes.toString(), context);
              }),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '流式布局的自适应标签',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          BrnSelectTag(
              tags: [
                '标签',
                '选中标签',
                '未选中标签',
                '标签圆角、字号、色值、高度都可主题配置',
                '组件可设置固定宽度还是流式布局',
                '主题定制可配置最小宽度，现在限制的最小宽度是110'
              ],
              isSingleSelect: false,
              fixWidthMode: false,
              spacing: 12,
              onSelect: (selectedIndexes) {
                BrnToast.show(selectedIndexes.toString(), context);
              }),
          SizedBox(
            height: 10,
          ),
          Text(
            '横向滑动，等宽标签',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          BrnSelectTag(
              tags: tagList,
              tagWidth: _getTagWidth(context),
              softWrap: false,
              onSelect: (index) {
                BrnToast.show("$index is selected", context);
              }),
          SizedBox(
            height: 10,
          ),
          Text(
            '横向滑动的自适应宽度标签(最小宽度75)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          BrnSelectTag(
              tags: tagList,
              tagWidth: _getTagWidth(context),
              softWrap: false,
              fixWidthMode: false,
              onSelect: (index) {
                BrnToast.show("$index is selected", context);
              }),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  double _getTagWidth(context, {int rowCount = 4}) {
    double leftRightPadding = 40;
    double rowSpace = 12;
    return (MediaQuery.of(context).size.width -
            leftRightPadding -
            rowSpace * (rowCount - 1)) /
        rowCount;
  }
}
