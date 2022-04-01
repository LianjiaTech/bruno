

import 'dart:async';

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/actionsheet/actionsheet_selected_list_custom_example.dart';
import 'package:example/sample/components/actionsheet/actionsheet_selected_list_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

class ActionSheetEntryPage extends StatefulWidget {
  final title;

  ActionSheetEntryPage(this.title);

  @override
  _ActionSheetEntryPageState createState() => _ActionSheetEntryPageState();
}

class _ActionSheetEntryPageState extends State<ActionSheetEntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: widget.title,
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              title: "CommonActionSheet",
              isSupportTheme: true,
              isShowLine: false,
              describe: '通用样式ActionSheet，无独立辅助信息',
              onPressed: () {
                _showCommonStylex();
              },
            ),
            ListItem(
              title: "CommonActionSheet",
              isSupportTheme: true,
              isShowLine: false,
              describe: '通用样式ActionSheet，包含描述信息',
              onPressed: () {
                _showCommonStyle(context);
              },
            ),
            ListItem(
              title: "CommonActionSheet",
              isSupportTheme: true,
              describe: '通用样式ActionSheet，不包含描述信息',
              onPressed: () {
                _showCommonStyle1(context);
              },
            ),
            ListItem(
              title: "CommonActionSheet",
              isSupportTheme: true,
              describe: '蓝色样式ActionSheet，不包含描述信息',
              onPressed: () {
                _showCommonStyle2(context);
              },
            ),
            ListItem(
              title: "CommonActionSheet",
              isSupportTheme: true,
              describe: '通用样式ActionSheet，自定义textstyle',
              onPressed: () {
                _showCommonCustomStyle(context);
              },
            ),
            ListItem(
              title: "CommonActionSheet",
              isSupportTheme: true,
              describe: '通用样式ActionSheet，选项名动态变化',
              onPressed: () {
                _showChangeableStyle(context);
              },
            ),
            ListItem(
              title: "分享ActionSheet（7项）",
              describe: '分享样式ActionSheet',
              onPressed: () {
                _showShareSevenStyle(context);
              },
            ),
            ListItem(
              title: "分享ActionSheet（双行8项）",
              describe: '分享样式ActionSheet',
              onPressed: () {
                _showShareFourStyle(context);
              },
            ),
            ListItem(
              title: "分享ActionSheet（双行3项）",
              describe: '分享样式ActionSheet',
              onPressed: () {
                _showShareThreeStyle(context);
              },
            ),
            ListItem(
              title: "分享ActionSheet（2项）",
              describe: '分享样式ActionSheet',
              onPressed: () {
                _showShareTwoStyle(context);
              },
            ),
            ListItem(
              title: "已选菜单列表",
              describe: '已选菜单列表',
              onPressed: () {
                _showSelectedListActionSheet(context);
              },
            ),
            ListItem(
              title: "已选菜单列表自定义视图",
              describe: '已选菜单列表自定义视图',
              onPressed: () {
                _showCustomSelectedListActionSheet(context);
              },
            ),
          ],
        ));
  }

  void _showCommonStyle(BuildContext context) {
    List<BrnCommonActionSheetItem> actions = [];
    actions.add(BrnCommonActionSheetItem(
      '选项一（警示项）',
      desc: '辅助信息辅助信息辅助信息',
      actionStyle: BrnCommonActionSheetItemStyle.alert,
    ));
    actions.add(BrnCommonActionSheetItem(
      '选项二',
      desc: '辅助信息辅助信息辅助信息',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));
    actions.add(BrnCommonActionSheetItem(
      '选项三',
      desc: '辅助信息辅助信息辅助信息',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));

    // 展示actionSheet
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return BrnCommonActionSheet(
            title: "辅助内容辅助内容辅助内容辅助内容辅助内容辅助内容辅助内容辅助内容辅助内容辅助内容辅助内容辅助内容",
            actions: actions,
            cancelTitle: "自定义取消名称",
            clickCallBack: (int index, BrnCommonActionSheetItem actionEle) {
              String? title = actionEle.title;
              BrnToast.show("title: $title, index: $index", context);
            },
          );
        });
  }

  void _showCommonStylex() {
    List<BrnCommonActionSheetItem> actions = [];
    // 构建标题+辅助信息的普通项
    actions.add(BrnCommonActionSheetItem(
      '选项一（警示项）',
      desc: '辅助信息辅助信息辅助信息辅助信息',
      actionStyle: BrnCommonActionSheetItemStyle.alert,
    ));
    // 构建标题+辅助信息的普通项
    actions.add(BrnCommonActionSheetItem(
      '选项二',
      desc: '辅助信息辅助信息辅助信息',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));
    // 构建只有标题的普通项
    actions.add(BrnCommonActionSheetItem(
      '选项三',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));
    // 构建不带标题栏的actionSheet
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return BrnCommonActionSheet(
            actions: actions,
            clickCallBack: (int index, BrnCommonActionSheetItem actionEle) {
              String? title = actionEle.title;
              BrnToast.show("title: $title, index: $index", context);
            },
          );
        });
  }

  void _showCommonStyle1(BuildContext context) {
    List<BrnCommonActionSheetItem> actions = [];
    actions.add(BrnCommonActionSheetItem(
      '选项一（警示项）',
      actionStyle: BrnCommonActionSheetItemStyle.alert,
    ));
    actions.add(BrnCommonActionSheetItem(
      '选项二',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));
    actions.add(BrnCommonActionSheetItem(
      '选项三',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));

    // 展示actionSheet
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return BrnCommonActionSheet(
            actions: actions,
            clickCallBack: (
              int index,
              BrnCommonActionSheetItem actionEle,
            ) {
              String? title = actionEle.title;
              BrnToast.show("title: $title, index: $index", context);
            },
          );
        });
  }

  void _showCommonStyle2(BuildContext context) {
    List<BrnCommonActionSheetItem> actions = [];
    actions.add(BrnCommonActionSheetItem(
      '选项一: （010）1234567',
      actionStyle: BrnCommonActionSheetItemStyle.link,
    ));
    actions.add(BrnCommonActionSheetItem(
      '选项二:（010）1234567',
      actionStyle: BrnCommonActionSheetItemStyle.link,
    ));
    actions.add(BrnCommonActionSheetItem(
      '选项三',
      actionStyle: BrnCommonActionSheetItemStyle.link,
    ));

    // 展示actionSheet
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return BrnCommonActionSheet(
            title: "电话等蓝色样式的需求",
            actions: actions,
            clickCallBack: (
              int index,
              BrnCommonActionSheetItem actionEle,
            ) {
              String? title = actionEle.title;
              BrnToast.show("title: $title, index: $index", context);
            },
          );
        });
  }

  void _showCommonCustomStyle(BuildContext context) {
    List<BrnCommonActionSheetItem> actions = [];
    actions.add(
      BrnCommonActionSheetItem(
        '选项一: 自定义主标题样式',
        desc: '辅助信息默认样式',
        titleStyle: TextStyle(
          fontSize: 18,
          color: Color(0xFF123984),
        ),
      ),
    );
    actions.add(
      BrnCommonActionSheetItem(
        '选项二: 自定义辅助信息样式',
        desc: '自定义辅助信息样式',
        descStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF129834),
        ),
      ),
    );
    actions.add(
      BrnCommonActionSheetItem(
        '选项三: 自定义拦截点击事件，点击无效',
        desc: '辅助信息',
        titleStyle: TextStyle(
          fontSize: 16,
          color: Color(0xFF999999),
        ),
        descStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF999999),
        ),
      ),
    );

    // 展示actionSheet
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return BrnCommonActionSheet(
            title: "自定义点击拦截事件，选项三点击不反回，其他选项点击事件正常，并且自定义标题最大行数为3行，超出会截断会截断会截断",
            actions: actions,
            maxTitleLines: 3,
            clickCallBack: (
              int index,
              BrnCommonActionSheetItem actionEle,
            ) {
              String? title = actionEle.title;
              BrnToast.show("title: $title, index: $index", context);
            },
            onItemClickInterceptor: (
              int index,
              BrnCommonActionSheetItem actionEle,
            ) {
              // 选项三点击事件被拦截，不作处理
              if (index == 2) {
                BrnToast.show("被拦截了", context);
                return true;
              }
              // 其他选项正常
              return false;
            },
          );
        });
  }

  void _showChangeableStyle(BuildContext context) {
    // 倒数次数
    var countdown = 10;
    // 用于控制timer只加载一次
    var started = false;
    // 计时器
    late Timer periodTimer;
    List<BrnCommonActionSheetItem> actions = [];
    actions.add(BrnCommonActionSheetItem(
      '倒计时:$countdown',
      actionStyle: BrnCommonActionSheetItemStyle.alert,
    ));
    actions.add(BrnCommonActionSheetItem(
      '选项二',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));
    actions.add(BrnCommonActionSheetItem(
      '选项三',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));
    // 展示actionSheet
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          // 通过statefulBuilder可以实现动态变换选项文案（本example只作为使用参考，请根据具体情况选择方式）
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            if (!started) {
              started = true;
              // 设置timer，每1秒循环一次
              periodTimer = Timer.periodic(Duration(seconds: 1), (timer) {
                if (countdown > 0) {
                  countdown = countdown - 1;
                  setState(() {
                    // 循环刷新当前时间,变换title
                    actions[0].title = '倒计时:$countdown';
                    // 变化特定辅助信息
                    var times = 10 - countdown;
                    actions[0].desc = '倒计时:$times';
                  });
                } else if (countdown == 0) {
                  periodTimer.cancel();
                }
              });
            }
            return BrnCommonActionSheet(
              actions: actions,
              clickCallBack: (
                int index,
                BrnCommonActionSheetItem actionEle,
              ) {
                // 点击后立即停止计时
                periodTimer.cancel();
                var title = actionEle.title;
                BrnToast.show("title: $title, index: $index", context);
              },
            );
          });
          // then用来在pop折后停止timer，如果不需要在pop后进行操作，不需要使用then
        }).then((value) {
      periodTimer.cancel();
    });
  }

  void _showShareSevenStyle(BuildContext context) {
    List<BrnShareItem> firstRowList = [];
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareWeiXin,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareBrowser,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareCopyLink,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareFriend,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareLink,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareQQ,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareCustom,
      customImage: BrunoTools.getAssetImage("images/icon_custom_share.png"),
      customTitle: "自定义",
      canClick: true,
    ));
    BrnShareActionSheet actionSheet = new BrnShareActionSheet(
      firstShareChannels: firstRowList,
      clickCallBack: (int section, int index, BrnShareItem shareItem) {
        int channel = shareItem.shareType;
        BrnToast.show(
            "channel: $channel, section: $section, index: $index", context);
      },
      cancelTitle: "自定义取消名字", // 取消按钮title可自定义
    );
    actionSheet.show(context);
  }

  void _showShareFourStyle(BuildContext context) {
    List<BrnShareItem> firstRowList = [];
    List<BrnShareItem> secondRowList = [];
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareQZone,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareSaveImage,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareSms,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareWeiBo,
      canClick: true,
    ));
    secondRowList.add(BrnShareItem(
      BrnShareItemConstants.shareQZone,
      canClick: false,
    ));
    secondRowList.add(BrnShareItem(
      BrnShareItemConstants.shareSaveImage,
      canClick: false,
    ));
    secondRowList.add(BrnShareItem(
      BrnShareItemConstants.shareSms,
      canClick: false,
    ));
    secondRowList.add(BrnShareItem(
      BrnShareItemConstants.shareWeiBo,
      canClick: false,
    ));
    BrnShareActionSheet actionSheet = new BrnShareActionSheet(
      firstShareChannels: firstRowList,
      secondShareChannels: secondRowList,
      clickCallBack: (int section, int index, BrnShareItem shareItem) {
        int channel = shareItem.shareType;
        BrnToast.show(
            "channel: $channel, section: $section, index: $index", context);
      },
      clickInterceptor: (int section, int index, BrnShareItem shareItem) {
        if (shareItem.canClick) {
          return false;
        } else {
          BrnToast.show("不可点击，拦截了", context);
          return true;
        }
      },
    );
    actionSheet.show(context);
  }

  void _showShareThreeStyle(BuildContext context) {
    List<BrnShareItem> firstRowList = [];
    List<BrnShareItem> secondRowList = [];
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareWeiXin,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareFriend,
      canClick: true,
    ));
    secondRowList.add(BrnShareItem(
      BrnShareItemConstants.shareCustom,
      customImage: BrunoTools.getAssetImage("images/icon_custom_share.png"),
      customTitle: "自定义",
      canClick: true,
    ));
    BrnShareActionSheet actionSheet = new BrnShareActionSheet(
      firstShareChannels: firstRowList,
      secondShareChannels: secondRowList,
      clickCallBack: (int section, int index, BrnShareItem shareItem) {
        int channel = shareItem.shareType;
        BrnToast.show(
            "channel: $channel, section: $section, index: $index", context);
      },
    );
    actionSheet.show(context);
  }

  void _showShareTwoStyle(BuildContext context) {
    List<BrnShareItem> firstRowList = [];
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareWeiXin,
      canClick: true,
    ));
    firstRowList.add(BrnShareItem(
      BrnShareItemConstants.shareFriend,
      canClick: true,
    ));
    BrnShareActionSheet actionSheet = new BrnShareActionSheet(
      firstShareChannels: firstRowList,
      clickCallBack: (int section, int index, BrnShareItem shareItem) {
        int channel = shareItem.shareType;
        BrnToast.show(
            "channel: $channel, section: $section, index: $index", context);
      },
    );
    actionSheet.show(context);
  }

  void _showSelectedListActionSheet(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return SelectedListActionSheetExamplePage();
      },
    ));
  }

  void _showCustomSelectedListActionSheet(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return SelectedListActionSheetCustomExamplePage();
      },
    ));
  }
}
