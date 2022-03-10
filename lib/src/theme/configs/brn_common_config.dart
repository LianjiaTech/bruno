import 'dart:core';

import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_default_config_utils.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/painting.dart';

/// 描述: 全局配置
/// 配置属性：色值、字体大小、间距、圆角
class BrnCommonConfig extends BrnBaseConfig {
  BrnCommonConfig({
    Color? brandPrimary,
    Color? brandPrimaryTap,
    Color? brandSuccess,
    Color? brandWarning,
    Color? brandError,
    Color? brandImportant,
    Color? brandImportantValue,
    Color? brandAuxiliary,
    Color? colorTextBase,
    Color? colorTextImportant,
    Color? colorTextBaseInverse,
    Color? colorTextSecondary,
    Color? colorTextDisabled,
    Color? colorTextHint,
    Color? colorLink,
    Color? fillBase,
    Color? fillBody,
    Color? fillMask,
    Color? borderColorBase,
    Color? dividerColorBase,
    double? fontSizeBebas,
    double? fontSizeHeadLg,
    double? fontSizeBase,
    double? fontSizeHead,
    double? fontSizeSubHead,
    double? fontSizeCaption,
    double? fontSizeCaptionSm,
    double? radiusXs,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
    double? borderWidthSm,
    double? borderWidthMd,
    double? borderWidthLg,
    double? hSpacingXs,
    double? hSpacingSm,
    double? hSpacingMd,
    double? hSpacingLg,
    double? hSpacingXl,
    double? hSpacingXxl,
    double? vSpacingXs,
    double? vSpacingSm,
    double? vSpacingMd,
    double? vSpacingLg,
    double? vSpacingXl,
    double? vSpacingXxl,
    double? iconSizeXxs,
    double? iconSizeXs,
    double? iconSizeSm,
    double? iconSizeMd,
    double? iconSizeLg,
    String configId = GLOBAL_CONFIG_ID,
  })  : _brandPrimary = brandPrimary,
        _brandPrimaryTap = brandPrimaryTap,
        _brandSuccess = brandSuccess,
        _brandWarning = brandWarning,
        _brandError = brandError,
        _brandImportant = brandImportant,
        _brandImportantValue = brandImportantValue,
        _brandAuxiliary = brandAuxiliary,
        _colorTextBase = colorTextBase,
        _colorTextImportant = colorTextImportant,
        _colorTextBaseInverse = colorTextBaseInverse,
        _colorTextSecondary = colorTextSecondary,
        _colorTextDisabled = colorTextDisabled,
        _colorTextHint = colorTextHint,
        _colorLink = colorLink,
        _fillBase = fillBase,
        _fillBody = fillBody,
        _fillMask = fillMask,
        _borderColorBase = borderColorBase,
        _dividerColorBase = dividerColorBase,
        _fontSizeBebas = fontSizeBebas,
        _fontSizeHeadLg = fontSizeHeadLg,
        _fontSizeBase = fontSizeBase,
        _fontSizeHead = fontSizeHead,
        _fontSizeSubHead = fontSizeSubHead,
        _fontSizeCaption = fontSizeCaption,
        _fontSizeCaptionSm = fontSizeCaptionSm,
        _radiusXs = radiusXs,
        _radiusSm = radiusSm,
        _radiusMd = radiusMd,
        _radiusLg = radiusLg,
        _borderWidthSm = borderWidthSm,
        _borderWidthMd = borderWidthMd,
        _borderWidthLg = borderWidthLg,
        _hSpacingXs = hSpacingXs,
        _hSpacingSm = hSpacingSm,
        _hSpacingMd = hSpacingMd,
        _hSpacingLg = hSpacingLg,
        _hSpacingXl = hSpacingXl,
        _hSpacingXxl = hSpacingXxl,
        _vSpacingXs = vSpacingXs,
        _vSpacingSm = vSpacingSm,
        _vSpacingMd = vSpacingMd,
        _vSpacingLg = vSpacingLg,
        _vSpacingXl = vSpacingXl,
        _vSpacingXxl = vSpacingXxl,
        _iconSizeXxs = iconSizeXxs,
        _iconSizeXs = iconSizeXs,
        _iconSizeSm = iconSizeSm,
        _iconSizeMd = iconSizeMd,
        _iconSizeLg = iconSizeLg,
        super(configId: configId);

  BrnCommonConfig.autoFlatConfig({
    Color? brandPrimary,
    Color? brandPrimaryTap,
    Color? brandSuccess,
    Color? brandWarning,
    Color? brandError,
    Color? brandImportant,
    Color? brandImportantValue,
    Color? brandAuxiliary,
    Color? colorTextBase,
    Color? colorTextImportant,
    Color? colorTextBaseInverse,
    Color? colorTextSecondary,
    Color? colorTextDisabled,
    Color? colorTextHint,
    Color? colorLink,
    Color? fillBase,
    Color? fillBody,
    Color? fillMask,
    Color? borderColorBase,
    Color? dividerColorBase,
    double? fontSizeBebas,
    double? fontSizeHeadLg,
    double? fontSizeBase,
    double? fontSizeHead,
    double? fontSizeSubHead,
    double? fontSizeCaption,
    double? fontSizeCaptionSm,
    double? radiusXs,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
    double? borderWidthSm,
    double? borderWidthMd,
    double? borderWidthLg,
    double? hSpacingXs,
    double? hSpacingSm,
    double? hSpacingMd,
    double? hSpacingLg,
    double? hSpacingXl,
    double? hSpacingXxl,
    double? vSpacingXs,
    double? vSpacingSm,
    double? vSpacingMd,
    double? vSpacingLg,
    double? vSpacingXl,
    double? vSpacingXxl,
    double? iconSizeXxs,
    double? iconSizeXs,
    double? iconSizeSm,
    double? iconSizeMd,
    double? iconSizeLg,
    String configId = GLOBAL_CONFIG_ID,
  })  : _brandPrimary = brandPrimary,
        _brandPrimaryTap = brandPrimaryTap,
        _brandSuccess = brandSuccess,
        _brandWarning = brandWarning,
        _brandError = brandError,
        _brandImportant = brandImportant,
        _brandImportantValue = brandImportantValue,
        _brandAuxiliary = brandAuxiliary,
        _colorTextBase = colorTextBase,
        _colorTextImportant = colorTextImportant,
        _colorTextBaseInverse = colorTextBaseInverse,
        _colorTextSecondary = colorTextSecondary,
        _colorTextDisabled = colorTextDisabled,
        _colorTextHint = colorTextHint,
        _colorLink = colorLink,
        _fillBase = fillBase,
        _fillBody = fillBody,
        _fillMask = fillMask,
        _borderColorBase = borderColorBase,
        _dividerColorBase = dividerColorBase,
        _fontSizeBebas = fontSizeBebas,
        _fontSizeHeadLg = fontSizeHeadLg,
        _fontSizeBase = fontSizeBase,
        _fontSizeHead = fontSizeHead,
        _fontSizeSubHead = fontSizeSubHead,
        _fontSizeCaption = fontSizeCaption,
        _fontSizeCaptionSm = fontSizeCaptionSm,
        _radiusXs = radiusXs,
        _radiusSm = radiusSm,
        _radiusMd = radiusMd,
        _radiusLg = radiusLg,
        _borderWidthSm = borderWidthSm,
        _borderWidthMd = borderWidthMd,
        _borderWidthLg = borderWidthLg,
        _hSpacingXs = hSpacingXs,
        _hSpacingSm = hSpacingSm,
        _hSpacingMd = hSpacingMd,
        _hSpacingLg = hSpacingLg,
        _hSpacingXl = hSpacingXl,
        _hSpacingXxl = hSpacingXxl,
        _vSpacingXs = vSpacingXs,
        _vSpacingSm = vSpacingSm,
        _vSpacingMd = vSpacingMd,
        _vSpacingLg = vSpacingLg,
        _vSpacingXl = vSpacingXl,
        _vSpacingXxl = vSpacingXxl,
        _iconSizeXxs = iconSizeXxs,
        _iconSizeXs = iconSizeXs,
        _iconSizeSm = iconSizeSm,
        _iconSizeMd = iconSizeMd,
        _iconSizeLg = iconSizeLg,
        super(configId: configId, autoFlatConfig: true);

  /// 基本单位
  static const double hd = 1;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// 色彩 /////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

//////////////////////////////////// 品牌色 /////////////////////////////////////

  /// 品牌色
  /// 默认为 Color(0xFF0984F9)
  Color? _brandPrimary;

  /// 主题色按下效果
  /// 默认为 Color(0x190984F9)
  Color? _brandPrimaryTap;

  /// 成功色
  /// 默认为 Color(0xFF00AE66)
  Color? _brandSuccess;

  /// 警告色
  /// 默认为 Color(0xFFFAAD14)
  Color? _brandWarning;

  /// 失败色
  /// 默认为 Color(0xFFFA3F3F)
  Color? _brandError;

  /// 重要-多用于红点色
  /// 默认为 Color(0xFFFA3F3F)
  Color? _brandImportant;

  /// 重要数值色
  /// 默认为 Color(0xFFFF5722)
  Color? _brandImportantValue;

  /// 辅助色
  /// 默认为 Color(0xFF44C2FF)
  Color? _brandAuxiliary;

  /// 文本色相关
  ///
  /// 基础文字纯黑色
  /// 默认为 Color(0xFF222222)
  Color? _colorTextBase;

  /// 基础文字重要色
  /// 默认为 Color(0xFF666666)
  Color? _colorTextImportant;

  /// 基础文字-反色
  /// 默认为 Color(0xFFFFFFFF)
  Color? _colorTextBaseInverse;

  /// 辅助文字色
  /// 默认为 Color(0xFF999999)
  Color? _colorTextSecondary;

  /// 失效或不可更改文字色
  /// 默认为 Color(0xFF999999)
  Color? _colorTextDisabled;

  /// 文本框提示暗文文字色
  /// 默认为 Color(0xFFCCCCCC)
  Color? _colorTextHint;

  /// 跟随主题色[brandPrimary]
  Color? _colorLink;

  /// 背景色相关
  ///
  /// 组件背景色
  /// 默认为 Color(0xFFFFFFFF)
  Color? _fillBase;

  /// 页面背景色
  /// 默认为 Color(0xFFF8F8F8)
  Color? _fillBody;

  /// 遮罩背景
  /// 默认为 Color(0x99000000)
  Color? _fillMask;

  /// 边框色
  /// 默认为 Color(0xFFF0F0F0)
  Color? _borderColorBase;

  /// 分割线色
  /// 默认为 Color(0xFFF0F0F0)
  Color? _dividerColorBase;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// 尺寸 /////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

  /// 文本字号
  ///
  /// 特殊数据展示，Bebas 数字字体，用于强吸引
  /// default value is 28
  double? _fontSizeBebas;

  /// 标题字体
  /// 名称/页面大标题
  /// 默认为 22
  double? _fontSizeHeadLg;

  /// 标题字体
  /// 内容模块标题/一级标题
  /// 默认为 18
  double? _fontSizeHead;

  /// 子标题字体
  /// 标题/录入文字/大按钮文字/二级标题
  /// 默认为  16
  double? _fontSizeSubHead;

  /// 基础字体
  /// 内容副文本/普通说明文字
  /// 默认为 14
  double? _fontSizeBase;

  /// 辅助字体-普通
  /// 默认为 12
  double? _fontSizeCaption;

  ///辅助字体-小
  /// 默认为 11
  double? _fontSizeCaptionSm;

  /// 圆角尺寸
  /// 默认为 2.0
  double? _radiusXs;

  /// 默认为 4.0
  double? _radiusSm;

  /// 默认为 6.0
  double? _radiusMd;

  /// 默认为 8.0
  double? _radiusLg;

  /// 边框尺寸
  ///
  /// 默认为 0.5
  double? _borderWidthSm;

  /// 默认为 1
  double? _borderWidthMd;

  /// 默认为 2
  double? _borderWidthLg;

  /// 水平间距
  /// 默认为 8
  double? _hSpacingXs;

  /// 默认为 12
  double? _hSpacingSm;

  /// 默认为 16
  double? _hSpacingMd;

  /// 默认为 20
  double? _hSpacingLg;

  /// 默认为 24
  double? _hSpacingXl;

  /// 默认为 42
  double? _hSpacingXxl;

  /// 垂直间距
  /// 默认为 4
  double? _vSpacingXs;

  /// 默认为 8
  double? _vSpacingSm;

  /// 默认为 12
  double? _vSpacingMd;

  /// 默认为 14
  double? _vSpacingLg;

  /// 默认为 16
  double? _vSpacingXl;

  /// 默认为 28
  double? _vSpacingXxl;

  /// 图标尺寸
  /// 默认为 8
  double? _iconSizeXxs;

  /// 默认为 12
  double? _iconSizeXs;

  /// 默认为 14
  double? _iconSizeSm;

  /// 默认为 16
  double? _iconSizeMd;

  /// 默认为 32
  double? _iconSizeLg;

  Color get brandPrimary =>
      _brandPrimary ?? BrnDefaultConfigUtils.defaultCommonConfig.brandPrimary;

  Color get brandPrimaryTap =>
      _brandPrimaryTap ??
      BrnDefaultConfigUtils.defaultCommonConfig.brandPrimaryTap;

  Color get brandSuccess =>
      _brandSuccess ?? BrnDefaultConfigUtils.defaultCommonConfig.brandSuccess;

  Color get brandWarning =>
      _brandWarning ?? BrnDefaultConfigUtils.defaultCommonConfig.brandWarning;

  Color get brandError =>
      _brandError ?? BrnDefaultConfigUtils.defaultCommonConfig.brandError;

  Color get brandImportant =>
      _brandImportant ??
      BrnDefaultConfigUtils.defaultCommonConfig.brandImportant;

  Color get brandImportantValue =>
      _brandImportantValue ??
      BrnDefaultConfigUtils.defaultCommonConfig.brandImportantValue;

  Color get brandAuxiliary =>
      _brandAuxiliary ??
      BrnDefaultConfigUtils.defaultCommonConfig.brandAuxiliary;

  Color get colorTextBase =>
      _colorTextBase ?? BrnDefaultConfigUtils.defaultCommonConfig.colorTextBase;

  Color get colorTextImportant =>
      _colorTextImportant ??
      BrnDefaultConfigUtils.defaultCommonConfig.colorTextImportant;

  Color get colorTextBaseInverse =>
      _colorTextBaseInverse ??
      BrnDefaultConfigUtils.defaultCommonConfig.colorTextBaseInverse;

  Color get colorTextSecondary =>
      _colorTextSecondary ??
      BrnDefaultConfigUtils.defaultCommonConfig.colorTextSecondary;

  Color get colorTextDisabled =>
      _colorTextDisabled ??
      BrnDefaultConfigUtils.defaultCommonConfig.colorTextDisabled;

  Color get colorTextHint =>
      _colorTextHint ?? BrnDefaultConfigUtils.defaultCommonConfig.colorTextHint;

  Color get colorLink =>
      _colorLink ?? BrnDefaultConfigUtils.defaultCommonConfig.colorLink;

  Color get fillBase =>
      _fillBase ?? BrnDefaultConfigUtils.defaultCommonConfig.fillBase;

  Color get fillBody =>
      _fillBody ?? BrnDefaultConfigUtils.defaultCommonConfig.fillBody;

  Color get fillMask =>
      _fillMask ?? BrnDefaultConfigUtils.defaultCommonConfig.fillMask;

  Color get borderColorBase =>
      _borderColorBase ??
      BrnDefaultConfigUtils.defaultCommonConfig.borderColorBase;

  Color get dividerColorBase =>
      _dividerColorBase ??
      BrnDefaultConfigUtils.defaultCommonConfig.dividerColorBase;

  double get fontSizeBebas =>
      _fontSizeBebas ?? BrnDefaultConfigUtils.defaultCommonConfig.fontSizeBebas;

  double get fontSizeHeadLg =>
      _fontSizeHeadLg ??
      BrnDefaultConfigUtils.defaultCommonConfig.fontSizeHeadLg;

  double get fontSizeHead =>
      _fontSizeHead ?? BrnDefaultConfigUtils.defaultCommonConfig.fontSizeHead;

  double get fontSizeSubHead =>
      _fontSizeSubHead ??
      BrnDefaultConfigUtils.defaultCommonConfig.fontSizeSubHead;

  double get fontSizeBase =>
      _fontSizeBase ?? BrnDefaultConfigUtils.defaultCommonConfig.fontSizeBase;

  double get fontSizeCaption =>
      _fontSizeCaption ??
      BrnDefaultConfigUtils.defaultCommonConfig.fontSizeCaption;

  double get fontSizeCaptionSm =>
      _fontSizeCaptionSm ??
      BrnDefaultConfigUtils.defaultCommonConfig.fontSizeCaptionSm;

  double get radiusXs =>
      _radiusXs ?? BrnDefaultConfigUtils.defaultCommonConfig.radiusXs;

  double get radiusSm =>
      _radiusSm ?? BrnDefaultConfigUtils.defaultCommonConfig.radiusSm;

  double get radiusMd =>
      _radiusMd ?? BrnDefaultConfigUtils.defaultCommonConfig.radiusMd;

  double get radiusLg =>
      _radiusLg ?? BrnDefaultConfigUtils.defaultCommonConfig.radiusLg;

  double get borderWidthSm =>
      _borderWidthSm ?? BrnDefaultConfigUtils.defaultCommonConfig.borderWidthSm;

  double get borderWidthMd =>
      _borderWidthMd ?? BrnDefaultConfigUtils.defaultCommonConfig.borderWidthMd;

  double get borderWidthLg =>
      _borderWidthLg ?? BrnDefaultConfigUtils.defaultCommonConfig.borderWidthLg;

  double get hSpacingXs =>
      _hSpacingXs ?? BrnDefaultConfigUtils.defaultCommonConfig.hSpacingXs;

  double get hSpacingSm =>
      _hSpacingSm ?? BrnDefaultConfigUtils.defaultCommonConfig.hSpacingSm;

  double get hSpacingMd =>
      _hSpacingMd ?? BrnDefaultConfigUtils.defaultCommonConfig.hSpacingMd;

  double get hSpacingLg =>
      _hSpacingLg ?? BrnDefaultConfigUtils.defaultCommonConfig.hSpacingLg;

  double get hSpacingXl =>
      _hSpacingXl ?? BrnDefaultConfigUtils.defaultCommonConfig.hSpacingXl;

  double get hSpacingXxl =>
      _hSpacingXxl ?? BrnDefaultConfigUtils.defaultCommonConfig.hSpacingXxl;

  double get vSpacingXs =>
      _vSpacingXs ?? BrnDefaultConfigUtils.defaultCommonConfig.vSpacingXs;

  double get vSpacingSm =>
      _vSpacingSm ?? BrnDefaultConfigUtils.defaultCommonConfig.vSpacingSm;

  double get vSpacingMd =>
      _vSpacingMd ?? BrnDefaultConfigUtils.defaultCommonConfig.vSpacingMd;

  double get vSpacingLg =>
      _vSpacingLg ?? BrnDefaultConfigUtils.defaultCommonConfig.vSpacingLg;

  double get vSpacingXl =>
      _vSpacingXl ?? BrnDefaultConfigUtils.defaultCommonConfig.vSpacingXl;

  double get vSpacingXxl =>
      _vSpacingXxl ?? BrnDefaultConfigUtils.defaultCommonConfig.vSpacingXxl;

  double get iconSizeXxs =>
      _iconSizeXxs ?? BrnDefaultConfigUtils.defaultCommonConfig.iconSizeXxs;

  double get iconSizeXs =>
      _iconSizeXs ?? BrnDefaultConfigUtils.defaultCommonConfig.iconSizeXs;

  double get iconSizeSm =>
      _iconSizeSm ?? BrnDefaultConfigUtils.defaultCommonConfig.iconSizeSm;

  double get iconSizeMd =>
      _iconSizeMd ?? BrnDefaultConfigUtils.defaultCommonConfig.iconSizeMd;

  double get iconSizeLg =>
      _iconSizeLg ?? BrnDefaultConfigUtils.defaultCommonConfig.iconSizeLg;

  /// 优先级 [GLOBAL_CONFIG_ID] 获取配置 > [BRUNO_CONFIG_ID] 获取配置
  @override
  void initThemeConfig(
    String configId, {
    BrnCommonConfig? currentLevelCommonConfig,
  }) {
    super.initThemeConfig(
      configId,
      currentLevelCommonConfig: currentLevelCommonConfig,
    );

    /// 获取合适的 完整配置（BrnAllConfig）
    _colorTextBase ??= commonConfig._colorTextBase;
    _colorTextImportant ??= commonConfig._colorTextImportant;
    _colorTextBaseInverse ??= commonConfig._colorTextBaseInverse;
    _colorTextSecondary ??= commonConfig._colorTextSecondary;
    _colorTextHint ??= commonConfig._colorTextHint;
    _colorTextDisabled ??= commonConfig._colorTextDisabled;
    _brandAuxiliary ??= commonConfig._brandAuxiliary;
    _colorLink ??= commonConfig._colorLink;
    _fillBase ??= commonConfig._fillBase;
    _fillBody ??= commonConfig._fillBody;
    _fillMask ??= commonConfig._fillMask;
    _brandPrimary ??= commonConfig._brandPrimary;
    _brandPrimaryTap ??= commonConfig._brandPrimaryTap;
    _brandSuccess ??= commonConfig._brandSuccess;
    _brandWarning ??= commonConfig._brandWarning;
    _brandError ??= commonConfig._brandError;
    _brandImportant ??= commonConfig._brandImportant;
    _brandImportantValue ??= commonConfig._brandImportantValue;
    _borderColorBase ??= commonConfig._borderColorBase;
    _dividerColorBase ??= commonConfig._dividerColorBase;
    _fontSizeBebas ??= commonConfig._fontSizeBebas;
    _fontSizeHeadLg ??= commonConfig._fontSizeHeadLg;
    _fontSizeBase ??= commonConfig._fontSizeBase;
    _fontSizeHead ??= commonConfig._fontSizeHead;
    _fontSizeSubHead ??= commonConfig._fontSizeSubHead;
    _fontSizeCaption ??= commonConfig._fontSizeCaption;
    _fontSizeCaptionSm ??= commonConfig._fontSizeCaptionSm;
    _radiusXs ??= commonConfig._radiusXs;
    _radiusSm ??= commonConfig._radiusSm;
    _radiusMd ??= commonConfig._radiusMd;
    _radiusLg ??= commonConfig._radiusLg;
    _borderWidthSm ??= commonConfig._borderWidthSm;
    _borderWidthMd ??= commonConfig._borderWidthMd;
    _borderWidthLg ??= commonConfig._borderWidthLg;
    _hSpacingXs ??= commonConfig._hSpacingXs;
    _hSpacingSm ??= commonConfig._hSpacingSm;
    _hSpacingMd ??= commonConfig._hSpacingMd;
    _hSpacingLg ??= commonConfig._hSpacingLg;
    _hSpacingXl ??= commonConfig._hSpacingXl;
    _hSpacingXxl ??= commonConfig._hSpacingXxl;
    _vSpacingXs ??= commonConfig._vSpacingXs;
    _vSpacingSm ??= commonConfig._vSpacingSm;
    _vSpacingMd ??= commonConfig._vSpacingMd;
    _vSpacingLg ??= commonConfig._vSpacingLg;
    _vSpacingXl ??= commonConfig._vSpacingXl;
    _vSpacingXxl ??= commonConfig._vSpacingXxl;
    _iconSizeXxs ??= commonConfig._iconSizeXxs;
    _iconSizeXs ??= commonConfig._iconSizeXs;
    _iconSizeSm ??= commonConfig._iconSizeSm;
    _iconSizeMd ??= commonConfig._iconSizeMd;
    _iconSizeLg ??= commonConfig._iconSizeLg;
  }
}
