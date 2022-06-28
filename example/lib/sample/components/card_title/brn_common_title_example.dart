

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BrnCommonTitleExample extends StatefulWidget {
  @override
  _BrnCommonTitleExampleState createState() => _BrnCommonTitleExampleState();
}

class _BrnCommonTitleExampleState extends State<BrnCommonTitleExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '普通标题',
      ),
      body: SingleChildScrollView(
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
              text: '标题可以折行展示，标题最右侧的widget 需要展示出来\n'
                  '标题底部的detail 信息展示的长度是 折行的长度，只显示2行\n'
                  '标题的文案和sub需要流式布局\n'
                  'accessoryWidget的高度就是25，如果传入的widget过大会显示不全\n'
                  '上下的间距是16',
            ),
            SizedBox(height: 50,),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnCommonCardTitle(
              title: '标题',
              accessoryText: '辅助文本',
              onTap: () {
                BrnToast.show('BrnPlainCardTitle is clicked', context);
              },
            ),
            SizedBox(height: 50,),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnCommonCardTitle(
              title: '非箭头Title',
              subTitleWidget: BrnRatingStar(
                count: 2,
                selectedCount: 2,
              ),
              accessoryWidget: BrnStateTag(tagText: '状态标签'),
              detailTextString: '副标题副标题副标题',
              onTap: () {
                BrnToast.show('BrnPlainCardTitle is clicked', context);
              },
            ),
            SizedBox(height: 50,),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnCommonCardTitle(
              title: '非箭头Title',
              //标题右侧widget
              subTitleWidget: Icon(
                Icons.content_copy,
                size: 16,
                color: Colors.blue,
              ),
              accessoryText: '辅助功能',
              accessoryWidget: Icon(
                Icons.radio_button_checked,
                size: 16,
                color: Colors.blue,
              ),
              detailTextString: '字房产证地址与楼盘字房产证地址与楼盘字',
              //整个widget的点击
              onTap: () {
                BrnToast.show('BrnCommonCardTitle is clicked', context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
