import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// 描述: 空页面配置类
class BrnAbnormalStateConfig extends BrnBaseConfig {
  /// 文案区域标题
  ///  TextStyle(fontWeight: FontWeight.w600,color: [BrnCommonConfig.colorTextBase], fontSize: [BrnCommonConfig.fontSizeSubHead])
  BrnTextStyle titleTextStyle;

  /// 文案区域内容
  /// TextStyle(color: [BrnCommonConfig.colorTextHint], fontSize: [BrnCommonConfig.fontSizeBase])
  BrnTextStyle contentTextStyle;

  /// 操作区域文本样式
  /// TextStyle(color: [BrnCommonConfig.brandPrimary], fontSize: [BrnCommonConfig.fontSizeBase])
  BrnTextStyle operateTextStyle;

  /// 圆角
  /// default value is [BrnCommonConfig.radiusSm]
  double btnRadius;

  /// 单按钮文本样式
  /// default value is TextStyle(color: [BrnCommonConfig.colorTextBaseInverse], fontSize: [BrnCommonConfig.fontSizeSubHead]
  BrnTextStyle singleBrnTextStyle;

  /// 双按钮文本样式
  /// default value is TextStyle(color: [BrnCommonConfig.brandPrimary], fontSize: [BrnCommonConfig.fontSizeSubHead])
  BrnTextStyle doubleBrnTextStyle;

  /// 单按钮的按钮最小宽度
  /// default value is 160
  double singleMinWidth;

  /// 多按钮的按钮最小宽度
  /// default value is 120
  double doubleMinWidth;

  BrnAbnormalStateConfig(
      {this.titleTextStyle,
      this.contentTextStyle,
      this.operateTextStyle,
      this.btnRadius,
      this.doubleBrnTextStyle,
      this.singleBrnTextStyle,
      this.singleMinWidth,
      this.doubleMinWidth,
      String configId = BrnThemeConfigurator.GLOBAL_CONFIG_ID})
      : super(configId: configId);

  @override
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    /// 用户全局组件配置
    BrnAbnormalStateConfig abnormalStateConfig =
        BrnThemeConfigurator.instance.getConfig(configId: configId).abnormalStateConfig;

    this.singleBrnTextStyle = abnormalStateConfig.singleBrnTextStyle.merge(BrnTextStyle(
            color: commonConfig.colorTextBaseInverse, fontSize: commonConfig.fontSizeSubHead)
        .merge(this.singleBrnTextStyle));

    this.titleTextStyle = abnormalStateConfig.titleTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.titleTextStyle));

    this.contentTextStyle = abnormalStateConfig.contentTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextHint, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.contentTextStyle));

    this.operateTextStyle = abnormalStateConfig.operateTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeBase)
            .merge(this.operateTextStyle));

    this.doubleBrnTextStyle = abnormalStateConfig.doubleBrnTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.doubleBrnTextStyle));

    this.btnRadius ??= abnormalStateConfig.btnRadius;

    this.singleMinWidth ??= abnormalStateConfig.singleMinWidth;

    this.doubleMinWidth ??= abnormalStateConfig.doubleMinWidth;
  }

  BrnAbnormalStateConfig copyWith({
    BrnTextStyle titleTextStyle,
    BrnTextStyle contentTextStyle,
    BrnTextStyle operateTextStyle,
    double btnRadius,
    BrnTextStyle singleBrnTextStyle,
    BrnTextStyle doubleBrnTextStyle,
    double singleMinWidth,
    double doubleMinWidth,
  }) {
    return BrnAbnormalStateConfig(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      operateTextStyle: operateTextStyle ?? this.operateTextStyle,
      btnRadius: btnRadius ?? this.btnRadius,
      doubleBrnTextStyle: doubleBrnTextStyle ?? this.doubleBrnTextStyle,
      singleBrnTextStyle: singleBrnTextStyle ?? this.singleBrnTextStyle,
      singleMinWidth: singleMinWidth ?? this.singleMinWidth,
      doubleMinWidth: doubleMinWidth ?? this.doubleMinWidth,
    );
  }

  BrnAbnormalStateConfig merge(BrnAbnormalStateConfig other) {
    if (other == null) return this;
    return copyWith(
      titleTextStyle: titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
      contentTextStyle: contentTextStyle?.merge(other.contentTextStyle) ?? other.contentTextStyle,
      operateTextStyle: operateTextStyle?.merge(other.operateTextStyle) ?? other.operateTextStyle,
      btnRadius: other.btnRadius,
      doubleBrnTextStyle:
          doubleBrnTextStyle?.merge(other.doubleBrnTextStyle) ?? other.doubleBrnTextStyle,
      singleBrnTextStyle:
          singleBrnTextStyle?.merge(other.singleBrnTextStyle) ?? other.singleBrnTextStyle,
      singleMinWidth: other.singleMinWidth,
      doubleMinWidth: other.doubleMinWidth,
    );
  }
}
