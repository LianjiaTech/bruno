

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/noticebar/notice_bar_with_button_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

/// 描述: 通知样式example入口

class BrnNoticeBarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int caseIndex = 3;
    if (caseIndex == 0) {
      return Scaffold(
          appBar: BrnAppBar(
            title: '通知',
          ),
          body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    BrnNoticeBar(
                      // minHeight: 46,
                      padding: EdgeInsets.all(10),
                      marquee: false,
                      leftWidget: Image.asset(
                        'assets/icons/icon_calendar_next_month.png',
                        package: 'bruno',
                        width: 14.0,
                        height: 14.0,
                      ),
                      content: "请保请保证信息填写真实有效请保证信息填写真实有效证信息填写真实有效请保证信息填写",
                      noticeStyle: NoticeStyles.warningWithClose,
                      showRightIcon: false,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        height: 50,
                        child: Center(
                          child: Text('$index'),
                        ),
                      );
                    },
                    itemCount: 20,
                  ),
                ),
              ]));
    } else if (caseIndex == 1) {
      return Scaffold(
          appBar: BrnAppBar(
            title: '通知ddd',
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      Container(
                        color: Colors.red,
                        height: 220,
                      ),
                      Container(
                        color: Colors.green,
                        height: 220,
                      ),
                      Container(
                        color: Colors.blue,
                        height: 220,
                      ),
                      Container(
                        color: Colors.purple,
                        height: 220,
                      ),
                      Container(
                        color: Colors.red,
                        height: 220,
                      ),
                    ]),
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Column(
                  children: <Widget>[
                    BrnNoticeBar(
                      // minHeight: 46,
                      padding: EdgeInsets.all(10),
                      marquee: false,
                      leftWidget: Image.asset(
                        'assets/icons/icon_calendar_next_month.png',
                        package: 'bruno',
                        width: 14.0,
                        height: 14.0,
                      ),
                      content: "请保请保证信实有效请保证信息填写",
                      noticeStyle: NoticeStyles.warningWithClose,
                      showRightIcon: false,
                    )
                  ],
                ),
              )
            ],
          ));
    }
    return Scaffold(
      appBar: BrnAppBar(
        title: '通知',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              BrnNoticeBar(
                // minHeight: 46,
                padding: EdgeInsets.all(10),
                marquee: false,
                leftWidget: Image.asset(
                  'assets/icons/icon_calendar_next_month.png',
                  package: 'bruno',
                  width: 14.0,
                  height: 14.0,
                ),
                content: "请保请保证信实有效请保证信息填写带带点",
                noticeStyle: NoticeStyles.warningWithClose,
                showRightIcon: false,
              )
            ]),
            ListItem(
              title: '样式一 ：高度36，左右两边是图标',
              describe: '点击可查看样式1更多example',
              describeColor: Color(0xFF0984F9),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BrnNoticeBarExample();
                }));
              },
            ),
            BrnNoticeBar(
              content: '这是通知内容',
              noticeStyle: NoticeStyles.runningWithArrow,
              onNoticeTap: () {
                BrnToast.show('点击通知', context);
              },
              onRightIconTap: () {
                BrnToast.show('点击右侧图标', context);
              },
            ),
            ListItem(
              title: '样式2：高度为56，左边是标签，右边是文字按钮',
              describe: '点击可查看样式2更多example',
              describeColor: Color(0xFF0984F9),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BrnNoticeBarWithButtonExample();
                }));
              },
            ),
            BrnNoticeBarWithButton(
              leftTagText: '任务',
              content: '这是通知内容',
              rightButtonText: '去完成',
              onRightButtonTap: () {
                BrnToast.show('点击右侧按钮', context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
