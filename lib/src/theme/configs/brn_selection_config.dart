import 'dart:ui';

import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// 筛选项 配置类

class BrnSelectionConfig extends BrnBaseConfig {
  /// menu 正常文本样式
  /// TextStyle(fontWeight: FontWeight.normal ,fontSize: [BrnCommonConfig.fontSizeBase],color: [BrnCommonConfig.colorTextBase])
  BrnTextStyle menuNormalTextStyle;

  /// menu 选中文本样式
  /// TextStyle(fontWeight: FontWeight.w600,fontSize: [BrnCommonConfig.fontSizeBase],color: [BrnCommonConfig.brandPrimary])
  BrnTextStyle menuSelectedTextStyle;

  /// tag 正常文本样式
  /// TextStyle(fontWeight: FontWeight.w400,fontSize: [BrnCommonConfig.fontSizeCaption],color: [BrnCommonConfig.colorTextBase])
  BrnTextStyle tagNormalTextStyle;

  /// tag 选中文本样式
  /// TextStyle(fontWeight: FontWeight.w600,fontSize: [BrnCommonConfig.fontSizeCaption],color: [BrnCommonConfig.brandPrimary])
  BrnTextStyle tagSelectedTextStyle;

  /// tag圆角
  /// default value is [BrnCommonConfig.radiusSm]
  double tagRadius;

  /// tag 正常背景色
  /// default value is [BrnCommonConfig.fillBody]
  Color tagNormalBackgroundColor;

  /// tag 选中背景色
  /// [BrnCommonConfig.brandPrimary].withOpacity(0.12)
  Color tagSelectedBackgroundColor;

  /// 输入选项标题文本样式
  /// TextStyle(fontWeight : FontWeight.w600,fontSize: [BrnCommonConfig.fontSizeSubHead], color: [BrnCommonConfig.colorTextBase])
  BrnTextStyle rangeTitleTextStyle;

  /// 输入提示文本样式
  /// TextStyle(fontSize: [BrnCommonConfig.fontSizeBase], color: [BrnCommonConfig.colorTextHint])
  BrnTextStyle hintTextStyle;

  /// 输入框默认文本样式
  /// TextStyle(fontSize: [BrnCommonConfig.fontSizeBase], color: [BrnCommonConfig.colorTextBase])
  BrnTextStyle inputTextStyle;

  /// item 正常字体样式
  /// TextStyle(fontSize: [BrnCommonConfig.fontSizeBase],color: [BrnCommonConfig.colorTextBase])
  BrnTextStyle itemNormalTextStyle;

  /// item 选中文本样式
  /// TextStyle(fontSize: [BrnCommonConfig.fontSizeBase],fontWeight: FontWeight.w600,color: [BrnCommonConfig.brandPrimary])
  BrnTextStyle itemSelectedTextStyle;

  /// item 仅加粗样式
  /// TextStyle(fontSize: [BrnCommonConfig.fontSizeBase],fontWeight: FontWeight.w600,color: [BrnCommonConfig.colorTextBase])
  BrnTextStyle itemBoldTextStyle;

  /// 三级item 背景色
  /// Color(0xFFF0F0F0)
  Color deepNormalBgColor;

  /// 三级item 选中背景色
  /// Color(0xFFF8F8F8)
  Color deepSelectBgColor;

  /// 二级item 背景色
  /// Color(0xFFF8F8F8)
  Color middleNormalBgColor;

  /// 二级item 选中背景色
  /// Colors.white
  Color middleSelectBgColor;

  /// 一级item 背景色
  /// Colors.white
  Color lightNormalBgColor;

  /// 一级item 选中背景色
  /// Colors.white
  Color lightSelectBgColor;

  /// 重置按钮颜色
  /// TextStyle(color: [BrnCommonConfig.colorTextImportant],fontSize: [BrnCommonConfig.fontSizeCaption])
  BrnTextStyle resetTextStyle;

  /// 更多筛选-标题文本样式
  /// TextStyle(color: [BrnCommonConfig.colorTextBase],fontSize: [BrnCommonConfig.fontSizeBase],fontWeight: FontWeight.w600)
  BrnTextStyle titleForMoreTextStyle;

  /// 选项-显示文本
  /// TextStyle(color: [BrnCommonConfig.brandPrimary],fontSize: [BrnCommonConfig.fontSizeBase])
  BrnTextStyle optionTextStyle;

  /// 更多文本样式
  /// TextStyle(color: [BrnCommonConfig.colorTextSecondary],fontSize: [BrnCommonConfig.fontSizeCaption]）
  BrnTextStyle moreTextStyle;

  /// 跳转二级页-正常文本样式
  /// TextStyle(color: [BrnCommonConfig.colorTextBase],fontSize: [BrnCommonConfig.fontSizeSubHead],fontWeight: FontWeight.normal)
  BrnTextStyle flayNormalTextStyle;

  /// 跳转二级页-选中文本样式
  /// TextStyle(color: [BrnCommonConfig.brandPrimary],fontSize: [BrnCommonConfig.fontSizeSubHead],fontWeight: FontWeight.w600)
  BrnTextStyle flatSelectedTextStyle;

  /// 跳转二级页-加粗文本样式
  /// TextStyle(color: [BrnCommonConfig.colorTextBase],fontSize: [BrnCommonConfig.fontSizeSubHead],fontWeight: FontWeight.w600)
  BrnTextStyle flatBoldTextStyle;

  BrnSelectionConfig(
      {this.menuNormalTextStyle,
      this.menuSelectedTextStyle,
      this.tagNormalTextStyle,
      this.tagSelectedTextStyle,
      this.tagRadius,
      this.tagNormalBackgroundColor,
      this.tagSelectedBackgroundColor,
      this.hintTextStyle,
      this.rangeTitleTextStyle,
      this.inputTextStyle,
      this.itemNormalTextStyle,
      this.itemSelectedTextStyle,
      this.itemBoldTextStyle,
      this.deepNormalBgColor,
      this.deepSelectBgColor,
      this.middleNormalBgColor,
      this.middleSelectBgColor,
      this.lightNormalBgColor,
      this.lightSelectBgColor,
      this.resetTextStyle,
      this.titleForMoreTextStyle,
      this.optionTextStyle,
      this.moreTextStyle,
      this.flayNormalTextStyle,
      this.flatSelectedTextStyle,
      this.flatBoldTextStyle,
      String configId = BrnThemeConfigurator.GLOBAL_CONFIG_ID})
      : super(configId: configId);

  @override
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    /// 用户全局筛选配置
    BrnSelectionConfig selectionConfig =
        BrnThemeConfigurator.instance.getConfig(configId: configId).selectionConfig;

    lightSelectBgColor ??= selectionConfig.lightSelectBgColor;

    lightNormalBgColor ??= selectionConfig.lightNormalBgColor;

    middleSelectBgColor ??= selectionConfig.middleSelectBgColor;

    middleNormalBgColor ??= selectionConfig.middleNormalBgColor;

    deepSelectBgColor ??= selectionConfig.deepSelectBgColor;

    deepNormalBgColor ??= selectionConfig.deepNormalBgColor;

    tagSelectedBackgroundColor ??= commonConfig.brandPrimary.withOpacity(0.12);

    tagNormalBackgroundColor ??= commonConfig.fillBody;

    tagRadius ??= commonConfig.radiusSm;

    this.flatBoldTextStyle = selectionConfig.flatBoldTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.flatBoldTextStyle));

    this.flatSelectedTextStyle = selectionConfig.flatSelectedTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.flatSelectedTextStyle));

    this.flayNormalTextStyle = selectionConfig.flayNormalTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.flayNormalTextStyle));

    this.moreTextStyle = selectionConfig.moreTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextSecondary, fontSize: commonConfig.fontSizeCaption)
            .merge(this.moreTextStyle));

    this.optionTextStyle = selectionConfig.optionTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeBase)
            .merge(this.optionTextStyle));

    this.titleForMoreTextStyle = selectionConfig.titleForMoreTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeBase)
            .merge(this.titleForMoreTextStyle));

    this.resetTextStyle = selectionConfig.resetTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextImportant, fontSize: commonConfig.fontSizeCaption)
            .merge(this.resetTextStyle));

    this.itemBoldTextStyle = selectionConfig.itemBoldTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeBase)
            .merge(this.itemBoldTextStyle));

    this.itemSelectedTextStyle = selectionConfig.itemSelectedTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeBase)
            .merge(this.itemSelectedTextStyle));

    this.itemNormalTextStyle = selectionConfig.itemNormalTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeBase)
            .merge(this.itemNormalTextStyle));

    this.inputTextStyle = selectionConfig.inputTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeBase)
            .merge(this.inputTextStyle));

    this.hintTextStyle = selectionConfig.hintTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextHint, fontSize: commonConfig.fontSizeBase)
            .merge(this.hintTextStyle));

    this.rangeTitleTextStyle = selectionConfig.rangeTitleTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.rangeTitleTextStyle));

    this.tagSelectedTextStyle = selectionConfig.tagSelectedTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeCaption)
            .merge(this.tagSelectedTextStyle));

    this.tagNormalTextStyle = selectionConfig.tagNormalTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeCaption)
            .merge(this.tagNormalTextStyle));

    this.menuNormalTextStyle = selectionConfig.menuNormalTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeBase)
            .merge(this.menuNormalTextStyle));

    this.menuSelectedTextStyle = selectionConfig.menuSelectedTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeBase)
            .merge(this.menuSelectedTextStyle));
  }

  BrnSelectionConfig copyWith({
    BrnTextStyle menuNormalTextStyle,
    BrnTextStyle menuSelectedTextStyle,
    BrnTextStyle tagTextStyle,
    BrnTextStyle tagSelectedTextStyle,
    double tagRadius,
    Color tagBackgroundColor,
    Color tagSelectedBackgroundColor,
    BrnTextStyle hintTextStyle,
    BrnTextStyle rangeTitleTextStyle,
    BrnTextStyle inputTextStyle,
    BrnTextStyle itemNormalTextStyle,
    BrnTextStyle itemSelectedTextStyle,
    BrnTextStyle itemBoldTextStyle,
    Color deepNormalBgColor,
    Color deepSelectBgColor,
    Color middleNormalBgColor,
    Color middleSelectBgColor,
    Color lightNormalBgColor,
    Color lightSelectBgColor,
    BrnTextStyle resetTextStyle,
    BrnTextStyle titleForMoreTextStyle,
    BrnTextStyle optionTextStyle,
    BrnTextStyle moreTextStyle,
    BrnTextStyle flayNormalTextStyle,
    BrnTextStyle flatSelectedTextStyle,
    BrnTextStyle flatBoldTextStyle,
  }) {
    return BrnSelectionConfig(
        menuNormalTextStyle: menuNormalTextStyle ?? this.menuNormalTextStyle,
        menuSelectedTextStyle: menuSelectedTextStyle ?? this.menuSelectedTextStyle,
        tagNormalTextStyle: tagTextStyle ?? this.tagNormalTextStyle,
        tagSelectedTextStyle: tagSelectedTextStyle ?? this.tagSelectedTextStyle,
        tagRadius: tagRadius ?? this.tagRadius,
        tagNormalBackgroundColor: tagBackgroundColor ?? this.tagNormalBackgroundColor,
        tagSelectedBackgroundColor: tagSelectedBackgroundColor ?? this.tagSelectedBackgroundColor,
        hintTextStyle: hintTextStyle ?? this.hintTextStyle,
        rangeTitleTextStyle: rangeTitleTextStyle ?? this.rangeTitleTextStyle,
        inputTextStyle: inputTextStyle ?? this.inputTextStyle,
        itemNormalTextStyle: itemNormalTextStyle ?? this.itemNormalTextStyle,
        itemSelectedTextStyle: itemSelectedTextStyle ?? this.itemSelectedTextStyle,
        itemBoldTextStyle: itemBoldTextStyle ?? this.itemBoldTextStyle,
        deepNormalBgColor: deepNormalBgColor ?? this.deepNormalBgColor,
        deepSelectBgColor: deepSelectBgColor ?? this.deepSelectBgColor,
        middleNormalBgColor: middleNormalBgColor ?? this.middleNormalBgColor,
        middleSelectBgColor: middleSelectBgColor ?? this.middleSelectBgColor,
        lightNormalBgColor: lightNormalBgColor ?? this.lightNormalBgColor,
        lightSelectBgColor: lightSelectBgColor ?? this.lightSelectBgColor,
        resetTextStyle: resetTextStyle ?? this.resetTextStyle,
        titleForMoreTextStyle: titleForMoreTextStyle ?? this.titleForMoreTextStyle,
        optionTextStyle: optionTextStyle ?? this.optionTextStyle,
        moreTextStyle: moreTextStyle ?? this.moreTextStyle,
        flayNormalTextStyle: flayNormalTextStyle ?? this.flayNormalTextStyle,
        flatSelectedTextStyle: flatSelectedTextStyle ?? this.flatSelectedTextStyle,
        flatBoldTextStyle: flatBoldTextStyle ?? this.flatBoldTextStyle);
  }

  BrnSelectionConfig merge(BrnSelectionConfig other) {
    return copyWith(
        menuNormalTextStyle:
            this.menuNormalTextStyle?.merge(other.menuNormalTextStyle) ?? other.menuNormalTextStyle,
        menuSelectedTextStyle: this.menuSelectedTextStyle?.merge(other.menuSelectedTextStyle) ??
            other.menuSelectedTextStyle,
        tagTextStyle:
            this.tagNormalTextStyle?.merge(other.tagNormalTextStyle) ?? other.tagNormalTextStyle,
        tagSelectedTextStyle: this.tagSelectedTextStyle?.merge(other.tagSelectedTextStyle) ??
            other.tagSelectedTextStyle,
        tagRadius: other.tagRadius,
        tagBackgroundColor: other.tagNormalBackgroundColor,
        tagSelectedBackgroundColor: other.tagSelectedBackgroundColor,
        hintTextStyle: this.hintTextStyle?.merge(other.hintTextStyle) ?? other.hintTextStyle,
        rangeTitleTextStyle:
            this.rangeTitleTextStyle?.merge(other.rangeTitleTextStyle) ?? other.rangeTitleTextStyle,
        inputTextStyle: this.inputTextStyle?.merge(other.inputTextStyle) ?? other.inputTextStyle,
        itemNormalTextStyle:
            this.itemNormalTextStyle?.merge(other.itemNormalTextStyle) ?? other.itemNormalTextStyle,
        itemSelectedTextStyle: this.itemSelectedTextStyle?.merge(other.itemSelectedTextStyle) ??
            other.itemSelectedTextStyle,
        itemBoldTextStyle:
            this.itemBoldTextStyle?.merge(other.itemBoldTextStyle) ?? other.itemBoldTextStyle,
        deepNormalBgColor: other.deepNormalBgColor,
        deepSelectBgColor: other.deepSelectBgColor,
        middleNormalBgColor: other.middleNormalBgColor,
        middleSelectBgColor: other.middleSelectBgColor,
        lightNormalBgColor: other.lightNormalBgColor,
        lightSelectBgColor: other.lightSelectBgColor,
        resetTextStyle: this.resetTextStyle?.merge(other.resetTextStyle) ?? other.resetTextStyle,
        titleForMoreTextStyle: this.titleForMoreTextStyle?.merge(other.titleForMoreTextStyle) ??
            other.titleForMoreTextStyle,
        optionTextStyle:
            this.optionTextStyle?.merge(other.optionTextStyle) ?? other.optionTextStyle,
        moreTextStyle: this.moreTextStyle?.merge(other.moreTextStyle) ?? other.moreTextStyle,
        flayNormalTextStyle:
            this.flayNormalTextStyle?.merge(other.flayNormalTextStyle) ?? other.flayNormalTextStyle,
        flatSelectedTextStyle: this.flatSelectedTextStyle?.merge(other.flatSelectedTextStyle) ??
            other.flatSelectedTextStyle,
        flatBoldTextStyle:
            this.flatBoldTextStyle?.merge(other.flatBoldTextStyle) ?? other.flatBoldTextStyle);
  }
}
