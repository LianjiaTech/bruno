

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// 通知样式example

class BrnNoticeBarExample extends StatelessWidget {
  final List<NoticeStyle> defaultStyles = [
    NoticeStyles.failWithArrow,
    NoticeStyles.failWithClose,
    NoticeStyles.runningWithArrow,
    NoticeStyles.runningWithClose,
    NoticeStyles.succeedWithArrow,
    NoticeStyles.succeedWithClose,
    NoticeStyles.warningWithArrow,
    NoticeStyles.warningWithClose,
    NoticeStyles.normalNoticeWithArrow,
    NoticeStyles.normalNoticeWithClose,
  ];

  final List<String> defaultContents = [
    "样式1：failWithArrow失败 + 箭头",
    "样式2：failWithClose失败 + 关闭",
    "样式3：runningWithArrow运行中 + 箭头",
    "样式4：runningWithClose运行中 + 关闭",
    "样式5：succeedWithArrow成功 + 箭头",
    "样式6：succeedWithClose成功 + 关闭",
    "样式7：warningWithArrow警告 + 箭头",
    "样式8：warningWithClose警告 + 关闭",
    "样式9：normalNoticeWithArrow普通通知 + 箭头",
    "样式10：normalNoticeWithClose普通通知 + 关闭",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '通知样式',
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
              ),
            ),
            BrnBubbleText(
              maxLines: 3,
              text: '默认支持10种通知样式，支持自定义icon、文字颜色和背景颜色，支持是否显示icon',
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
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
            Text(
              '跑马灯',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBar(
              content: '这是跑马灯的通知内容跑马灯的通知内容跑马灯的通知内容跑马灯的通知内容',
              marquee: true,
              noticeStyle: NoticeStyles.runningWithArrow,
              onNoticeTap: () {
                BrnToast.show('点击通知', context);
              },
              onRightIconTap: () {
                BrnToast.show('点击右侧图标', context);
              },
            ),
            Text(
              '异常案例：隐藏左侧图标',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBar(
              content: '这是通知内容',
              showLeftIcon: false,
              noticeStyle: NoticeStyles.runningWithArrow,
              onNoticeTap: () {
                BrnToast.show('点击通知', context);
              },
              onRightIconTap: () {
                BrnToast.show('点击右侧图标', context);
              },
            ),
            Text(
              '异常案例：隐藏右侧图标',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBar(
              content: '这是通知内容',
              showRightIcon: false,
              noticeStyle: NoticeStyles.runningWithArrow,
              onNoticeTap: () {
                BrnToast.show('点击通知', context);
              },
              onRightIconTap: () {
                BrnToast.show('点击右侧图标', context);
              },
            ),
            Text(
              '异常案例：不显示图标',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBar(
              content: '这是通知内容',
              showLeftIcon: false,
              showRightIcon: false,
              noticeStyle: NoticeStyles.runningWithArrow,
              onNoticeTap: () {
                BrnToast.show('点击通知', context);
              },
              onRightIconTap: () {
                BrnToast.show('点击右侧图标', context);
              },
            ),
            Text(
              '异常案例：通知文案特别长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBar(
              content: '这是通知内容这是通知内容这是通知内容这是通知内容这是通知内容这是通知内容这是通知内容',
              noticeStyle: NoticeStyles.runningWithArrow,
              onNoticeTap: () {
                BrnToast.show('点击通知', context);
              },
              onRightIconTap: () {
                BrnToast.show('点击右侧图标', context);
              },
            ),
            Text(
              '异常案例：自定义',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBar(
              content: '这是通知内容',
              textColor: Color(0xFF222222),
              // 通知颜色
              backgroundColor: Colors.grey,
              // 背景色
              leftWidget: BrunoTools.getAssetImage(BrnAsset.iconMore),

              ///左侧图标
              rightWidget: BrunoTools.getAssetImage(BrnAsset.iconMore),

              ///右侧图标
              onNoticeTap: () {
                BrnToast.show('点击通知', context);
              },
              onRightIconTap: () {
                BrnToast.show('点击右侧图标', context);
              },
            ),
            Text(
              '10种默认样式',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            Container(
              height: 460,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: BrnNoticeBar(
                      noticeStyle: defaultStyles[index],
                      content: defaultContents[index],
                      onNoticeTap: () {
                        BrnToast.show('点击通知', context);
                      },
                      onRightIconTap: () {
                        BrnToast.show('点击右侧图标', context);
                      },
                    ),
                  );
                },
              ),
            )
          ])),
    );
  }
}
