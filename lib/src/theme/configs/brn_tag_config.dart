import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/painting.dart';

/// 标签配置类
class BrnTagConfig extends BrnBaseConfig {
  BrnTagConfig({
    this.tagTextStyle,
    this.selectTagTextStyle,
    this.tagRadius,
    this.tagBackgroundColor,
    this.selectedTagBackgroundColor,
    this.tagHeight,
    this.tagWidth,
    this.tagMinWidth,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// tag 文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  /// )
  BrnTextStyle? tagTextStyle;

  /// tag选中文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? selectTagTextStyle;

  /// 标签背景色
  /// default [BrnCommonConfig.fillBody]
  Color? tagBackgroundColor;

  /// 选中背景色
  /// default [BrnCommonConfig.brandPrimary]
  Color? selectedTagBackgroundColor;

  /// 标签圆角
  /// 默认为 [BrnCommonConfig.radiusXs]
  double? tagRadius;

  /// 标签高度，跟 fixWidthMode 无关
  /// 默认为 34
  double? tagHeight;

  /// 标签宽度，且仅在组件设置了固定宽度（fixWidthMode 为 true）时才生效
  /// 默认为 75
  double? tagWidth;

  /// 标签最小宽度
  /// 默认为 75
  double? tagMinWidth;

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
    BrnTagConfig? tagConfig =
        BrnThemeConfigurator.instance.getConfig(configId: configId).tagConfig;

    tagHeight ??= tagConfig?.tagHeight;
    tagWidth ??= tagConfig?.tagWidth;
    tagMinWidth ??= tagConfig?.tagMinWidth;
    tagRadius ??= commonConfig.radiusXs;
    tagBackgroundColor ??= commonConfig.fillBody;
    selectedTagBackgroundColor ??= commonConfig.brandPrimary;
    tagTextStyle = tagConfig?.tagTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(tagTextStyle),
    );
    selectTagTextStyle = tagConfig?.selectTagTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(selectTagTextStyle),
    );
  }

  BrnTagConfig copyWith({
    BrnTextStyle? textStyle,
    BrnTextStyle? selectTextStyle,
    double? radius,
    Color? backgroundColor,
    Color? selectedBackgroundColor,
    double? height,
    double? width,
    double? tagMinWidth,
  }) {
    return BrnTagConfig(
      tagTextStyle: textStyle ?? this.tagTextStyle,
      selectTagTextStyle: selectTextStyle ?? this.selectTagTextStyle,
      tagRadius: radius ?? this.tagRadius,
      tagBackgroundColor: backgroundColor ?? this.tagBackgroundColor,
      selectedTagBackgroundColor:
          selectedBackgroundColor ?? this.selectedTagBackgroundColor,
      tagHeight: height ?? this.tagHeight,
      tagWidth: width ?? this.tagWidth,
      tagMinWidth: tagMinWidth ?? this.tagMinWidth,
    );
  }

  BrnTagConfig merge(BrnTagConfig other) {
    return copyWith(
      textStyle: tagTextStyle?.merge(other.tagTextStyle) ?? other.tagTextStyle,
      selectTextStyle: selectTagTextStyle?.merge(other.selectTagTextStyle) ??
          other.selectTagTextStyle,
      radius: other.tagRadius,
      backgroundColor: other.tagBackgroundColor,
      selectedBackgroundColor: other.selectedTagBackgroundColor,
      height: other.tagHeight,
      width: other.tagWidth,
      tagMinWidth: other.tagMinWidth,
    );
  }
}
