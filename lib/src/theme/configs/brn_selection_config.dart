import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_default_config_utils.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/painting.dart';

/// 筛选项 配置类
class BrnSelectionConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultSelectionConfig]
  BrnSelectionConfig({
    BrnTextStyle? menuNormalTextStyle,
    BrnTextStyle? menuSelectedTextStyle,
    BrnTextStyle? tagNormalTextStyle,
    BrnTextStyle? tagSelectedTextStyle,
    double? tagRadius,
    Color? tagNormalBackgroundColor,
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
    BrnTextStyle? flayerNormalTextStyle,
    BrnTextStyle? flayerSelectedTextStyle,
    BrnTextStyle? flayerBoldTextStyle,
    String configId = GLOBAL_CONFIG_ID,
  })  : _menuNormalTextStyle = menuNormalTextStyle,
        _menuSelectedTextStyle = menuSelectedTextStyle,
        _tagNormalTextStyle = tagNormalTextStyle,
        _tagSelectedTextStyle = tagSelectedTextStyle,
        _tagRadius = tagRadius,
        _tagNormalBackgroundColor = tagNormalBackgroundColor,
        _tagSelectedBackgroundColor = tagSelectedBackgroundColor,
        _hintTextStyle = hintTextStyle,
        _rangeTitleTextStyle = rangeTitleTextStyle,
        _inputTextStyle = inputTextStyle,
        _itemNormalTextStyle = itemNormalTextStyle,
        _itemSelectedTextStyle = itemSelectedTextStyle,
        _itemBoldTextStyle = itemBoldTextStyle,
        _deepNormalBgColor = deepNormalBgColor,
        _deepSelectBgColor = deepSelectBgColor,
        _middleNormalBgColor = middleNormalBgColor,
        _middleSelectBgColor = middleSelectBgColor,
        _lightNormalBgColor = lightNormalBgColor,
        _lightSelectBgColor = lightSelectBgColor,
        _resetTextStyle = resetTextStyle,
        _titleForMoreTextStyle = titleForMoreTextStyle,
        _optionTextStyle = optionTextStyle,
        _moreTextStyle = moreTextStyle,
        _flayerNormalTextStyle = flayerNormalTextStyle,
        _flayerSelectedTextStyle = flayerSelectedTextStyle,
        _flayerBoldTextStyle = flayerBoldTextStyle,
        super(configId: configId);

  /// menu 正常文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.normal,
  /// )
  BrnTextStyle? _menuNormalTextStyle;

  /// menu 选中文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _menuSelectedTextStyle;

  /// tag 正常文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w400,
  /// )
  BrnTextStyle? _tagNormalTextStyle;

  /// tag 选中文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _tagSelectedTextStyle;

  /// tag 圆角
  /// 默认为 [BrnCommonConfig.radiusSm]
  double? _tagRadius;

  /// tag 正常背景色
  /// 默认为 [BrnCommonConfig.fillBody]
  Color? _tagNormalBackgroundColor;

  /// tag 选中背景色
  /// 默认为 [BrnCommonConfig.brandPrimary].withOpacity(0.12)
  Color? _tagSelectedBackgroundColor;

  /// 输入选项标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _rangeTitleTextStyle;

  /// 输入提示文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextHint],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _hintTextStyle;

  /// 输入框默认文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _inputTextStyle;

  /// item 正常字体样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _itemNormalTextStyle;

  /// item 选中文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _itemSelectedTextStyle;

  /// item 仅加粗样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _itemBoldTextStyle;

  /// 三级 item 背景色
  /// 默认为 Color(0xFFF0F0F0)
  Color? _deepNormalBgColor;

  /// 三级 item 选中背景色
  /// 默认为 Color(0xFFF8F8F8)
  Color? _deepSelectBgColor;

  /// 二级 item 背景色
  /// 默认为 Color(0xFFF8F8F8)
  Color? _middleNormalBgColor;

  /// 二级 item 选中背景色
  /// 默认为 Colors.white
  Color? _middleSelectBgColor;

  /// 一级 item 背景色
  /// 默认为 Colors.white
  Color? _lightNormalBgColor;

  /// 一级 item 选中背景色
  /// 默认为 Colors.white
  Color? _lightSelectBgColor;

  /// 重置按钮颜色
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextImportant],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption]
  /// )
  BrnTextStyle? _resetTextStyle;

  /// 更多筛选-标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _titleForMoreTextStyle;

  /// 选项-显示文本
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _optionTextStyle;

  /// 更多文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  /// )
  BrnTextStyle? _moreTextStyle;

  /// 跳转二级页-正常文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.normal,
  /// )
  BrnTextStyle? _flayerNormalTextStyle;

  /// 跳转二级页-选中文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _flayerSelectedTextStyle;

  /// 跳转二级页-加粗文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600
  /// )
  BrnTextStyle? _flayerBoldTextStyle;

  BrnTextStyle get menuNormalTextStyle =>
      _menuNormalTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.menuNormalTextStyle;

  BrnTextStyle get menuSelectedTextStyle =>
      _menuSelectedTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.menuSelectedTextStyle;

  BrnTextStyle get tagNormalTextStyle =>
      _tagNormalTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.tagNormalTextStyle;

  BrnTextStyle get tagSelectedTextStyle =>
      _tagSelectedTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.tagSelectedTextStyle;

  double get tagRadius =>
      _tagRadius ?? BrnDefaultConfigUtils.defaultSelectionConfig.tagRadius;

  Color get tagNormalBackgroundColor =>
      _tagNormalBackgroundColor ??
      BrnDefaultConfigUtils.defaultSelectionConfig.tagNormalBackgroundColor;

  Color get tagSelectedBackgroundColor =>
      _tagSelectedBackgroundColor ??
      BrnDefaultConfigUtils.defaultSelectionConfig.tagSelectedBackgroundColor;

  BrnTextStyle get rangeTitleTextStyle =>
      _rangeTitleTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.rangeTitleTextStyle;

  BrnTextStyle get hintTextStyle =>
      _hintTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.hintTextStyle;

  BrnTextStyle get inputTextStyle =>
      _inputTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.inputTextStyle;

  BrnTextStyle get itemNormalTextStyle =>
      _itemNormalTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.itemNormalTextStyle;

  BrnTextStyle get itemSelectedTextStyle =>
      _itemSelectedTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.itemSelectedTextStyle;

  BrnTextStyle get itemBoldTextStyle =>
      _itemBoldTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.itemBoldTextStyle;

  Color get deepNormalBgColor =>
      _deepNormalBgColor ??
      BrnDefaultConfigUtils.defaultSelectionConfig.deepNormalBgColor;

  Color get deepSelectBgColor =>
      _deepSelectBgColor ??
      BrnDefaultConfigUtils.defaultSelectionConfig.deepSelectBgColor;

  Color get middleNormalBgColor =>
      _middleNormalBgColor ??
      BrnDefaultConfigUtils.defaultSelectionConfig.middleNormalBgColor;

  Color get middleSelectBgColor =>
      _middleSelectBgColor ??
      BrnDefaultConfigUtils.defaultSelectionConfig.middleSelectBgColor;

  Color get lightNormalBgColor =>
      _lightNormalBgColor ??
      BrnDefaultConfigUtils.defaultSelectionConfig.lightNormalBgColor;

  Color get lightSelectBgColor =>
      _lightSelectBgColor ??
      BrnDefaultConfigUtils.defaultSelectionConfig.lightSelectBgColor;

  BrnTextStyle get resetTextStyle =>
      _resetTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.resetTextStyle;

  BrnTextStyle get titleForMoreTextStyle =>
      _titleForMoreTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.titleForMoreTextStyle;

  BrnTextStyle get optionTextStyle =>
      _optionTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.optionTextStyle;

  BrnTextStyle get moreTextStyle =>
      _moreTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.moreTextStyle;

  BrnTextStyle get flayerNormalTextStyle =>
      _flayerNormalTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.flayerNormalTextStyle;

  BrnTextStyle get flayerSelectedTextStyle =>
      _flayerSelectedTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.flayerSelectedTextStyle;

  BrnTextStyle get flayerBoldTextStyle =>
      _flayerBoldTextStyle ??
      BrnDefaultConfigUtils.defaultSelectionConfig.flayerBoldTextStyle;

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
    BrnSelectionConfig selectionConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .selectionConfig;

    _lightSelectBgColor ??= selectionConfig._lightSelectBgColor;
    _lightNormalBgColor ??= selectionConfig._lightNormalBgColor;
    _middleSelectBgColor ??= selectionConfig._middleSelectBgColor;
    _middleNormalBgColor ??= selectionConfig._middleNormalBgColor;
    _deepSelectBgColor ??= selectionConfig._deepSelectBgColor;
    _deepNormalBgColor ??= selectionConfig._deepNormalBgColor;
    _tagSelectedBackgroundColor ??= commonConfig.brandPrimary.withOpacity(0.12);
    _tagNormalBackgroundColor ??= commonConfig.fillBody;
    _tagRadius ??= commonConfig.radiusSm;
    _flayerBoldTextStyle = selectionConfig.flayerBoldTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_flayerBoldTextStyle),
    );
    _flayerSelectedTextStyle = selectionConfig.flayerSelectedTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_flayerSelectedTextStyle),
    );
    _flayerNormalTextStyle = selectionConfig.flayerNormalTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_flayerNormalTextStyle),
    );
    _moreTextStyle = selectionConfig.moreTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(_moreTextStyle),
    );
    _optionTextStyle = selectionConfig.optionTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_optionTextStyle),
    );
    _titleForMoreTextStyle = selectionConfig.titleForMoreTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_titleForMoreTextStyle),
    );
    _resetTextStyle = selectionConfig.resetTextStyle.merge(BrnTextStyle(
      color: commonConfig.colorTextImportant,
      fontSize: commonConfig.fontSizeCaption,
    ).merge(_resetTextStyle));
    _itemBoldTextStyle = selectionConfig.itemBoldTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_itemBoldTextStyle),
    );
    _itemSelectedTextStyle = selectionConfig.itemSelectedTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_itemSelectedTextStyle),
    );
    _itemNormalTextStyle = selectionConfig.itemNormalTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_itemNormalTextStyle),
    );
    _inputTextStyle = selectionConfig.inputTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_inputTextStyle),
    );
    _hintTextStyle = selectionConfig.hintTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextHint,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_hintTextStyle),
    );
    _rangeTitleTextStyle = selectionConfig.rangeTitleTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_rangeTitleTextStyle),
    );
    _tagSelectedTextStyle = selectionConfig.tagSelectedTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(_tagSelectedTextStyle),
    );
    _tagNormalTextStyle = selectionConfig.tagNormalTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(_tagNormalTextStyle),
    );
    _menuNormalTextStyle = selectionConfig.menuNormalTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_menuNormalTextStyle),
    );
    _menuSelectedTextStyle = selectionConfig.menuSelectedTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_menuSelectedTextStyle),
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
    BrnTextStyle? flayerNormalTextStyle,
    BrnTextStyle? flayerSelectedTextStyle,
    BrnTextStyle? flayerBoldTextStyle,
  }) {
    return BrnSelectionConfig(
      menuNormalTextStyle: menuNormalTextStyle ?? _menuNormalTextStyle,
      menuSelectedTextStyle: menuSelectedTextStyle ?? _menuSelectedTextStyle,
      tagNormalTextStyle: tagTextStyle ?? _tagNormalTextStyle,
      tagSelectedTextStyle: tagSelectedTextStyle ?? _tagSelectedTextStyle,
      tagRadius: tagRadius ?? _tagRadius,
      tagNormalBackgroundColor: tagBackgroundColor ?? _tagNormalBackgroundColor,
      tagSelectedBackgroundColor:
          tagSelectedBackgroundColor ?? _tagSelectedBackgroundColor,
      hintTextStyle: hintTextStyle ?? _hintTextStyle,
      rangeTitleTextStyle: rangeTitleTextStyle ?? _rangeTitleTextStyle,
      inputTextStyle: inputTextStyle ?? _inputTextStyle,
      itemNormalTextStyle: itemNormalTextStyle ?? _itemNormalTextStyle,
      itemSelectedTextStyle: itemSelectedTextStyle ?? _itemSelectedTextStyle,
      itemBoldTextStyle: itemBoldTextStyle ?? _itemBoldTextStyle,
      deepNormalBgColor: deepNormalBgColor ?? _deepNormalBgColor,
      deepSelectBgColor: deepSelectBgColor ?? _deepSelectBgColor,
      middleNormalBgColor: middleNormalBgColor ?? _middleNormalBgColor,
      middleSelectBgColor: middleSelectBgColor ?? _middleSelectBgColor,
      lightNormalBgColor: lightNormalBgColor ?? _lightNormalBgColor,
      lightSelectBgColor: lightSelectBgColor ?? _lightSelectBgColor,
      resetTextStyle: resetTextStyle ?? _resetTextStyle,
      titleForMoreTextStyle: titleForMoreTextStyle ?? _titleForMoreTextStyle,
      optionTextStyle: optionTextStyle ?? _optionTextStyle,
      moreTextStyle: moreTextStyle ?? _moreTextStyle,
      flayerNormalTextStyle: flayerNormalTextStyle ?? _flayerNormalTextStyle,
      flayerSelectedTextStyle:
          flayerSelectedTextStyle ?? _flayerSelectedTextStyle,
      flayerBoldTextStyle: flayerBoldTextStyle ?? _flayerBoldTextStyle,
    );
  }

  BrnSelectionConfig merge(BrnSelectionConfig other) {
    return copyWith(
      menuNormalTextStyle:
          menuNormalTextStyle.merge(other._menuNormalTextStyle),
      menuSelectedTextStyle:
          menuSelectedTextStyle.merge(other._menuSelectedTextStyle),
      tagTextStyle: tagNormalTextStyle.merge(other._tagNormalTextStyle),
      tagSelectedTextStyle:
          tagSelectedTextStyle.merge(other._tagSelectedTextStyle),
      tagRadius: other._tagRadius,
      tagBackgroundColor: other._tagNormalBackgroundColor,
      tagSelectedBackgroundColor: other._tagSelectedBackgroundColor,
      hintTextStyle: hintTextStyle.merge(other._hintTextStyle),
      rangeTitleTextStyle:
          rangeTitleTextStyle.merge(other._rangeTitleTextStyle),
      inputTextStyle: inputTextStyle.merge(other._inputTextStyle),
      itemNormalTextStyle:
          itemNormalTextStyle.merge(other._itemNormalTextStyle),
      itemSelectedTextStyle:
          itemSelectedTextStyle.merge(other._itemSelectedTextStyle),
      itemBoldTextStyle: itemBoldTextStyle.merge(other._itemBoldTextStyle),
      deepNormalBgColor: other._deepNormalBgColor,
      deepSelectBgColor: other._deepSelectBgColor,
      middleNormalBgColor: other._middleNormalBgColor,
      middleSelectBgColor: other._middleSelectBgColor,
      lightNormalBgColor: other._lightNormalBgColor,
      lightSelectBgColor: other._lightSelectBgColor,
      resetTextStyle: resetTextStyle.merge(other._resetTextStyle),
      titleForMoreTextStyle:
          titleForMoreTextStyle.merge(other._titleForMoreTextStyle),
      optionTextStyle: optionTextStyle.merge(other._optionTextStyle),
      moreTextStyle: moreTextStyle.merge(other._moreTextStyle),
      flayerNormalTextStyle:
          flayerNormalTextStyle.merge(other._flayerNormalTextStyle),
      flayerSelectedTextStyle:
          flayerSelectedTextStyle.merge(other._flayerSelectedTextStyle),
      flayerBoldTextStyle:
          flayerBoldTextStyle.merge(other._flayerBoldTextStyle),
    );
  }
}
