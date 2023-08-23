import 'dart:async';

import 'package:bruno/src/components/empty/brn_empty_status.dart';
import 'package:bruno/src/components/loading/brn_loading.dart';
import 'package:bruno/src/components/selectcity/brn_az_common.dart';
import 'package:bruno/src/components/selectcity/brn_az_listview.dart';
import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';

/// 带右侧定位器的list页面
abstract class BaseAZListViewPage extends StatefulWidget {
  @override
  _BaseAZListViewPageState createState() => _BaseAZListViewPageState();

  /// 设置页面的title
  PreferredSizeWidget createAppBar();

  /// 设置页面的数据源
  Future createFuture();

  /// 从数据源中提取列表
  List<ISuspensionBean> pickListFromData(data);

  /// 列表的widget
  Widget buildItemWidget(ISuspensionBean item);

  /// 悬浮的widget
  Widget buildSuspensionWidget(String? tag);

  /// 顶部展示的数据
  List<ISuspensionBean> getTopData() {
    return <ISuspensionBean>[];
  }

  /// item的高度 默认50
  double getItemHeight() => 50.0;

  /// 悬浮的条目的高度
  double getSuspensionHeight() => 46.0;

  /// 每个modal 对应的 tag，默认是拼音来设置
  String createTagByModal(ISuspensionBean bean) {
    if (bean.name.isNotEmpty) {
      String pinyin = PinyinHelper.getPinyinE(bean.name);
      return pinyin.substring(0, 1).toUpperCase();
    }
    return "";
  }
}

class _BaseAZListViewPageState extends State<BaseAZListViewPage> {
  String? suspensionTag = "";

  List<ISuspensionBean> _dataList = [];
  late StreamController<String> streamController;

  @override
  void initState() {
    super.initState();
    streamController = StreamController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.createAppBar(),
        body: FutureBuilder(
          future: widget.createFuture(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return BrnPageLoading();
            }

            if (snapShot.connectionState == ConnectionState.done) {
              if (snapShot.hasError) {
                return BrnAbnormalStateUtils.getEmptyWidgetByState(
                    context, AbnormalState.networkConnectError,
                    action: (index) {
                  setState(() {});
                });
              } else {
                return buildContentBody(snapShot.data);
              }
            }
            return Container();
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  Widget buildContentBody(data) {
    _dataList = widget.pickListFromData(data);
    _handleList(_dataList);

    List<ISuspensionBean> top = widget.getTopData();

    if (_dataList.isEmpty && top.isEmpty) {
      return BrnAbnormalStateUtils.getEmptyWidgetByState(
          context, AbnormalState.noData);
    }

    suspensionTag = top.isEmpty ? _dataList[0].tag : top[0].tag;

    return Column(
      children: <Widget>[
        Expanded(
            child: StreamBuilder(
          initialData: suspensionTag,
          stream: streamController.stream,
          builder: (context, AsyncSnapshot snapShot) {
            return AzListView(
              data: _dataList,
              topData: top,
              itemBuilder: (context, model) => _buildListItem(model),
              suspensionWidget: _buildSusWidget(snapShot.data),
              isUseRealIndex: true,
              itemHeight: widget.getItemHeight().toInt(),
              suspensionHeight: widget.getSuspensionHeight().toInt(),
              onSusTagChanged: (data) {
                _onSusTagChanged(data);
              },
            );
          },
        )),
      ],
    );
  }

  Widget _buildSusWidget(String? susTag) {
    return Container(
      height: widget.getSuspensionHeight(),
      child: widget.buildSuspensionWidget(susTag),
    );
  }

  void _handleList(List<ISuspensionBean>? list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String tag = widget.createTagByModal(list[i]);
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tag = tag;
      } else {
        list[i].tag = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_dataList);
  }

  void _onSusTagChanged(String tag) {
    streamController.add(tag);
  }

  Widget _buildListItem(ISuspensionBean model) {
    String? susTag = model.tag;
    return Column(
      children: <Widget>[
        //当offstage为true，当前控件不会被绘制在屏幕上
        //如果条目不是悬浮的(北京)，则不显示
        Offstage(
          offstage: !model.isShowSuspension,
          child: _buildSusWidget(susTag),
        ),

        Container(
          height: widget.getItemHeight(),
          child: widget.buildItemWidget(model),
        ),
      ],
    );
  }
}
