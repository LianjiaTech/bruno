

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class AbnomalStateExample extends StatelessWidget {
  final int? caseIndex;

  AbnomalStateExample({this.caseIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: '异常页面',
        ),
        body: _buildEmpty(caseIndex, context));
  }

  Widget? _buildEmpty(int? index, BuildContext context) {
    Widget? widget;
    switch (index) {
      case 0:
        widget = BrnAbnormalStateWidget(
          img: Image.asset(
            'assets/image/content_failed.png',
            scale: 3.0,
          ),
          isCenterVertical: true,
          title: "获取数据失败，请重试",
          operateTexts: <String>["请点击页面重试"],
          operateAreaType: OperateAreaType.textButton,
          action: (index) {
            BrnToast.show("获取数据失败，请重试", context);
          },
        );
        break;
      case 1:
        widget = BrnAbnormalStateWidget(
          isCenterVertical: true,
          img: Image.asset(
            'assets/image/no_data.png',
            scale: 3.0,
          ),
          title: BrnIntl.of(context).localizedResource.noDataTip,
        );
        break;
      case 2:
        widget = BrnAbnormalStateWidget(
          img: Image.asset(
            'assets/image/network_error.png',
            scale: 3.0,
          ),
          title: '网络数据异常',
        );
        break;
      case 3:
        widget = BrnAbnormalStateWidget(
          img: Image.asset(
            'assets/image/no_data.png',
            scale: 3.0,
          ),
          content: '您的门店暂无用户',
        );
        break;
      case 4:
        widget = BrnAbnormalStateWidget(
          img: Image.asset(
            'assets/image/no_data.png',
            scale: 3.0,
          ),
          title: "这是副标题内容这是副标题内容这是副标",
          content: '您的门店暂无用户',
          operateAreaType: OperateAreaType.singleButton,
          operateTexts: ["切换账号"],
          action: (_) {
            BrnToast.show("第$_个按钮被点击了", context);
          },
        );
        break;
      case 5:
        widget = BrnAbnormalStateWidget(
          img: Image.asset(
            'assets/image/no_data.png',
            scale: 3.0,
          ),
          title: "暂无",
          content: '您还没有在维护的信息哦',
          operateAreaType: OperateAreaType.doubleButton,
          operateTexts: ['去添加', '去修改'],
          action: (_) {
            BrnToast.show("第$_个按钮被点击了", context);
          },
        );
        break;
      case 6:
        widget = BrnAbnormalStateWidget(
          content: '您的门店暂无用户',
        );
        break;
    }

    return widget;
  }
}
