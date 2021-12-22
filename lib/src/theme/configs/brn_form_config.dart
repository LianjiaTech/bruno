import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// 描述: form 表单项主配置类
class BrnFormItemConfig extends BrnBaseConfig {
  /// 遵循全局配置
  /// 默认为 [BrnDefaultConfigUtils.defaultFormItemConfig]
  BrnFormItemConfig({
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.errorTextStyle,
    this.hintTextStyle,
    this.contentTextStyle,
    this.formPadding,
    this.titlePaddingSm,
    this.titlePaddingLg,
    this.optionsMiddlePadding,
    this.subTitlePadding,
    this.errorPadding,
    this.disableTextStyle,
    this.tipsTextStyle,
    this.headTitleTextStyle,
    this.optionTextStyle,
    this.optionSelectedTextStyle,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  BrnFormItemConfig.generatorFromConfigId(String configId) {
    initThemeConfig(configId);
  }

  /// 左侧标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  /// )
  BrnTextStyle? headTitleTextStyle;

  /// 左侧标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? titleTextStyle;

  /// 左侧辅助文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  /// )
  BrnTextStyle? subTitleTextStyle;

  /// 左侧 Error 文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandError],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  /// )
  BrnTextStyle? errorTextStyle;

  /// 右侧 输入、选择提示文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextHint],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? hintTextStyle;

  /// 右侧 主要内容样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? contentTextStyle;

  /// 表单项 当有星号标识 上下右边距
  ///
  /// EdgeInsets.only(
  ///   left: 0,
  ///   top: [BrnCommonConfig.vSpacingLg],
  ///   right: [BrnCommonConfig.hSpacingLg],
  ///   bottom: [BrnCommonConfig.vSpacingLg],
  /// )
  EdgeInsets? formPadding;

  /// 表单项 当有星号标识 左边距
  ///
  /// EdgeInsets.only(left: 10)
  EdgeInsets? titlePaddingSm;

  /// 表单项 当无星号标识 左右边距
  ///
  /// EdgeInsets.only(left: [BrnCommonConfig.hSpacingLg])
  EdgeInsets? titlePaddingLg;

  /// 选项之间间距 单选 or 多选
  ///
  /// EdgeInsets.only(left: [BrnCommonConfig.hSpacingMd])
  EdgeInsets? optionsMiddlePadding;

  /// 选项普通文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   height: 1.3,
  /// )
  BrnTextStyle? optionTextStyle;

  /// 选项选中文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   height: 1.3,
  /// )
  BrnTextStyle? optionSelectedTextStyle;

  /// 子标题 左上间距
  ///
  /// EdgeInsets.only(
  ///   left: [BrnCommonConfig.hSpacingLg],
  ///   top: [BrnCommonConfig.vSpacingXs],
  /// )
  EdgeInsets? subTitlePadding;

  /// error提示 左上间距
  ///
  /// EdgeInsets.only(
  ///   left: [BrnCommonConfig.hSpacingLg],
  ///   top: [BrnCommonConfig.vSpacingXs],
  /// )
  EdgeInsets? errorPadding;

  /// 不可修改内容展示
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextDisabled],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? disableTextStyle;

  /// 提示文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? tipsTextStyle;

  /// 举例：
  /// ① 尝试获取最近的配置 [topRadius] 若配不为 null，直接使用该配置.
  /// ② [topRadius] 若为 null，尝试使用 全局配置中的配置 BrnFormItemConfig.
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

    /// 用户全局form组件配置
    BrnFormItemConfig? formItemThemeData = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .formItemConfig;

    titlePaddingSm ??= formItemThemeData?.titlePaddingSm;
    titlePaddingLg ??= formItemThemeData?.titlePaddingLg;
    optionSelectedTextStyle = formItemThemeData?.optionSelectedTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(optionSelectedTextStyle),
    );
    optionTextStyle = formItemThemeData?.optionTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(optionTextStyle),
    );
    headTitleTextStyle = formItemThemeData?.headTitleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeHead,
      ).merge(headTitleTextStyle),
    );
    errorPadding ??= EdgeInsets.only(
      left: commonConfig.hSpacingLg ?? 0,
      right: formItemThemeData?.errorPadding?.right ?? 0,
      top: commonConfig.vSpacingXs ?? 0,
      bottom: formItemThemeData?.errorPadding?.bottom ?? 0,
    );
    subTitlePadding ??= EdgeInsets.only(
      left: commonConfig.hSpacingLg ?? 0,
      right: formItemThemeData?.subTitlePadding?.right ?? 0,
      top: commonConfig.vSpacingXs ?? 0,
      bottom: formItemThemeData?.subTitlePadding?.bottom ?? 0,
    );
    formPadding ??= EdgeInsets.only(
      left: formItemThemeData?.formPadding?.left ?? 0,
      right: commonConfig.hSpacingLg ?? 0,
      top: commonConfig.vSpacingLg ?? 0,
      bottom: commonConfig.vSpacingLg ?? 0,
    );
    tipsTextStyle = formItemThemeData?.tipsTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(tipsTextStyle),
    );
    disableTextStyle = formItemThemeData?.disableTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextDisabled,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(disableTextStyle),
    );
    contentTextStyle = formItemThemeData?.contentTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(contentTextStyle),
    );
    hintTextStyle = formItemThemeData?.hintTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextHint,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(hintTextStyle),
    );
    titleTextStyle = formItemThemeData?.titleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(titleTextStyle),
    );
    subTitleTextStyle = formItemThemeData?.subTitleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(subTitleTextStyle),
    );
    errorTextStyle = formItemThemeData?.errorTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandError,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(errorTextStyle),
    );
    optionsMiddlePadding ??= formItemThemeData?.optionsMiddlePadding;
  }

  BrnFormItemConfig copyWith({
    BrnTextStyle? titleTextStyle,
    BrnTextStyle? subTitleTextStyle,
    BrnTextStyle? errorTextStyle,
    BrnTextStyle? hintTextStyle,
    BrnTextStyle? contentTextStyle,
    EdgeInsets? formPadding,
    EdgeInsets? titlePaddingSm,
    EdgeInsets? titlePaddingLg,
    EdgeInsets? optionsMiddlePadding,
    EdgeInsets? subTitlePadding,
    EdgeInsets? errorPadding,
    BrnTextStyle? disableTextStyle,
    BrnTextStyle? tipsTextStyle,
    BrnTextStyle? headTitleTextStyle,
    BrnTextStyle? optionTextStyle,
    BrnTextStyle? optionSelectedTextStyle,
  }) {
    return BrnFormItemConfig(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subTitleTextStyle: subTitleTextStyle ?? this.subTitleTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      formPadding: formPadding ?? this.formPadding,
      titlePaddingSm: titlePaddingSm ?? this.titlePaddingSm,
      titlePaddingLg: titlePaddingLg ?? this.titlePaddingLg,
      optionsMiddlePadding: optionsMiddlePadding ?? this.optionsMiddlePadding,
      subTitlePadding: subTitlePadding ?? this.subTitlePadding,
      errorPadding: errorPadding ?? this.errorPadding,
      disableTextStyle: disableTextStyle ?? this.disableTextStyle,
      tipsTextStyle: tipsTextStyle ?? this.tipsTextStyle,
      headTitleTextStyle: headTitleTextStyle ?? this.headTitleTextStyle,
      optionTextStyle: optionTextStyle ?? this.optionTextStyle,
      optionSelectedTextStyle:
          optionSelectedTextStyle ?? this.optionSelectedTextStyle,
    );
  }

  BrnFormItemConfig merge(BrnFormItemConfig? other) {
    if (other == null) return this;
    return copyWith(
      titleTextStyle:
          titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
      subTitleTextStyle: subTitleTextStyle?.merge(other.subTitleTextStyle) ??
          other.subTitleTextStyle,
      errorTextStyle:
          errorTextStyle?.merge(other.errorTextStyle) ?? other.errorTextStyle,
      hintTextStyle:
          hintTextStyle?.merge(other.hintTextStyle) ?? other.hintTextStyle,
      contentTextStyle: contentTextStyle?.merge(other.contentTextStyle) ??
          other.contentTextStyle,
      formPadding: other.formPadding,
      titlePaddingSm: other.titlePaddingSm,
      titlePaddingLg: other.titlePaddingLg,
      optionsMiddlePadding: other.optionsMiddlePadding,
      subTitlePadding: other.subTitlePadding,
      errorPadding: other.errorPadding,
      disableTextStyle: disableTextStyle?.merge(other.disableTextStyle) ??
          other.disableTextStyle,
      tipsTextStyle:
          tipsTextStyle?.merge(other.tipsTextStyle) ?? other.tipsTextStyle,
      headTitleTextStyle: headTitleTextStyle?.merge(other.headTitleTextStyle) ??
          other.headTitleTextStyle,
      optionTextStyle: optionTextStyle?.merge(other.optionTextStyle) ??
          other.optionTextStyle,
      optionSelectedTextStyle:
          optionSelectedTextStyle?.merge(other.optionSelectedTextStyle) ??
              other.optionSelectedTextStyle,
    );
  }
}
