import 'dart:convert';

import 'package:bruno/src/components/empty/brn_empty_status.dart';
import 'package:bruno/src/components/navbar/brn_appbar.dart';
import 'package:bruno/src/components/selectcity/brn_az_common.dart';
import 'package:bruno/src/components/selectcity/brn_az_listview.dart';
import 'package:bruno/src/components/selectcity/brn_select_city_model.dart';
import 'package:bruno/src/components/sugsearch/brn_search_text.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/constants/brn_strings_constants.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:bruno/src/constants/brn_fonts_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';

/// 简述：[BrnSingleSelectCityPage]是用于城市选择的单选页面，
/// 功能：多可以自定制导航栏文案，搜索文案信息，定位信息，右侧可快速滑动查看城市
class BrnSingleSelectCityPage extends StatefulWidget {
  /// 页面标题，默认空
  final String? appBarTitle;

  /// 热门推荐标题，默认空
  final String? hotCityTitle;

  /// 是否展示searchBar，默认 true
  final bool showSearchBar;

  /// 当前城市定位文案展示
  final String locationText;

  /// 城市列表
  final List<BrnSelectCityModel>? cityList;

  /// 热门推荐城市列表
  final List<BrnSelectCityModel> hotCityList;

  /// 单选项 点击的回调
  final ValueChanged<BrnSelectCityModel>? onValueChanged;

  /// 空页面中间展位图展示
  final Image? emptyImage;

  BrnSingleSelectCityPage({
    this.appBarTitle = '',
    this.hotCityTitle = '',
    required this.hotCityList,
    this.cityList,
    this.showSearchBar = true,
    this.locationText = '',
    this.onValueChanged,
    this.emptyImage,
  });

  @override
  State<StatefulWidget> createState() {
    return _BrnSingleSelectCityPageState();
  }
}

class _BrnSingleSelectCityPageState extends State<BrnSingleSelectCityPage> {
  List<BrnSelectCityModel> _cityList = [];

  ///搜索框的高度
  int _suspensionHeight = 40;

  /// 热门的按钮高度
  int _itemHeight = 50;

  ///当前展示的文案信息
  String _suspensionTag = "";

  ///是否展示城市的stack
  bool _showCityStack = true;

  ///搜索的文案
  String _searchText = "";

  /// search的TextController
  late BrnSearchTextController _brnSearchTextController;

  @override
  void initState() {
    super.initState();
    _brnSearchTextController = BrnSearchTextController();
    _loadData();
  }

  void _loadData() async {
    if (widget.cityList == null || widget.cityList!.isEmpty) {
      //加载城市列表
      rootBundle
          .loadString(
              'packages/${BrnStrings.flutterPackageName}/assets/json/china.json')
          .then((value) {
        Map countyMap = json.decode(value);
        List list = countyMap['china'];
        list.forEach((value) {
          _cityList.add(BrnSelectCityModel(name: value['name']));
        });
        _handleList(_cityList);
        setState(() {});
      });
    } else {
      _cityList = widget.cityList!;
      _handleList(_cityList);
      setState(() {});
    }
  }

  void _handleList(List<BrnSelectCityModel>? list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
        list[i].tag = tag;
      } else {
        list[i].tagIndex = "#";
        list[i].tag = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cityList);
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  Widget _buildHeader() {
    List<BrnSelectCityModel> hotCityList = widget.hotCityList;
    double width = (MediaQuery.of(context).size.width - 70) / 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 0),
          child: Text(
            widget.hotCityTitle ?? BrnIntl.of(context).localizedResource.recommandCity,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 0),
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 10.0,
            children: hotCityList.map((e) {
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  side: BorderSide(color: Color(0xFFF8F8F8), width: .5),
                  backgroundColor: Color(0xFFF8F8F8),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 36.0,
                  width: width,
                  padding: EdgeInsets.all(0),
                  color: Color(0xFFF8F8F8),
                  child: Text(
                    e.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: BrnFonts.f12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                onPressed: () {
                  debugPrint("OnItemClick: $e");
                  if (widget.onValueChanged != null) {
                    widget.onValueChanged!(e);
                  }
                  Navigator.pop(context, e);
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildSusWidget(String? susTag) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildListItem(BrnSelectCityModel model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            title: Text(model.name),
            onTap: () {
              debugPrint("OnItemClick: $model");
              if (widget.onValueChanged != null) {
                widget.onValueChanged!(model);
              }
              Navigator.pop(context, model);
            },
          ),
        )
      ],
    );
  }

  Widget _buildSearchBar() {
    return BrnSearchText(
      searchController: _brnSearchTextController,
      hintText: BrnIntl.of(context).localizedResource.inputSearchTip,
      onTextChange: (text) {
        _searchText = text;
        _showCityStack = text.isEmpty;
        setState(() {});
      },
      onTextCommit: (text) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onActionTap: () {
        _showCityStack = true;
        _brnSearchTextController.isActionShow = false;
        _brnSearchTextController.isClearShow = false;
        setState(() {
          FocusScope.of(context).requestFocus(FocusNode());
        });
      },
    );
  }

  ///定位当前 城市
  Widget _buildLocationBar(String locationText) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.place,
              size: 20.0,
            ),
            Text(locationText),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BrnAppBar(title: widget.appBarTitle ?? BrnIntl.of(context).localizedResource.selectCity),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              widget.locationText.isEmpty
                  ? const SizedBox.shrink()
                  : _buildLocationBar(widget.locationText),
              widget.showSearchBar ? _buildSearchBar() : const SizedBox.shrink(),
              Divider(
                height: .0,
              ),
              _showCityStack
                  ? _buildCityList()
                  : _buildSearchResultList(_searchText),
            ],
          ),
        ));
  }

  ///展示城市列表
  Widget _buildCityList() {
    int num = widget.hotCityList.length ~/ 3;
    int rem = widget.hotCityList.length % 3;
    int addRem = (rem > 0) ? 1 : 0;
    int headerHeight = (num + addRem) * 38 + 20 + 42 + 10;
    if (num == 0 && rem == 0) {
      headerHeight = 0;
    }
    if (_suspensionTag.isEmpty || _suspensionTag == '') {
      if (_cityList.isNotEmpty) {
        _suspensionTag = _cityList.first.tag;
      }
    }
    return Expanded(
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
          header: AzListViewHeader(
              tag: "#",
              height: headerHeight,
              builder: (context) {
                return _buildHeader();
              }),
          indexHintBuilder: (context, hint) {
            return Container(
              alignment: Alignment.center,
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: Color(0x22222222),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Text(hint,
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
            );
          },
        ));
  }

  ///城市搜索结果页
  Widget _buildSearchResultList(String searchText) {
    List<BrnSelectCityModel> cList = _searchCityList(searchText);
    return (cList.isEmpty)
        ? _noDataWidget()
        : Expanded(
            flex: 1,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _buildListItem(cList[index]);
              },
              itemCount: cList.length,
            ),
          );
  }

  ///没有数据的占位图
  Widget _noDataWidget() {
    return Container(
      child: BrnAbnormalStateWidget(
        img: BrunoTools.getAssetImage(BrnAsset.noData),
        title: BrnIntl.of(context).localizedResource.noSearchData,
      ),
    );
  }

  ///获取城市搜索结果
  List<BrnSelectCityModel> _searchCityList(String searchText) {
    List<BrnSelectCityModel> cList = [];
    for (int index = 0; index < _cityList.length; index++) {
      BrnSelectCityModel cInfo = _cityList[index];
      if (cInfo.name.contains(searchText) ||
          cInfo.tag.contains(searchText) ||
          cInfo.tag.contains(searchText.toUpperCase())) {
        cList.add(cInfo);
      }
    }
    return cList;
  }
}
