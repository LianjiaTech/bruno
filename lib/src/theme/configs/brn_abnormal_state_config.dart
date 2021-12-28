import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_default_config_utils.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// 描述: 空页面配置类
class BrnAbnormalStateConfig extends BrnBaseConfig {
  BrnAbnormalStateConfig({
    BrnTextStyle? titleTextStyle,
    BrnTextStyle? contentTextStyle,
    BrnTextStyle? operateTextStyle,
    double? btnRadius,
    BrnTextStyle? singleTextStyle,
    BrnTextStyle? doubleTextStyle,
    double? singleMinWidth,
    double? doubleMinWidth,
    String configId = GLOBAL_CONFIG_ID,
  })  : _titleTextStyle = titleTextStyle,
        _contentTextStyle = contentTextStyle,
        _operateTextStyle = operateTextStyle,
        _btnRadius = btnRadius,
        _singleTextStyle = singleTextStyle,
        _doubleTextStyle = doubleTextStyle,
        _singleMinWidth = singleMinWidth,
        _doubleMinWidth = doubleMinWidth,
        super(configId: configId);

  /// 文案区域标题
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _titleTextStyle;

  /// 文案区域内容
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextHint],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _contentTextStyle;

  /// 操作区域文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _operateTextStyle;

  /// 圆角
  /// default value is [BrnCommonConfig.radiusSm]
  double? _btnRadius;

  /// 单按钮文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBaseInverse],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? _singleTextStyle;

  /// 双按钮文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? _doubleTextStyle;

  /// 单按钮的按钮最小宽度
  /// 默认值为 160
  double? _singleMinWidth;

  /// 多按钮的按钮最小宽度
  /// 默认值为 120
  double? _doubleMinWidth;

  BrnTextStyle get titleTextStyle =>
      _titleTextStyle ??
      BrnDefaultConfigUtils.defaultAbnormalStateConfig.titleTextStyle;

  BrnTextStyle get contentTextStyle =>
      _contentTextStyle ??
      BrnDefaultConfigUtils.defaultAbnormalStateConfig.contentTextStyle;

  BrnTextStyle get operateTextStyle =>
      _operateTextStyle ??
      BrnDefaultConfigUtils.defaultAbnormalStateConfig.operateTextStyle;

  double get btnRadius =>
      _btnRadius ?? BrnDefaultConfigUtils.defaultAbnormalStateConfig.btnRadius;

  BrnTextStyle get singleTextStyle =>
      _singleTextStyle ??
      BrnDefaultConfigUtils.defaultAbnormalStateConfig.singleTextStyle;

  BrnTextStyle get doubleTextStyle =>
      _doubleTextStyle ??
      BrnDefaultConfigUtils.defaultAbnormalStateConfig.doubleTextStyle;

  double get singleMinWidth =>
      _singleMinWidth ??
      BrnDefaultConfigUtils.defaultAbnormalStateConfig.singleMinWidth;

  double get doubleMinWidth =>
      _doubleMinWidth ??
      BrnDefaultConfigUtils.defaultAbnormalStateConfig.doubleMinWidth;

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
    BrnAbnormalStateConfig abnormalStateConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .abnormalStateConfig;

    _titleTextStyle = abnormalStateConfig.titleTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_titleTextStyle),
    );
    _contentTextStyle = abnormalStateConfig.contentTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextHint,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_contentTextStyle),
    );
    _operateTextStyle = abnormalStateConfig.operateTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_operateTextStyle),
    );
    _singleTextStyle = abnormalStateConfig.singleTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBaseInverse,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_singleTextStyle),
    );
    _doubleTextStyle = abnormalStateConfig.doubleTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_doubleTextStyle),
    );
    _btnRadius ??= abnormalStateConfig._btnRadius;
    _singleMinWidth ??= abnormalStateConfig._singleMinWidth;
    _doubleMinWidth ??= abnormalStateConfig._doubleMinWidth;
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
      titleTextStyle: titleTextStyle ?? _titleTextStyle,
      contentTextStyle: contentTextStyle ?? _contentTextStyle,
      operateTextStyle: operateTextStyle ?? _operateTextStyle,
      btnRadius: btnRadius ?? _btnRadius,
      singleTextStyle: singleTextStyle ?? _singleTextStyle,
      doubleTextStyle: doubleTextStyle ?? _doubleTextStyle,
      singleMinWidth: singleMinWidth ?? _singleMinWidth,
      doubleMinWidth: doubleMinWidth ?? _doubleMinWidth,
    );
  }

  BrnAbnormalStateConfig merge(BrnAbnormalStateConfig? other) {
    if (other == null) return this;
    return copyWith(
      titleTextStyle: titleTextStyle.merge(other._titleTextStyle),
      contentTextStyle: contentTextStyle.merge(other._contentTextStyle),
      operateTextStyle: operateTextStyle.merge(other._operateTextStyle),
      btnRadius: other._btnRadius,
      singleTextStyle: singleTextStyle.merge(other._singleTextStyle),
      doubleTextStyle: doubleTextStyle.merge(other._doubleTextStyle),
      singleMinWidth: other._singleMinWidth,
      doubleMinWidth: other._doubleMinWidth,
    );
  }
}
