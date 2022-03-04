

import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';

class BrnTagsPickerHeaderConfig {
  BrnTagsPickerHeaderConfig({
    this.headerHeight = 48,
    this.title = "",
    this.titleColor,
    this.titleFontSize = 18,
    this.confirmTitle = '确定',
    this.confirmColor,
    this.confirmFontSize = 18,
    this.cancelTitle = "取消",
    this.cancelColor,
    this.cancelFontSize = 18,
    this.dividingLineColor,
  }) {
    this.titleColor =
        BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase;
    this.cancelColor =
        BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase;
  }

  final double headerHeight;

  final String title;
  Color? titleColor;
  final double titleFontSize;

  final String confirmTitle;
  final Color? confirmColor;
  final double confirmFontSize;

  final String cancelTitle;
  Color? cancelColor;
  final double cancelFontSize;

  //分割线颜色
  final Color? dividingLineColor;
}

class BrnTagsPickerConfig {
  BrnTagsPickerConfig(
      {this.tagTitleFontSize = 16.0,
      this.tagTitleColor,
      this.selectedTagTitleColor,
      this.tagBackgroudColor,
      this.selectedTagBackgroudColor,
      this.chipPadding,
      this.tagItemSource = const []}) {
    this.tagTitleColor =
        BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase;
  }

  ///tag 文字大小
  double tagTitleFontSize;

  ///tag 文字颜色
  Color? tagTitleColor;

  ///选中的tag颜色
  Color? selectedTagTitleColor;

  ///tag 背景颜色
  Color? tagBackgroudColor;

  ///选中的颜色
  Color? selectedTagBackgroudColor;

  ///内部item的边距
  EdgeInsets? chipPadding;

  ///数据源
  List<BrnTagItemBean> tagItemSource;
}

class BrnTagItemBean {
  ///展示的名称
  String name;

  ///code唯一标识
  String code;

  ///code唯一标识
  int? index;

  ///是被选中
  bool isSelect;

  ///自己添加的扩展
  Map? ext;

  BrnTagItemBean(
      {this.name = '',
      this.code = '',
      this.index,
      this.isSelect = false,
      this.ext});
}
