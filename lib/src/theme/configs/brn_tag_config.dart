import 'dart:ui';

import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// 标签配置类
class BrnTagConfig extends BrnBaseConfig {
  /// tag文本样式
  /// default TextStyle(fontSize: [BrnCommonConfig.fontSizeCaption],color: [BrnCommonConfig.colorTextBase])
  BrnTextStyle tagTextStyle;

  /// tag选中文本样式
  /// default TextStyle(fontWeight: FontWeight.w600,fontSize: [BrnCommonConfig.fontSizeCaption],color: [BrnCommonConfig.brandPrimary])
  BrnTextStyle selectTagTextStyle;

  /// 标签背景色
  /// default [BrnCommonConfig.fillBody]
  Color tagBackgroundColor;

  /// 选中背景色
  /// default [BrnCommonConfig.brandPrimary]
  Color selectedTagBackgroundColor;

  /// 标签圆角
  /// default value is [BrnCommonConfig.radiusXs]
  double tagRadius;

  /// 标签高度，跟 fixWidthMode 无关
  /// default value is 34
  double tagHeight;

  /// 标签宽度，且仅在组件设置了固定宽度（fixWidthMode 为 true）时才生效
  /// default value is 75
  double tagWidth;

  /// 标签最小宽度
  /// default value is 75
  double tagMinWidth;

  BrnTagConfig(
      {this.tagTextStyle,
      this.selectTagTextStyle,
      this.tagRadius,
      this.tagBackgroundColor,
      this.selectedTagBackgroundColor,
      this.tagHeight,
      this.tagWidth,
      this.tagMinWidth,
      String configId = BrnThemeConfigurator.GLOBAL_CONFIG_ID})
      : super(configId: configId);

  @override
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    /// 用户全局组件配置
    BrnTagConfig tagConfig = BrnThemeConfigurator.instance.getConfig(configId: configId).tagConfig;

    this.tagHeight ??= tagConfig.tagHeight;

    this.tagWidth ??= tagConfig.tagWidth;
    this.tagMinWidth ??= tagConfig.tagMinWidth;

    this.tagRadius ??= commonConfig.radiusXs;

    this.tagBackgroundColor ??= commonConfig.fillBody;

    this.selectedTagBackgroundColor ??= commonConfig.brandPrimary;

    this.tagTextStyle = tagConfig.tagTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeCaption)
            .merge(this.tagTextStyle));

    this.selectTagTextStyle = tagConfig.selectTagTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeCaption)
            .merge(this.selectTagTextStyle));
  }

  BrnTagConfig copyWith(
      {BrnTextStyle textStyle,
      BrnTextStyle selectTextStyle,
      double radius,
      Color backgroundColor,
      Color selectedBackgroundColor,
      double height,
      double width,
      double tagMinWidth}) {
    return BrnTagConfig(
        tagTextStyle: textStyle ?? this.tagTextStyle,
        selectTagTextStyle: selectTextStyle ?? this.selectTagTextStyle,
        tagRadius: radius ?? this.tagRadius,
        tagBackgroundColor: backgroundColor ?? this.tagBackgroundColor,
        selectedTagBackgroundColor: selectedBackgroundColor ?? this.selectedTagBackgroundColor,
        tagHeight: height ?? this.tagHeight,
        tagWidth: width ?? this.tagWidth,
        tagMinWidth: tagMinWidth ?? this.tagMinWidth);
  }

  BrnTagConfig merge(BrnTagConfig other) {
    return copyWith(
        textStyle: this.tagTextStyle?.merge(other.tagTextStyle) ?? other.tagTextStyle,
        selectTextStyle:
            this.selectTagTextStyle?.merge(other.selectTagTextStyle) ?? other.selectTagTextStyle,
        radius: other.tagRadius,
        backgroundColor: other.tagBackgroundColor,
        selectedBackgroundColor: other.selectedTagBackgroundColor,
        height: other.tagHeight,
        width: other.tagWidth,
        tagMinWidth: other.tagMinWidth);
  }
}
