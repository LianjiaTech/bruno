

import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CitySelectRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CitySelectRouteState();
  }
}

class _CitySelectRouteState extends State<CitySelectRoute> {
  List<BrnSelectCityModel> _cityList = [];
  List<BrnSelectCityModel> _hotCityList = [];

  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    _hotCityList.add(BrnSelectCityModel(name: "北京市", tagIndex: "★"));
    //加载城市列表
    rootBundle.loadString('assets/china.json').then((value) {
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      list.forEach((value) {
        _cityList.add(BrnSelectCityModel(name: value['name']));
      });
      _handleList(_cityList);
      _cityList.insertAll(0, _hotCityList);
      setState(() {
        _suspensionTag = _cityList[0].getSuspensionTag();
      });
    });
  }

  void _handleList(List<BrnSelectCityModel> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cityList);
  }

  //悬浮的城市 tag
  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  Widget _buildSusWidget(String susTag) {
    susTag = (susTag == "★" ? "默认城市" : susTag);
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 20.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 13.0,
          color: Color(0xff9399A5),
        ),
      ),
    );
  }

  Widget _buildListItem(BrnSelectCityModel model) {
    String susTag = model.getSuspensionTag();
    susTag = (susTag == "★" ? "默认城市" : susTag);
    return Column(
      children: <Widget>[
        //当offstage为true，当前控件不会被绘制在屏幕上
        //如果条目不是悬浮的(北京)，则不显示
        Offstage(
          offstage: !model.isShowSuspension,
          child: _buildSusWidget(susTag),
        ),

        Container(
          height: (_itemHeight - 0.5).toDouble(),
          padding: const EdgeInsets.only(left: 20.0),
          color: Colors.white,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              model.name,
              style: TextStyle(color: Color(0xff101D37), fontSize: 16),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Container(
            height: 0.5,
            color: Color(0xffE4E6F0),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '选择城市 Example',
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: AzListView(
                data: _cityList,
                itemBuilder: (context, model) =>
                    _buildListItem(model as BrnSelectCityModel),
                suspensionWidget: _buildSusWidget(_suspensionTag),
                isUseRealIndex: true,
                itemHeight: _itemHeight,
                suspensionHeight: _suspensionHeight,
                onSusTagChanged: _onSusTagChanged,
              )),
        ],
      ),
    );
  }
}
