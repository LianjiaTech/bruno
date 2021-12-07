import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

///  描述: Dialog 弹框主配置类

class BrnDialogConfig extends BrnBaseConfig {
  /// Dialog 宽度
  /// default 300
  double dialogWidth;

  /// Dialog 四周圆角
  /// default 8.0  use  [BrnCommonConfig.radiusLg]
  double radius;

  /// Dialog icon 距离顶部的边距 仅有顶部间距
  /// default EdgeInsets.only(top: [BrnCommonConfig.vSpacingXxl])
  EdgeInsets iconPadding;

  /// title 当顶部  有  icon时四周间距,无底部间距
  /// default EdgeInsets.only(top: 12, left: [BrnCommonConfig.hSpacingXxl], right: [BrnCommonConfig.hSpacingXxl])
  EdgeInsets titlePaddingSm;

  /// title 当顶部  无  icon时四周间距,无底部间距
  /// default EdgeInsets.only(top: 28, left: [BrnCommonConfig.hSpacingXxl], right: [BrnCommonConfig.hSpacingXxl])
  EdgeInsets titlePaddingLg;

  /// title 标题样式
  /// default BrnTextStyle(fontWeight: FontWeight.w600, fontSize: [ BrnCommonConfig.fontSizeHead], color: [BrnCommonConfig.colorTextBase])
  BrnTextStyle titleTextStyle;

  /// 标题的文字对齐
  /// default TextAlign.center
  TextAlign titleTextAlign;

  /// content 当顶部  有  title或者icon时四周间距，无底部间距
  /// default EdgeInsets.only(top: 8, lecontentPaddingSmft: [BrnCommonConfig.hSpacingXl], right: [BrnCommonConfig.hSpacingXl])
  EdgeInsets contentPaddingSm;

  /// content 当顶部  无  title或者icon时四周间距，无底部间距
  /// default EdgeInsets.only(top: 28, left: [BrnCommonConfig.hSpacingXl], right: [BrnCommonConfig.hSpacingXl])
  EdgeInsets contentPaddingLg;

  /// message 内容样式
  /// default BrnTextStyle(fontSize: [BrnCommonConfig.fontSizeBase], color: [BrnCommonConfig.colorTextImportant])
  BrnTextStyle contentTextStyle;

  /// 内容文字的对齐
  /// default TextAlign.center
  TextAlign contentTextAlign;

  /// warning 当顶部 有 title/icon/content时四周边距，无底部间距
  /// default EdgeInsets.only(top: 6, left: [BrnCommonConfig.hSpacingXl], right: [BrnCommonConfig.hSpacingXl])
  EdgeInsets warningPaddingSm;

  /// warning 当顶部 无 title/icon/content时四周边距，无底部间距
  /// default EdgeInsets.only(top: 28, left: [BrnCommonConfig.hSpacingXl], right: [BrnCommonConfig.hSpacingXl])
  EdgeInsets warningPaddingLg;

  /// 警告样式
  /// default BrnTextStyle(fontSize: [BrnCommonConfig.fontSizeBase], color: [BrnCommonConfig.brandError])
  BrnTextStyle warningTextStyle;

  /// 警示文案文字的对齐
  /// default TextAlign.center
  TextAlign warningTextAlign;

  /// action 顶部 divider 的上方边距
  /// default EdgeInsets.only(top: 28)
  EdgeInsets dividerPadding;

  /// 主色调按钮样式
  /// default BrnTextStyle(color: [BrnCommonConfig.brandPrimary], fontWeight: FontWeight.w600, fontSize: [BrnCommonConfig.fontSizeSubHead])
  BrnTextStyle mainActionTextStyle;

  /// 主色调按钮的背景
  /// default [BrnCommonConfig.fillBase]
  Color mainActionBackgroundColor;

  /// 其他按钮的样式(超2个时按钮样式)
  /// BrnTextStyle(color: [BrnCommonConfig.colorTextBase], fontWeight: FontWeight.w600,fontSize: [BrnCommonConfig.fontSizeSubHead])
  BrnTextStyle assistActionsTextStyle;

  /// 其他按钮的背景
  /// default [BrnCommonConfig.fillBase]
  Color assistActionsBackgroundColor;

  /// 底部按钮高度
  /// default 44.0
  double bottomHeight;

  /// Dialog背景
  /// default [BrnCommonConfig.fillBase]
  Color backgroundColor;

  BrnDialogConfig(
      {this.dialogWidth,
      this.radius,
      this.iconPadding,
      this.titlePaddingSm,
      this.titlePaddingLg,
      this.titleTextStyle,
      this.titleTextAlign,
      this.contentPaddingSm,
      this.contentPaddingLg,
      this.contentTextStyle,
      this.contentTextAlign,
      this.warningPaddingSm,
      this.warningPaddingLg,
      this.warningTextStyle,
      this.warningTextAlign,
      this.dividerPadding,
      this.mainActionTextStyle,
      this.assistActionsTextStyle,
      this.mainActionBackgroundColor,
      this.assistActionsBackgroundColor,
      this.bottomHeight,
      this.backgroundColor,
      String configId = BrnThemeConfigurator.GLOBAL_CONFIG_ID})
      : super(configId: configId);

  /// 按优先级，打平 【Bruno 内置配置】 < 【用户全局的默认配置】 < 【用户特殊配置】 < 【临时组件配置】
  ///
  /// 举例：
  /// ① 尝试获取最近的配置 [topRadius] 若配不为 null，直接使用该配置.
  /// ② [topRadius] 若为 null，尝试使用 全局配置中的配置 dialogConfig.
  /// ③ 如果全局配置中的配置同样为 null 则根据 [configId] 取出全局配置。
  /// ④ 如果没有配置 [configId] 的全局配置，则使用 Bruno 默认的配置
  @override
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    /// 用户全局组件配置
    BrnDialogConfig dialogConfig =
        BrnThemeConfigurator.instance.getConfig(configId: configId).dialogConfig;

    this.dialogWidth ??= dialogConfig?.dialogWidth;

    this.radius ??= commonConfig.radiusLg;

    if (this.titlePaddingSm == null) {
      this.titlePaddingSm = EdgeInsets.only(
          left: commonConfig.hSpacingXxl,
          right: commonConfig.hSpacingXxl,
          top: dialogConfig.titlePaddingSm.top,
          bottom: dialogConfig.titlePaddingSm.bottom);
    }

    if (this.titlePaddingLg == null) {
      this.titlePaddingLg = EdgeInsets.only(
          left: commonConfig.hSpacingXxl,
          right: commonConfig.hSpacingXxl,
          top: dialogConfig.titlePaddingLg.top,
          bottom: dialogConfig.titlePaddingLg.bottom);
    }

    if (this.iconPadding == null) {
      this.iconPadding = EdgeInsets.only(
          left: dialogConfig.iconPadding.left,
          top: commonConfig.vSpacingXxl,
          right: dialogConfig.iconPadding.right,
          bottom: dialogConfig.iconPadding.bottom);
    }

    this.titleTextStyle = dialogConfig.titleTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeHead)
            .merge(this.titleTextStyle));

    this.contentTextStyle = dialogConfig.contentTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextImportant, fontSize: commonConfig.fontSizeBase)
            .merge(this.contentTextStyle));

    this.warningTextStyle = dialogConfig.warningTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandError, fontSize: commonConfig.fontSizeBase)
            .merge(this.warningTextStyle));

    this.mainActionTextStyle = dialogConfig.mainActionTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.mainActionTextStyle));

    this.assistActionsTextStyle = dialogConfig.assistActionsTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.assistActionsTextStyle));

    if (this.contentPaddingSm == null) {
      this.contentPaddingSm = EdgeInsets.only(
          left: commonConfig.hSpacingXl,
          right: commonConfig.hSpacingXl,
          top: dialogConfig.contentPaddingSm.top,
          bottom: dialogConfig.contentPaddingSm.bottom);
    }

    if (this.contentPaddingLg == null) {
      this.contentPaddingLg = EdgeInsets.only(
          left: commonConfig.hSpacingXl,
          right: commonConfig.hSpacingXl,
          top: dialogConfig.contentPaddingLg.top,
          bottom: dialogConfig.contentPaddingLg.bottom);
    }

    if (this.warningPaddingSm == null) {
      this.warningPaddingSm = EdgeInsets.only(
          left: commonConfig.hSpacingXl,
          right: commonConfig.hSpacingXl,
          top: dialogConfig.warningPaddingSm.top,
          bottom: dialogConfig.warningPaddingSm.bottom);
    }

    if (this.warningPaddingLg == null) {
      this.warningPaddingLg = EdgeInsets.only(
          left: commonConfig.hSpacingXl,
          right: commonConfig.hSpacingXl,
          top: dialogConfig.warningPaddingLg.top,
          bottom: dialogConfig.warningPaddingLg.bottom);
    }

    this.titleTextAlign ??= dialogConfig?.titleTextAlign;

    this.contentTextAlign ??= dialogConfig?.contentTextAlign;

    this.warningTextAlign ??= dialogConfig?.warningTextAlign;

    this.mainActionBackgroundColor ??= commonConfig.fillBase;

    this.assistActionsBackgroundColor ??= commonConfig.fillBase;

    this.bottomHeight ??= dialogConfig?.bottomHeight;

    this.dividerPadding ??= dialogConfig?.dividerPadding;

    this.backgroundColor ??= commonConfig.fillBase;
  }

  BrnDialogConfig copyWith(
      {double dialogWidth,
      double radius,
      EdgeInsets iconPadding,
      EdgeInsets titlePaddingSm,
      EdgeInsets titlePaddingLg,
      BrnTextStyle titleTextStyle,
      TextAlign titleTextAlign,
      EdgeInsets contentPaddingSm,
      EdgeInsets contentPaddingLg,
      BrnTextStyle contentTextStyle,
      TextAlign contentTextAlign,
      EdgeInsets warningPaddingSm,
      EdgeInsets warningPaddingLg,
      BrnTextStyle warningTextStyle,
      TextAlign warningTextAlign,
      EdgeInsets dividerPadding,
      BrnTextStyle mainActionTextStyle,
      BrnTextStyle assistActionsTextStyle,
      Color mainActionBackgroundColor,
      Color assistActionsBackgroundColor,
      double bottomHeight,
      Color backgroundColor}) {
    return BrnDialogConfig(
        dialogWidth: dialogWidth ?? this.dialogWidth,
        radius: radius ?? this.radius,
        iconPadding: iconPadding ?? this.iconPadding,
        titlePaddingSm: titlePaddingSm ?? this.titlePaddingSm,
        titlePaddingLg: titlePaddingLg ?? this.titlePaddingLg,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        titleTextAlign: titleTextAlign ?? this.titleTextAlign,
        contentPaddingSm: contentPaddingSm ?? this.contentPaddingSm,
        contentPaddingLg: contentPaddingLg ?? this.contentPaddingLg,
        contentTextStyle: contentTextStyle ?? this.contentTextStyle,
        contentTextAlign: contentTextAlign ?? this.contentTextAlign,
        warningPaddingSm: warningPaddingSm ?? this.warningPaddingSm,
        warningPaddingLg: warningPaddingLg ?? this.warningPaddingLg,
        warningTextStyle: warningTextStyle ?? this.warningTextStyle,
        warningTextAlign: warningTextAlign ?? this.warningTextAlign,
        dividerPadding: dividerPadding ?? this.dividerPadding,
        mainActionTextStyle: mainActionTextStyle ?? this.mainActionTextStyle,
        assistActionsTextStyle: assistActionsTextStyle ?? this.assistActionsTextStyle,
        mainActionBackgroundColor: mainActionBackgroundColor ?? this.mainActionBackgroundColor,
        assistActionsBackgroundColor:
            assistActionsBackgroundColor ?? this.assistActionsBackgroundColor,
        bottomHeight: bottomHeight ?? this.bottomHeight,
        backgroundColor: backgroundColor ?? this.backgroundColor);
  }

  BrnDialogConfig merge(BrnDialogConfig other) {
    if (other == null) return this;
    return copyWith(
        dialogWidth: other.dialogWidth,
        radius: other.radius,
        iconPadding: other.iconPadding,
        titlePaddingSm: other.titlePaddingSm,
        titlePaddingLg: other.titlePaddingLg,
        titleTextStyle: titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
        titleTextAlign: other.titleTextAlign,
        contentPaddingSm: other.contentPaddingSm,
        contentPaddingLg: other.contentPaddingLg,
        contentTextStyle: contentTextStyle?.merge(other.contentTextStyle) ?? other.contentTextStyle,
        contentTextAlign: other.contentTextAlign,
        warningPaddingSm: other.warningPaddingSm,
        warningPaddingLg: other.warningPaddingLg,
        warningTextStyle: warningTextStyle?.merge(other.warningTextStyle) ?? other.warningTextStyle,
        warningTextAlign: other.warningTextAlign,
        dividerPadding: other.dividerPadding,
        mainActionTextStyle:
            mainActionTextStyle?.merge(other.mainActionTextStyle) ?? other.mainActionTextStyle,
        assistActionsTextStyle: assistActionsTextStyle?.merge(other.assistActionsTextStyle) ??
            other.assistActionsTextStyle,
        mainActionBackgroundColor: other.mainActionBackgroundColor,
        assistActionsBackgroundColor: other.assistActionsBackgroundColor,
        bottomHeight: other.bottomHeight,
        backgroundColor: other.backgroundColor);
  }
}
