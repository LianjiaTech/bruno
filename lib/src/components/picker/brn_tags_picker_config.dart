

import 'package:flutter/material.dart';

class BrnTagsPickerConfig {
  BrnTagsPickerConfig(
      {this.tagTitleFontSize = 16.0,
      this.tagTitleColor,
      this.selectedTagTitleColor,
      this.tagBackgroudColor,
      this.selectedTagBackgroudColor,
      this.chipPadding,
      this.tagItemSource = const []});

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
