import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// 描述: 空页面配置类
class BrnAbnormalStateConfig extends BrnBaseConfig {
  BrnAbnormalStateConfig({
    this.titleTextStyle,
    this.contentTextStyle,
    this.operateTextStyle,
    this.btnRadius,
    this.singleTextStyle,
    this.doubleTextStyle,
    this.singleMinWidth,
    this.doubleMinWidth,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// 文案区域标题
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? titleTextStyle;

  /// 文案区域内容
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextHint],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? contentTextStyle;

  /// 操作区域文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? operateTextStyle;

  /// 圆角
  /// default value is [BrnCommonConfig.radiusSm]
  double? btnRadius;

  /// 单按钮文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBaseInverse],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? singleTextStyle;

  /// 双按钮文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? doubleTextStyle;

  /// 单按钮的按钮最小宽度
  /// 默认值为 160
  double? singleMinWidth;

  /// 多按钮的按钮最小宽度
  /// 默认值为 120
  double? doubleMinWidth;

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
    BrnAbnormalStateConfig? abnormalStateConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .abnormalStateConfig;

    titleTextStyle = abnormalStateConfig?.titleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(titleTextStyle),
    );
    contentTextStyle = abnormalStateConfig?.contentTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextHint,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(contentTextStyle),
    );
    operateTextStyle = abnormalStateConfig?.operateTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(operateTextStyle),
    );
    singleTextStyle = abnormalStateConfig?.singleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBaseInverse,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(singleTextStyle),
    );
    doubleTextStyle = abnormalStateConfig?.doubleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(doubleTextStyle),
    );
    btnRadius ??= abnormalStateConfig?.btnRadius;
    singleMinWidth ??= abnormalStateConfig?.singleMinWidth;
    doubleMinWidth ??= abnormalStateConfig?.doubleMinWidth;
  }

  BrnAbnormalStateConfig copyWith({
    BrnTextStyle? titleTextStyle,
    BrnTextStyle? contentTextStyle,
    BrnTextStyle? operateTextStyle,
    double? btnRadius,
    BrnTextStyle? singleTextStyle,
    BrnTextStyle? doubleTextStyle,
    double? singleMinWidth,
    double? doubleMinWidth,
  }) {
    return BrnAbnormalStateConfig(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      operateTextStyle: operateTextStyle ?? this.operateTextStyle,
      btnRadius: btnRadius ?? this.btnRadius,
      singleTextStyle: singleTextStyle ?? this.singleTextStyle,
      doubleTextStyle: doubleTextStyle ?? this.doubleTextStyle,
      singleMinWidth: singleMinWidth ?? this.singleMinWidth,
      doubleMinWidth: doubleMinWidth ?? this.doubleMinWidth,
    );
  }

  BrnAbnormalStateConfig merge(BrnAbnormalStateConfig? other) {
    if (other == null) return this;
    return copyWith(
      titleTextStyle:
          titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
      contentTextStyle: contentTextStyle?.merge(other.contentTextStyle) ??
          other.contentTextStyle,
      operateTextStyle: operateTextStyle?.merge(other.operateTextStyle) ??
          other.operateTextStyle,
      btnRadius: other.btnRadius,
      singleTextStyle: singleTextStyle?.merge(other.singleTextStyle) ??
          other.singleTextStyle,
      doubleTextStyle: doubleTextStyle?.merge(other.doubleTextStyle) ??
          other.doubleTextStyle,
      singleMinWidth: other.singleMinWidth,
      doubleMinWidth: other.doubleMinWidth,
    );
  }
}
