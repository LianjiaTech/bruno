

import 'package:bruno/src/components/picker/base/brn_picker_title_config.dart';
import 'package:bruno/src/components/picker/brn_tags_common_picker.dart';
import 'package:bruno/src/components/picker/brn_tags_picker_config.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_picker_config.dart';
import 'package:flutter/material.dart';

///样式的枚举类型
/// [average] 等分布局
/// [auto] 流式布局
enum BrnMultiSelectTagsLayoutStyle {
  ///等分布局
  average,

  ///流式布局
  auto,
}

typedef BrnMultiSelectTagStringBuilder<V> = String Function(V data);
typedef BrnMultiSelectTagOnItemClick = void Function(
    BrnTagItemBean onTapTag, bool isSelect);

/// 多选标签弹框,适用于底部弹出 Picker，且选择样式为 Tag 的场景。
/// 功能：多选标签弹框，适用于从底部弹出的情况，属于 Picker；
/// 可自定义标题、默认选中、字体大小等。
// ignore: must_be_immutable
class BrnMultiSelectTagsPicker extends CommonTagsPicker {
  BrnMultiSelectTagsPicker({
    Key? key,
    required this.context,
    required this.onConfirm,
    this.onCancel,
    required this.tagPickerConfig,
    required this.onTagValueGetter,
    this.onMaxSelectClick,
    this.onItemClick,
    this.maxSelectItemCount = 0,
    this.crossAxisCount,
    this.itemHeight = 34.0,
    this.layoutStyle = BrnMultiSelectTagsLayoutStyle.average,
    BrnPickerTitleConfig pickerTitleConfig = BrnPickerTitleConfig.Default,
    BrnPickerConfig? themeData,
  }) : super(
            key: key,
            context: context,
            onConfirm: onConfirm,
            onCancel: onCancel,
            pickerTitleConfig: pickerTitleConfig,
            themeData: themeData);

  /// 父类属性
  final BuildContext context;

  /// 点击提交功能
  final ValueChanged onConfirm;

  /// 点击取消按钮
  final VoidCallback? onCancel;

  /// 当点击到最大数目时的点击事件
  final VoidCallback? onMaxSelectClick;

  /// 点击某个按钮的回调
  final BrnMultiSelectTagOnItemClick? onItemClick;

  /// 一行多少个数据，默认4个
  final int? crossAxisCount;

  /// 最多选择多少个item，默认可以无限选
  final int maxSelectItemCount;

  /// 本类属性
  final BrnTagsPickerConfig tagPickerConfig;

  /// 传入的泛型数据转换为 [BrnTagItemBean]
  /// 默认以填充Widget
  final BrnMultiSelectTagStringBuilder<BrnTagItemBean> onTagValueGetter;

  /// 是等分样式还是流式布局样式，[BrnMultiSelectTagsLayoutStyle]，默认等分
  final BrnMultiSelectTagsLayoutStyle layoutStyle;

  /// item的高度, 默认数值是34
  final double itemHeight;

  /// 操作类型属性
  late List<BrnTagItemBean> _selectedTags;
  late List<BrnTagItemBean> _sourceTags;

  @override
  void show() {
    _dataSetup();
    super.show();
  }

  @override
  Object getConfirmData() {
    return this._selectedTags;
  }

  @override
  Widget createBuilder(BuildContext context, VoidCallback? onUpdate) {
    if (this.tagPickerConfig.tagItemSource.isNotEmpty) {
      return _buildContent(context, onUpdate);
    } else {
      return Container(
        height: 200,
        child: Center(
          child: Text('未配置tags数据'),
        ),
      );
    }
  }

  Widget _buildContent(BuildContext context, VoidCallback? onUpdate) {
    if (this.layoutStyle == BrnMultiSelectTagsLayoutStyle.average) {
      return LayoutBuilder(
        builder: (_, constraints) {
          double maxWidth = constraints.maxWidth;
          return _buildGridViewWidget(context, onUpdate, maxWidth);
        },
      );
    } else {
      return _buildWrapViewWidget(context, onUpdate);
    }
  }

  ///等宽度的布局
  Widget _buildGridViewWidget(
      BuildContext context, VoidCallback? onUpdate, double maxWidth) {
    int brnCrossAxisCount =
        (this.crossAxisCount == null || this.crossAxisCount == 0)
            ? 4
            : this.crossAxisCount!;
    double width =
        (maxWidth - (brnCrossAxisCount - 1) * 12 - 40) / brnCrossAxisCount;
    //计算宽高比
    double brnChildAspectRatio = width / this.itemHeight;
    Color selectedTagTitleColor = this.tagPickerConfig.selectedTagTitleColor ??
        BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary;
    Color tagTitleColor = this.tagPickerConfig.tagTitleColor ??
        BrnThemeConfigurator.instance
            .getConfig()
            .commonConfig
            .colorTextImportant;
    Color tagBackgroundColor =
        this.tagPickerConfig.tagBackgroudColor ?? Color(0xffF8F8F8);
    Color selectedTagBackgroundColor =
        this.tagPickerConfig.selectedTagBackgroudColor ??
            BrnThemeConfigurator.instance
                .getConfig()
                .commonConfig
                .brandPrimary
                .withAlpha(0x14);
    return Container(
      padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
      constraints: BoxConstraints(maxHeight: 322, minHeight: 120),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: brnCrossAxisCount,
        //水平子Widget之间间距
        crossAxisSpacing: 6.0,
        //垂直子Widget之间间距
        mainAxisSpacing: 12.0,
        //宽高比
        childAspectRatio: brnChildAspectRatio,
        //GridView内边距
        padding:
            EdgeInsets.only(top: 20.0, left: 0.0, right: 0.0, bottom: 20.0),
        primary: true,
        children: this._sourceTags.map((choice) {
          bool selected = choice.isSelect;
          Color titleColor = selected ? selectedTagTitleColor : tagTitleColor;
          EdgeInsets edgeInsets = this.tagPickerConfig.chipPadding ??
              EdgeInsets.only(top: 9.0, left: 10.0, right: 10, bottom: 11.0);
          return ChoiceChip(
            selected: selected,
            padding: edgeInsets,
            pressElevation: 0,
            backgroundColor: tagBackgroundColor,
            selectedColor: selectedTagBackgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)),
            label: Container(
              width: width,
              child: Text(
                onTagValueGetter(choice),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                strutStyle: StrutStyle(forceStrutHeight: true, height: 1),
                style: TextStyle(
                    height: 1,
                    color: titleColor,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: this.tagPickerConfig.tagTitleFontSize),
              ),
            ),
            onSelected: (bool value) {
              if (_selectedTags.length >= this.maxSelectItemCount &&
                  this.maxSelectItemCount > 0 &&
                  value == true) {
                if (this.onMaxSelectClick != null) {
                  // ignore: unnecessary_statements
                  this.onMaxSelectClick!();
                }
                return;
              }
              _clickTag(value, choice);
              onUpdate!();
            },
          );
        }).toList(),
      ),
    );
  }

  ///流式布局
  Widget _buildWrapViewWidget(BuildContext context, VoidCallback? onUpdate) {
    Color selectedTagTitleColor = this.tagPickerConfig.selectedTagTitleColor ??
        BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary;
    Color tagTitleColor = this.tagPickerConfig.tagTitleColor ??
        BrnThemeConfigurator.instance
            .getConfig()
            .commonConfig
            .colorTextImportant;
    Color tagBackgroundColor =
        this.tagPickerConfig.tagBackgroudColor ?? Color(0xffF8F8F8);
    Color selectedTagBackgroundColor =
        this.tagPickerConfig.selectedTagBackgroudColor ??
            BrnThemeConfigurator.instance
                .getConfig()
                .commonConfig
                .brandPrimary
                .withAlpha(0x14);

    return Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Wrap(
          spacing: 15.0,
          children: this._sourceTags.map((choice) {
            bool selected = choice.isSelect;
            Color titleColor = selected ? selectedTagTitleColor : tagTitleColor;

            EdgeInsets edgeInsets = this.tagPickerConfig.chipPadding ??
                EdgeInsets.only(top: 9.0, left: 10.0, right: 10, bottom: 11.0);
            return ChoiceChip(
              selected: selected,
              padding: edgeInsets,
              pressElevation: 0,
              backgroundColor: tagBackgroundColor,
              selectedColor: selectedTagBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              label: Text(
                onTagValueGetter(choice),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                strutStyle: StrutStyle(forceStrutHeight: true, height: 1),
                style: TextStyle(
                    height: 1,
                    color: titleColor,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: this.tagPickerConfig.tagTitleFontSize),
              ),
              onSelected: (bool value) {
                if (_selectedTags.length > this.maxSelectItemCount &&
                    this.maxSelectItemCount > 0 &&
                    value == true) {
                  if (this.onMaxSelectClick != null) {
                    // ignore: unnecessary_statements
                    this.onMaxSelectClick!();
                  }
                  return;
                }
                _clickTag(value, choice);
                onUpdate!();
              },
            );
          }).toList(),
        ));
  }

  void _dataSetup() {
    List<BrnTagItemBean> tagItems = [];
    List<BrnTagItemBean> tagSelectItems = [];
    for (BrnTagItemBean item in this.tagPickerConfig.tagItemSource) {
      tagItems.add(item);
      //选中的按钮
      if (item.isSelect == true) {
        tagSelectItems.add(item);
      }
    }
    this._sourceTags = tagItems;

    // 默认选中tags
    this._selectedTags = tagSelectItems;
  }

  ///每一个item的点击事件
  void _clickTag(bool selected, BrnTagItemBean tagName) {
    if (selected) {
      tagName.isSelect = true;
      this._selectedTags.add(tagName);
    } else {
      tagName.isSelect = false;
      this._selectedTags.remove(tagName);
    }

    ///点击tag
    if (this.onItemClick != null) {
      this.onItemClick!(tagName, selected);
    }
  }
}
