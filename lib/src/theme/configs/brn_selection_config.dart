import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/painting.dart';

/// 筛选项 配置类
class BrnSelectionConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultSelectionConfig]
  BrnSelectionConfig({
    this.menuNormalTextStyle,
    this.menuSelectedTextStyle,
    this.tagNormalTextStyle,
    this.tagSelectedTextStyle,
    this.tagRadius,
    this.tagNormalBackgroundColor,
    this.tagSelectedBackgroundColor,
    this.hintTextStyle,
    this.rangeTitleTextStyle,
    this.inputTextStyle,
    this.itemNormalTextStyle,
    this.itemSelectedTextStyle,
    this.itemBoldTextStyle,
    this.deepNormalBgColor,
    this.deepSelectBgColor,
    this.middleNormalBgColor,
    this.middleSelectBgColor,
    this.lightNormalBgColor,
    this.lightSelectBgColor,
    this.resetTextStyle,
    this.titleForMoreTextStyle,
    this.optionTextStyle,
    this.moreTextStyle,
    this.flayNormalTextStyle,
    this.flatSelectedTextStyle,
    this.flatBoldTextStyle,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// menu 正常文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.normal,
  /// )
  BrnTextStyle? menuNormalTextStyle;

  /// menu 选中文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? menuSelectedTextStyle;

  /// tag 正常文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w400,
  /// )
  BrnTextStyle? tagNormalTextStyle;

  /// tag 选中文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? tagSelectedTextStyle;

  /// tag 圆角
  /// 默认为 [BrnCommonConfig.radiusSm]
  double? tagRadius;

  /// tag 正常背景色
  /// 默认为 [BrnCommonConfig.fillBody]
  Color? tagNormalBackgroundColor;

  /// tag 选中背景色
  /// 默认为 [BrnCommonConfig.brandPrimary].withOpacity(0.12)
  Color? tagSelectedBackgroundColor;

  /// 输入选项标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? rangeTitleTextStyle;

  /// 输入提示文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextHint],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? hintTextStyle;

  /// 输入框默认文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? inputTextStyle;

  /// item 正常字体样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? itemNormalTextStyle;

  /// item 选中文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? itemSelectedTextStyle;

  /// item 仅加粗样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? itemBoldTextStyle;

  /// 三级 item 背景色
  /// 默认为 Color(0xFFF0F0F0)
  Color? deepNormalBgColor;

  /// 三级 item 选中背景色
  /// 默认为 Color(0xFFF8F8F8)
  Color? deepSelectBgColor;

  /// 二级 item 背景色
  /// 默认为 Color(0xFFF8F8F8)
  Color? middleNormalBgColor;

  /// 二级 item 选中背景色
  /// 默认为 Colors.white
  Color? middleSelectBgColor;

  /// 一级 item 背景色
  /// 默认为 Colors.white
  Color? lightNormalBgColor;

  /// 一级 item 选中背景色
  /// 默认为 Colors.white
  Color? lightSelectBgColor;

  /// 重置按钮颜色
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextImportant],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption]
  /// )
  BrnTextStyle? resetTextStyle;

  /// 更多筛选-标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? titleForMoreTextStyle;

  /// 选项-显示文本
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? optionTextStyle;

  /// 更多文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  /// )
  BrnTextStyle? moreTextStyle;

  /// 跳转二级页-正常文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.normal,
  /// )
  BrnTextStyle? flayNormalTextStyle;

  /// 跳转二级页-选中文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? flatSelectedTextStyle;

  /// 跳转二级页-加粗文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600
  /// )
  BrnTextStyle? flatBoldTextStyle;

  @override
  void initThemeConfig(
    String configId, {
    BrnCommonConfig? currentLevelCommonConfig,
  }) {
    super.initThemeConfig(
      configId,
      currentLevelCommonConfig: currentLevelCommonConfig,
    );

    /// 用户全局筛选配置
    BrnSelectionConfig? selectionConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .selectionConfig;

    lightSelectBgColor ??= selectionConfig?.lightSelectBgColor;
    lightNormalBgColor ??= selectionConfig?.lightNormalBgColor;
    middleSelectBgColor ??= selectionConfig?.middleSelectBgColor;
    middleNormalBgColor ??= selectionConfig?.middleNormalBgColor;
    deepSelectBgColor ??= selectionConfig?.deepSelectBgColor;
    deepNormalBgColor ??= selectionConfig?.deepNormalBgColor;
    tagSelectedBackgroundColor ??= commonConfig.brandPrimary?.withOpacity(0.12);
    tagNormalBackgroundColor ??= commonConfig.fillBody;
    tagRadius ??= commonConfig.radiusSm;
    flatBoldTextStyle = selectionConfig?.flatBoldTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(flatBoldTextStyle),
    );
    flatSelectedTextStyle = selectionConfig?.flatSelectedTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(flatSelectedTextStyle),
    );
    flayNormalTextStyle = selectionConfig?.flayNormalTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(flayNormalTextStyle),
    );
    moreTextStyle = selectionConfig?.moreTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(moreTextStyle),
    );
    optionTextStyle = selectionConfig?.optionTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(optionTextStyle),
    );
    titleForMoreTextStyle = selectionConfig?.titleForMoreTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(titleForMoreTextStyle),
    );
    resetTextStyle = selectionConfig?.resetTextStyle?.merge(BrnTextStyle(
      color: commonConfig.colorTextImportant,
      fontSize: commonConfig.fontSizeCaption,
    ).merge(resetTextStyle));
    itemBoldTextStyle = selectionConfig?.itemBoldTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(itemBoldTextStyle),
    );
    itemSelectedTextStyle = selectionConfig?.itemSelectedTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(itemSelectedTextStyle),
    );
    itemNormalTextStyle = selectionConfig?.itemNormalTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(itemNormalTextStyle),
    );
    inputTextStyle = selectionConfig?.inputTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(inputTextStyle),
    );
    hintTextStyle = selectionConfig?.hintTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextHint,
        fontSize: commonConfig.fontSizeBase,
      ).merge(hintTextStyle),
    );
    rangeTitleTextStyle = selectionConfig?.rangeTitleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(rangeTitleTextStyle),
    );
    tagSelectedTextStyle = selectionConfig?.tagSelectedTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(tagSelectedTextStyle),
    );
    tagNormalTextStyle = selectionConfig?.tagNormalTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(tagNormalTextStyle),
    );
    menuNormalTextStyle = selectionConfig?.menuNormalTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(menuNormalTextStyle),
    );
    menuSelectedTextStyle = selectionConfig?.menuSelectedTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(menuSelectedTextStyle),
    );
  }

  BrnSelectionConfig copyWith({
    BrnTextStyle? menuNormalTextStyle,
    BrnTextStyle? menuSelectedTextStyle,
    BrnTextStyle? tagTextStyle,
    BrnTextStyle? tagSelectedTextStyle,
    double? tagRadius,
    Color? tagBackgroundColor,
    Color? tagSelectedBackgroundColor,
    BrnTextStyle? hintTextStyle,
    BrnTextStyle? rangeTitleTextStyle,
    BrnTextStyle? inputTextStyle,
    BrnTextStyle? itemNormalTextStyle,
    BrnTextStyle? itemSelectedTextStyle,
    BrnTextStyle? itemBoldTextStyle,
    Color? deepNormalBgColor,
    Color? deepSelectBgColor,
    Color? middleNormalBgColor,
    Color? middleSelectBgColor,
    Color? lightNormalBgColor,
    Color? lightSelectBgColor,
    BrnTextStyle? resetTextStyle,
    BrnTextStyle? titleForMoreTextStyle,
    BrnTextStyle? optionTextStyle,
    BrnTextStyle? moreTextStyle,
    BrnTextStyle? flayNormalTextStyle,
    BrnTextStyle? flatSelectedTextStyle,
    BrnTextStyle? flatBoldTextStyle,
  }) {
    return BrnSelectionConfig(
      menuNormalTextStyle: menuNormalTextStyle ?? this.menuNormalTextStyle,
      menuSelectedTextStyle:
          menuSelectedTextStyle ?? this.menuSelectedTextStyle,
      tagNormalTextStyle: tagTextStyle ?? this.tagNormalTextStyle,
      tagSelectedTextStyle: tagSelectedTextStyle ?? this.tagSelectedTextStyle,
      tagRadius: tagRadius ?? this.tagRadius,
      tagNormalBackgroundColor:
          tagBackgroundColor ?? this.tagNormalBackgroundColor,
      tagSelectedBackgroundColor:
          tagSelectedBackgroundColor ?? this.tagSelectedBackgroundColor,
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      rangeTitleTextStyle: rangeTitleTextStyle ?? this.rangeTitleTextStyle,
      inputTextStyle: inputTextStyle ?? this.inputTextStyle,
      itemNormalTextStyle: itemNormalTextStyle ?? this.itemNormalTextStyle,
      itemSelectedTextStyle:
          itemSelectedTextStyle ?? this.itemSelectedTextStyle,
      itemBoldTextStyle: itemBoldTextStyle ?? this.itemBoldTextStyle,
      deepNormalBgColor: deepNormalBgColor ?? this.deepNormalBgColor,
      deepSelectBgColor: deepSelectBgColor ?? this.deepSelectBgColor,
      middleNormalBgColor: middleNormalBgColor ?? this.middleNormalBgColor,
      middleSelectBgColor: middleSelectBgColor ?? this.middleSelectBgColor,
      lightNormalBgColor: lightNormalBgColor ?? this.lightNormalBgColor,
      lightSelectBgColor: lightSelectBgColor ?? this.lightSelectBgColor,
      resetTextStyle: resetTextStyle ?? this.resetTextStyle,
      titleForMoreTextStyle:
          titleForMoreTextStyle ?? this.titleForMoreTextStyle,
      optionTextStyle: optionTextStyle ?? this.optionTextStyle,
      moreTextStyle: moreTextStyle ?? this.moreTextStyle,
      flayNormalTextStyle: flayNormalTextStyle ?? this.flayNormalTextStyle,
      flatSelectedTextStyle:
          flatSelectedTextStyle ?? this.flatSelectedTextStyle,
      flatBoldTextStyle: flatBoldTextStyle ?? this.flatBoldTextStyle,
    );
  }

  BrnSelectionConfig merge(BrnSelectionConfig other) {
    return copyWith(
      menuNormalTextStyle:
          menuNormalTextStyle?.merge(other.menuNormalTextStyle) ??
              other.menuNormalTextStyle,
      menuSelectedTextStyle:
          menuSelectedTextStyle?.merge(other.menuSelectedTextStyle) ??
              other.menuSelectedTextStyle,
      tagTextStyle: tagNormalTextStyle?.merge(other.tagNormalTextStyle) ??
          other.tagNormalTextStyle,
      tagSelectedTextStyle:
          tagSelectedTextStyle?.merge(other.tagSelectedTextStyle) ??
              other.tagSelectedTextStyle,
      tagRadius: other.tagRadius,
      tagBackgroundColor: other.tagNormalBackgroundColor,
      tagSelectedBackgroundColor: other.tagSelectedBackgroundColor,
      hintTextStyle:
          hintTextStyle?.merge(other.hintTextStyle) ?? other.hintTextStyle,
      rangeTitleTextStyle:
          rangeTitleTextStyle?.merge(other.rangeTitleTextStyle) ??
              other.rangeTitleTextStyle,
      inputTextStyle:
          inputTextStyle?.merge(other.inputTextStyle) ?? other.inputTextStyle,
      itemNormalTextStyle:
          itemNormalTextStyle?.merge(other.itemNormalTextStyle) ??
              other.itemNormalTextStyle,
      itemSelectedTextStyle:
          itemSelectedTextStyle?.merge(other.itemSelectedTextStyle) ??
              other.itemSelectedTextStyle,
      itemBoldTextStyle: itemBoldTextStyle?.merge(other.itemBoldTextStyle) ??
          other.itemBoldTextStyle,
      deepNormalBgColor: other.deepNormalBgColor,
      deepSelectBgColor: other.deepSelectBgColor,
      middleNormalBgColor: other.middleNormalBgColor,
      middleSelectBgColor: other.middleSelectBgColor,
      lightNormalBgColor: other.lightNormalBgColor,
      lightSelectBgColor: other.lightSelectBgColor,
      resetTextStyle:
          resetTextStyle?.merge(other.resetTextStyle) ?? other.resetTextStyle,
      titleForMoreTextStyle:
          titleForMoreTextStyle?.merge(other.titleForMoreTextStyle) ??
              other.titleForMoreTextStyle,
      optionTextStyle: optionTextStyle?.merge(other.optionTextStyle) ??
          other.optionTextStyle,
      moreTextStyle:
          moreTextStyle?.merge(other.moreTextStyle) ?? other.moreTextStyle,
      flayNormalTextStyle:
          flayNormalTextStyle?.merge(other.flayNormalTextStyle) ??
              other.flayNormalTextStyle,
      flatSelectedTextStyle:
          flatSelectedTextStyle?.merge(other.flatSelectedTextStyle) ??
              other.flatSelectedTextStyle,
      flatBoldTextStyle: flatBoldTextStyle?.merge(other.flatBoldTextStyle) ??
          other.flatBoldTextStyle,
    );
  }
}
