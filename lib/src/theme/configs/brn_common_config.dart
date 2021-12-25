import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/painting.dart';

/// 描述: 全局配置
/// 配置属性：色值、字体大小、间距、圆角
class BrnCommonConfig extends BrnBaseConfig {
  BrnCommonConfig({
    this.brandPrimary,
    this.brandPrimaryTap,
    this.brandSuccess,
    this.brandWarning,
    this.brandError,
    this.brandImportant,
    this.brandImportantValue,
    this.brandAuxiliary,
    this.colorTextBase,
    this.colorTextImportant,
    this.colorTextBaseInverse,
    this.colorTextSecondary,
    this.colorTextDisabled,
    this.colorTextHint,
    this.colorLink,
    this.fillBase,
    this.fillBody,
    this.fillMask,
    this.borderColorBase,
    this.dividerColorBase,
    this.fontSizeDIN,
    this.fontSizeHeadLg,
    this.fontSizeBase,
    this.fontSizeHead,
    this.fontSizeSubHead,
    this.fontSizeCaption,
    this.fontSizeCaptionSm,
    this.radiusXs,
    this.radiusSm,
    this.radiusMd,
    this.radiusLg,
    this.borderWidthSm,
    this.borderWidthMd,
    this.borderWidthLg,
    this.hSpacingXs,
    this.hSpacingSm,
    this.hSpacingMd,
    this.hSpacingLg,
    this.hSpacingXl,
    this.hSpacingXxl,
    this.vSpacingXs,
    this.vSpacingSm,
    this.vSpacingMd,
    this.vSpacingLg,
    this.vSpacingXl,
    this.vSpacingXxl,
    this.iconSizeXxs,
    this.iconSizeXs,
    this.iconSizeSm,
    this.iconSizeMd,
    this.iconSizeLg,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  BrnCommonConfig.autoFlatConfig({
    this.brandPrimary,
    this.brandPrimaryTap,
    this.brandSuccess,
    this.brandWarning,
    this.brandError,
    this.brandImportant,
    this.brandImportantValue,
    this.brandAuxiliary,
    this.colorTextBase,
    this.colorTextImportant,
    this.colorTextBaseInverse,
    this.colorTextSecondary,
    this.colorTextDisabled,
    this.colorTextHint,
    this.colorLink,
    this.fillBase,
    this.fillBody,
    this.fillMask,
    this.borderColorBase,
    this.dividerColorBase,
    this.fontSizeDIN,
    this.fontSizeHeadLg,
    this.fontSizeBase,
    this.fontSizeHead,
    this.fontSizeSubHead,
    this.fontSizeCaption,
    this.fontSizeCaptionSm,
    this.radiusXs,
    this.radiusSm,
    this.radiusMd,
    this.radiusLg,
    this.borderWidthSm,
    this.borderWidthMd,
    this.borderWidthLg,
    this.hSpacingXs,
    this.hSpacingSm,
    this.hSpacingMd,
    this.hSpacingLg,
    this.hSpacingXl,
    this.hSpacingXxl,
    this.vSpacingXs,
    this.vSpacingSm,
    this.vSpacingMd,
    this.vSpacingLg,
    this.vSpacingXl,
    this.vSpacingXxl,
    this.iconSizeXxs,
    this.iconSizeXs,
    this.iconSizeSm,
    this.iconSizeMd,
    this.iconSizeLg,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId, autoFlatConfig: true);

  /// 基本单位
  static const double hd = 1;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// 色彩 /////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

//////////////////////////////////// 品牌色 /////////////////////////////////////

  /// 品牌色
  /// 默认为 Color(0xFF0984F9)
  Color? brandPrimary;

  /// 主题色按下效果
  /// 默认为 Color(0x190984F9)
  Color? brandPrimaryTap;

  /// 成功色
  /// 默认为 Color(0xFF00AE66)
  Color? brandSuccess;

  /// 警告色
  /// 默认为 Color(0xFFFAAD14)
  Color? brandWarning;

  /// 失败色
  /// 默认为 Color(0xFFFA3F3F)
  Color? brandError;

  /// 重要-多用于红点色
  /// 默认为 Color(0xFFFA3F3F)
  Color? brandImportant;

  /// 重要数值色
  /// 默认为 Color(0xFFFF5722)
  Color? brandImportantValue;

  /// 辅助色
  /// 默认为 Color(0xFF44C2FF)
  Color? brandAuxiliary;

  /// 文本色相关
  ///
  /// 基础文字纯黑色
  /// 默认为 Color(0xFF222222)
  Color? colorTextBase;

  /// 基础文字重要色
  /// 默认为 Color(0xFF666666)
  Color? colorTextImportant;

  /// 基础文字-反色
  /// 默认为 Color(0xFFFFFFFF)
  Color? colorTextBaseInverse;

  /// 辅助文字色
  /// 默认为 Color(0xFF999999)
  Color? colorTextSecondary;

  /// 失效或不可更改文字色
  /// 默认为 Color(0xFF999999)
  Color? colorTextDisabled;

  /// 文本框提示暗文文字色
  /// 默认为 Color(0xFFCCCCCC)
  Color? colorTextHint;

  /// 跟随主题色[brandPrimary]
  Color? colorLink;

  /// 背景色相关
  ///
  /// 组件背景色
  /// 默认为 Color(0xFFFFFFFF)
  Color? fillBase;

  /// 页面背景色
  /// 默认为 Color(0xFFF8F8F8)
  Color? fillBody;

  /// 遮罩背景
  /// 默认为 Color(0x99000000)
  Color? fillMask;

  /// 边框色
  /// 默认为 Color(0xFFF0F0F0)
  Color? borderColorBase;

  /// 分割线色
  /// 默认为 Color(0xFFF0F0F0)
  Color? dividerColorBase;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// 尺寸 /////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

  /// 文本字号
  ///
  /// 特殊数据展示，DIN Condensed数字字体，用于强吸引
  /// 默认为 28
  double? fontSizeDIN;

  /// 标题字体
  /// 名称/页面大标题
  /// 默认为 22
  double? fontSizeHeadLg;

  /// 标题字体
  /// 内容模块标题/一级标题
  /// 默认为 18
  double? fontSizeHead;

  /// 子标题字体
  /// 标题/录入文字/大按钮文字/二级标题
  /// 默认为  16
  double? fontSizeSubHead;

  /// 基础字体
  /// 内容副文本/普通说明文字
  /// 默认为 14
  double? fontSizeBase;

  /// 辅助字体-普通
  /// 默认为 12
  double? fontSizeCaption;

  ///辅助字体-小
  /// 默认为 11
  double? fontSizeCaptionSm;

  /// 圆角尺寸
  /// 默认为 2.0
  double? radiusXs;

  /// 默认为 4.0
  double? radiusSm;

  /// 默认为 6.0
  double? radiusMd;

  /// 默认为 8.0
  double? radiusLg;

  /// 边框尺寸
  ///
  /// 默认为 0.5
  double? borderWidthSm;

  /// 默认为 1
  double? borderWidthMd;

  /// 默认为 2
  double? borderWidthLg;

  /// 水平间距
  /// 默认为 8
  double? hSpacingXs;

  /// 默认为 12
  double? hSpacingSm;

  /// 默认为 16
  double? hSpacingMd;

  /// 默认为 20
  double? hSpacingLg;

  /// 默认为 24
  double? hSpacingXl;

  /// 默认为 42
  double? hSpacingXxl;

  /// 垂直间距
  /// 默认为 4
  double? vSpacingXs;

  /// 默认为 8
  double? vSpacingSm;

  /// 默认为 12
  double? vSpacingMd;

  /// 默认为 14
  double? vSpacingLg;

  /// 默认为 16
  double? vSpacingXl;

  /// 默认为 28
  double? vSpacingXxl;

  /// 图标尺寸
  /// 默认为 8
  double? iconSizeXxs;

  /// 默认为 12
  double? iconSizeXs;

  /// 默认为 14
  double? iconSizeSm;

  /// 默认为 16
  double? iconSizeMd;

  /// 默认为 32
  double? iconSizeLg;

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
    this.colorTextBase ??= commonConfig!.colorTextBase;
    this.colorTextImportant ??= commonConfig!.colorTextImportant;
    this.colorTextBaseInverse ??= commonConfig!.colorTextBaseInverse;
    this.colorTextSecondary ??= commonConfig!.colorTextSecondary;
    this.colorTextHint ??= commonConfig!.colorTextHint;
    this.colorTextDisabled ??= commonConfig!.colorTextDisabled;
    this.brandAuxiliary ??= commonConfig!.brandAuxiliary;
    this.colorLink ??= commonConfig!.colorLink;
    this.fillBase ??= commonConfig!.fillBase;
    this.fillBody ??= commonConfig!.fillBody;
    this.fillMask ??= commonConfig!.fillMask;
    this.brandPrimary ??= commonConfig!.brandPrimary;
    this.brandPrimaryTap ??= commonConfig!.brandPrimaryTap;
    this.brandSuccess ??= commonConfig!.brandSuccess;
    this.brandWarning ??= commonConfig!.brandWarning;
    this.brandError ??= commonConfig!.brandError;
    this.brandImportant ??= commonConfig!.brandImportant;
    this.brandImportantValue ??= commonConfig!.brandImportantValue;
    this.borderColorBase ??= commonConfig!.borderColorBase;
    this.dividerColorBase ??= commonConfig!.dividerColorBase;
    this.fontSizeDIN ??= commonConfig!.fontSizeDIN;
    this.fontSizeHeadLg ??= commonConfig!.fontSizeHeadLg;
    this.fontSizeBase ??= commonConfig!.fontSizeBase;
    this.fontSizeHead ??= commonConfig!.fontSizeHead;
    this.fontSizeSubHead ??= commonConfig!.fontSizeSubHead;
    this.fontSizeCaption ??= commonConfig!.fontSizeCaption;
    this.fontSizeCaptionSm ??= commonConfig!.fontSizeCaptionSm;
    this.radiusXs ??= commonConfig!.radiusXs;
    this.radiusSm ??= commonConfig!.radiusSm;
    this.radiusMd ??= commonConfig!.radiusMd;
    this.radiusLg ??= commonConfig!.radiusLg;
    this.borderWidthSm ??= commonConfig!.borderWidthSm;
    this.borderWidthMd ??= commonConfig!.borderWidthMd;
    this.borderWidthLg ??= commonConfig!.borderWidthLg;
    this.hSpacingXs ??= commonConfig!.hSpacingXs;
    this.hSpacingSm ??= commonConfig!.hSpacingSm;
    this.hSpacingMd ??= commonConfig!.hSpacingMd;
    this.hSpacingLg ??= commonConfig!.hSpacingLg;
    this.hSpacingXl ??= commonConfig!.hSpacingXl;
    this.hSpacingXxl ??= commonConfig!.hSpacingXxl;
    this.vSpacingXs ??= commonConfig!.vSpacingXs;
    this.vSpacingSm ??= commonConfig!.vSpacingSm;
    this.vSpacingMd ??= commonConfig!.vSpacingMd;
    this.vSpacingLg ??= commonConfig!.vSpacingLg;
    this.vSpacingXl ??= commonConfig!.vSpacingXl;
    this.vSpacingXxl ??= commonConfig!.vSpacingXxl;
    this.iconSizeXxs ??= commonConfig!.iconSizeXxs;
    this.iconSizeXs ??= commonConfig!.iconSizeXs;
    this.iconSizeSm ??= commonConfig!.iconSizeSm;
    this.iconSizeMd ??= commonConfig!.iconSizeMd;
    this.iconSizeLg ??= commonConfig!.iconSizeLg;
  }
}
