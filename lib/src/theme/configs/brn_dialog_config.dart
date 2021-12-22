import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// 描述: Dialog 弹框主配置类
class BrnDialogConfig extends BrnBaseConfig {
  BrnDialogConfig({
    this.dialogWidth,
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
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// Dialog 宽度
  /// 默认为 300
  double? dialogWidth;

  /// Dialog 四周圆角
  /// 默认为 [BrnCommonConfig.radiusLg]
  double? radius;

  /// Dialog icon 距离顶部的边距
  ///
  /// EdgeInsets.only(top: [BrnCommonConfig.vSpacingXxl])
  EdgeInsets? iconPadding;

  /// title 在顶部有 icon 时的边距
  ///
  /// EdgeInsets.only(
  ///   top: 12,
  ///   left: [BrnCommonConfig.hSpacingXxl],
  ///   right: [BrnCommonConfig.hSpacingXxl],
  /// )
  EdgeInsets? titlePaddingSm;

  /// title 当顶部无 icon 时的边距
  ///
  /// EdgeInsets.only(
  ///   top: 28,
  ///   left: [BrnCommonConfig.hSpacingXxl],
  ///   right: [BrnCommonConfig.hSpacingXxl],
  /// )
  EdgeInsets? titlePaddingLg;

  /// title 标题样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? titleTextStyle;

  /// 标题的文字对齐
  /// 默认为 [TextAlign.center]
  TextAlign? titleTextAlign;

  /// content 当顶部有 title 或者 icon 时的边距
  ///
  /// EdgeInsets.only(
  ///   top: 8,
  ///   left: [BrnCommonConfig.hSpacingXl],
  ///   right: [BrnCommonConfig.hSpacingXl],
  /// )
  EdgeInsets? contentPaddingSm;

  /// content 当顶部无 title 或者 icon 时的边距
  ///
  /// EdgeInsets.only(
  ///   top: 28,
  ///   left: [BrnCommonConfig.hSpacingXl],
  ///   right: [BrnCommonConfig.hSpacingXl],
  /// )
  EdgeInsets? contentPaddingLg;

  /// message 内容样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextImportant],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? contentTextStyle;

  /// 内容文字的对齐
  /// 默认为 [TextAlign.center]
  TextAlign? contentTextAlign;

  /// warning 当顶部有 title/icon/content 时的边距
  ///
  /// EdgeInsets.only(
  ///   top: 6,
  ///   left: [BrnCommonConfig.hSpacingXl],
  ///   right: [BrnCommonConfig.hSpacingXl],
  /// )
  EdgeInsets? warningPaddingSm;

  /// warning 当顶部无 title/icon/content 时的边距
  ///
  /// EdgeInsets.only(
  ///   top: 28,
  ///   left: [BrnCommonConfig.hSpacingXl],
  ///   right: [BrnCommonConfig.hSpacingXl],
  /// )
  EdgeInsets? warningPaddingLg;

  /// 警告样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandError],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? warningTextStyle;

  /// 警示文案文字的对齐
  /// 默认为 [TextAlign.center]
  TextAlign? warningTextAlign;

  /// action 顶部 divider 的上方边距
  ///
  /// EdgeInsets.only(top: 28)
  EdgeInsets? dividerPadding;

  /// 主色调按钮样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? mainActionTextStyle;

  /// 主色调按钮的背景
  /// 默认为 [BrnCommonConfig.fillBase]
  Color? mainActionBackgroundColor;

  /// 其他按钮的样式(超2个时按钮样式)
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? assistActionsTextStyle;

  /// 其他按钮的背景
  /// 默认为 [BrnCommonConfig.fillBase]
  Color? assistActionsBackgroundColor;

  /// 底部按钮高度
  /// 默认为 44.0
  double? bottomHeight;

  /// Dialog背景
  /// 默认为 [BrnCommonConfig.fillBase]
  Color? backgroundColor;

  /// 按优先级，打平 【Bruno 内置配置】 < 【用户全局的默认配置】 < 【用户特殊配置】 < 【临时组件配置】
  ///
  /// 举例：
  /// ① 尝试获取最近的配置 [topRadius] 若配不为 null，直接使用该配置.
  /// ② [topRadius] 若为 null，尝试使用 全局配置中的配置 dialogConfig.
  /// ③ 如果全局配置中的配置同样为 null 则根据 [configId] 取出全局配置。
  /// ④ 如果没有配置 [configId] 的全局配置，则使用 Bruno 默认的配置
  @override
  void initThemeConfig(
    String configId, {
    BrnCommonConfig? currentLevelCommonConfig,
  }) {
    super.initThemeConfig(
      configId,
      currentLevelCommonConfig: currentLevelCommonConfig,
    );

    /// 用户全局组件配置
    BrnDialogConfig? dialogConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .dialogConfig;

    dialogWidth ??= dialogConfig?.dialogWidth;
    radius ??= commonConfig.radiusLg;
    titlePaddingSm ??= EdgeInsets.only(
      left: commonConfig.hSpacingXxl ?? 0,
      right: commonConfig.hSpacingXxl ?? 0,
      top: dialogConfig?.titlePaddingSm?.top ?? 0,
      bottom: dialogConfig?.titlePaddingSm?.bottom ?? 0,
    );
    titlePaddingLg ??= EdgeInsets.only(
      left: commonConfig.hSpacingXxl ?? 0,
      right: commonConfig.hSpacingXxl ?? 0,
      top: dialogConfig?.titlePaddingLg?.top ?? 0,
      bottom: dialogConfig?.titlePaddingLg?.bottom ?? 0,
    );
    iconPadding ??= EdgeInsets.only(
      left: dialogConfig?.iconPadding?.left ?? 0,
      top: commonConfig.vSpacingXxl ?? 0,
      right: dialogConfig?.iconPadding?.right ?? 0,
      bottom: dialogConfig?.iconPadding?.bottom ?? 0,
    );
    titleTextStyle = dialogConfig?.titleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeHead,
      ).merge(titleTextStyle),
    );
    contentTextStyle = dialogConfig?.contentTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextImportant,
        fontSize: commonConfig.fontSizeBase,
      ).merge(contentTextStyle),
    );
    warningTextStyle = dialogConfig?.warningTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandError,
        fontSize: commonConfig.fontSizeBase,
      ).merge(warningTextStyle),
    );
    mainActionTextStyle = dialogConfig?.mainActionTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(mainActionTextStyle),
    );
    assistActionsTextStyle = dialogConfig?.assistActionsTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(assistActionsTextStyle),
    );
    contentPaddingSm ??= EdgeInsets.only(
      left: commonConfig.hSpacingXl ?? 0,
      right: commonConfig.hSpacingXl ?? 0,
      top: dialogConfig?.contentPaddingSm?.top ?? 0,
      bottom: dialogConfig?.contentPaddingSm?.bottom ?? 0,
    );
    contentPaddingSm ??= EdgeInsets.only(
      left: commonConfig.hSpacingXl ?? 0,
      right: commonConfig.hSpacingXl ?? 0,
      top: dialogConfig?.contentPaddingLg?.top ?? 0,
      bottom: dialogConfig?.contentPaddingLg?.bottom ?? 0,
    );
    warningPaddingSm ??= EdgeInsets.only(
      left: commonConfig.hSpacingXl ?? 0,
      right: commonConfig.hSpacingXl ?? 0,
      top: dialogConfig?.warningPaddingSm?.top ?? 0,
      bottom: dialogConfig?.warningPaddingSm?.bottom ?? 0,
    );
    warningPaddingLg ??= EdgeInsets.only(
      left: commonConfig.hSpacingXl ?? 0,
      right: commonConfig.hSpacingXl ?? 0,
      top: dialogConfig?.warningPaddingLg?.top ?? 0,
      bottom: dialogConfig?.warningPaddingLg?.bottom ?? 0,
    );
    titleTextAlign ??= dialogConfig?.titleTextAlign;
    contentTextAlign ??= dialogConfig?.contentTextAlign;
    warningTextAlign ??= dialogConfig?.warningTextAlign;
    mainActionBackgroundColor ??= commonConfig.fillBase;
    assistActionsBackgroundColor ??= commonConfig.fillBase;
    bottomHeight ??= dialogConfig?.bottomHeight;
    dividerPadding ??= dialogConfig?.dividerPadding;
    backgroundColor ??= commonConfig.fillBase;
  }

  BrnDialogConfig copyWith({
    double? dialogWidth,
    double? radius,
    EdgeInsets? iconPadding,
    EdgeInsets? titlePaddingSm,
    EdgeInsets? titlePaddingLg,
    BrnTextStyle? titleTextStyle,
    TextAlign? titleTextAlign,
    EdgeInsets? contentPaddingSm,
    EdgeInsets? contentPaddingLg,
    BrnTextStyle? contentTextStyle,
    TextAlign? contentTextAlign,
    EdgeInsets? warningPaddingSm,
    EdgeInsets? warningPaddingLg,
    BrnTextStyle? warningTextStyle,
    TextAlign? warningTextAlign,
    EdgeInsets? dividerPadding,
    BrnTextStyle? mainActionTextStyle,
    BrnTextStyle? assistActionsTextStyle,
    Color? mainActionBackgroundColor,
    Color? assistActionsBackgroundColor,
    double? bottomHeight,
    Color? backgroundColor,
  }) {
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
      assistActionsTextStyle:
          assistActionsTextStyle ?? this.assistActionsTextStyle,
      mainActionBackgroundColor:
          mainActionBackgroundColor ?? this.mainActionBackgroundColor,
      assistActionsBackgroundColor:
          assistActionsBackgroundColor ?? this.assistActionsBackgroundColor,
      bottomHeight: bottomHeight ?? this.bottomHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  BrnDialogConfig merge(BrnDialogConfig? other) {
    if (other == null) return this;
    return copyWith(
      dialogWidth: other.dialogWidth,
      radius: other.radius,
      iconPadding: other.iconPadding,
      titlePaddingSm: other.titlePaddingSm,
      titlePaddingLg: other.titlePaddingLg,
      titleTextStyle:
          titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
      titleTextAlign: other.titleTextAlign,
      contentPaddingSm: other.contentPaddingSm,
      contentPaddingLg: other.contentPaddingLg,
      contentTextStyle: contentTextStyle?.merge(other.contentTextStyle) ??
          other.contentTextStyle,
      contentTextAlign: other.contentTextAlign,
      warningPaddingSm: other.warningPaddingSm,
      warningPaddingLg: other.warningPaddingLg,
      warningTextStyle: warningTextStyle?.merge(other.warningTextStyle) ??
          other.warningTextStyle,
      warningTextAlign: other.warningTextAlign,
      dividerPadding: other.dividerPadding,
      mainActionTextStyle:
          mainActionTextStyle?.merge(other.mainActionTextStyle) ??
              other.mainActionTextStyle,
      assistActionsTextStyle:
          assistActionsTextStyle?.merge(other.assistActionsTextStyle) ??
              other.assistActionsTextStyle,
      mainActionBackgroundColor: other.mainActionBackgroundColor,
      assistActionsBackgroundColor: other.assistActionsBackgroundColor,
      bottomHeight: other.bottomHeight,
      backgroundColor: other.backgroundColor,
    );
  }
}
