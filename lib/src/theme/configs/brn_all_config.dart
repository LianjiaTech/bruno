import 'package:bruno/bruno.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_abnormal_state_config.dart';
import 'package:bruno/src/theme/configs/brn_action_sheet_config.dart';
import 'package:bruno/src/theme/configs/brn_appbar_config.dart';
import 'package:bruno/src/theme/configs/brn_button_config.dart';
import 'package:bruno/src/theme/configs/brn_card_title_config.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:bruno/src/theme/configs/brn_dialog_config.dart';
import 'package:bruno/src/theme/configs/brn_enhance_number_card_config.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:bruno/src/theme/configs/brn_gallery_detail_config.dart';
import 'package:bruno/src/theme/configs/brn_pair_info_config.dart';
import 'package:bruno/src/theme/configs/brn_picker_config.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/theme/configs/brn_tabbar_config.dart';
import 'package:bruno/src/theme/configs/brn_tag_config.dart';

/// 描述: 全局配置
///
/// 当用户使用时对单个组件自定义配置，优先走单个组件特定配置（作用范围档次使用）
/// 当用户配置组件通用配置时如 [BrnDialogConfig] 优先使用该配置
/// 若没有配置组件通用配置，走 [BrnCommonConfig] 全局配置
/// 如果以上都没有配置走 Bruno 默认配置，即 [BrnDefaultConfigUtils] 中的配置
/// 当没有配置组件的特定属性时使用上一级特定配置
class BrnAllThemeConfig {
  BrnAllThemeConfig({
    BrnCommonConfig? commonConfig,
    BrnAppBarConfig? appBarConfig,
    BrnButtonConfig? buttonConfig,
    BrnDialogConfig? dialogConfig,
    BrnFormItemConfig? formItemConfig,
    BrnCardTitleConfig? cardTitleConfig,
    BrnAbnormalStateConfig? abnormalStateConfig,
    BrnTagConfig? tagConfig,
    BrnPairInfoTableConfig? pairInfoTableConfig,
    BrnPairRichInfoGridConfig? pairRichInfoGridConfig,
    BrnActionSheetConfig? actionSheetConfig,
    BrnPickerConfig? pickerConfig,
    BrnEnhanceNumberCardConfig? enhanceNumberCardConfig,
    BrnTabBarConfig? tabBarConfig,
    BrnSelectionConfig? selectionConfig,
    BrnGalleryDetailConfig? galleryDetailConfig,
    String configId = GLOBAL_CONFIG_ID,
  })  : _commonConfig = commonConfig,
        _appBarConfig = appBarConfig,
        _buttonConfig = buttonConfig,
        _dialogConfig = dialogConfig,
        _formItemConfig = formItemConfig,
        _cardTitleConfig = cardTitleConfig,
        _abnormalStateConfig = abnormalStateConfig,
        _tagConfig = tagConfig,
        _pairInfoTableConfig = pairInfoTableConfig,
        _pairRichInfoGridConfig = pairRichInfoGridConfig,
        _actionSheetConfig = actionSheetConfig,
        _pickerConfig = pickerConfig,
        _enhanceNumberCardConfig = enhanceNumberCardConfig,
        _tabBarConfig = tabBarConfig,
        _selectionConfig = selectionConfig,
        _galleryDetailConfig = galleryDetailConfig;

  BrnCommonConfig? _commonConfig;

  BrnCommonConfig get commonConfig =>
      _commonConfig ?? BrnDefaultConfigUtils.defaultCommonConfig;

  BrnAppBarConfig? _appBarConfig;

  BrnAppBarConfig get appBarConfig =>
      _appBarConfig ?? BrnDefaultConfigUtils.defaultAppBarConfig;

  BrnButtonConfig? _buttonConfig;

  BrnButtonConfig get buttonConfig =>
      _buttonConfig ?? BrnDefaultConfigUtils.defaultButtonConfig;

  BrnDialogConfig? _dialogConfig;

  BrnDialogConfig get dialogConfig =>
      _dialogConfig ?? BrnDefaultConfigUtils.defaultDialogConfig;

  BrnCardTitleConfig? _cardTitleConfig;

  BrnCardTitleConfig get cardTitleConfig =>
      _cardTitleConfig ?? BrnDefaultConfigUtils.defaultCardTitleConfig;

  BrnAbnormalStateConfig? _abnormalStateConfig;

  BrnAbnormalStateConfig get abnormalStateConfig =>
      _abnormalStateConfig ?? BrnDefaultConfigUtils.defaultAbnormalStateConfig;

  BrnTagConfig? _tagConfig;

  BrnTagConfig get tagConfig =>
      _tagConfig ?? BrnDefaultConfigUtils.defaultTagConfig;

  BrnPairInfoTableConfig? _pairInfoTableConfig;

  BrnPairInfoTableConfig get pairInfoTableConfig =>
      _pairInfoTableConfig ?? BrnDefaultConfigUtils.defaultPairInfoTableConfig;

  BrnPairRichInfoGridConfig? _pairRichInfoGridConfig;

  BrnPairRichInfoGridConfig get pairRichInfoGridConfig =>
      _pairRichInfoGridConfig ??
      BrnDefaultConfigUtils.defaultPairRichInfoGridConfig;

  BrnActionSheetConfig? _actionSheetConfig;

  BrnActionSheetConfig get actionSheetConfig =>
      _actionSheetConfig ?? BrnDefaultConfigUtils.defaultActionSheetConfig;

  BrnPickerConfig? _pickerConfig;

  BrnPickerConfig get pickerConfig =>
      _pickerConfig ?? BrnDefaultConfigUtils.defaultPickerConfig;

  BrnEnhanceNumberCardConfig? _enhanceNumberCardConfig;

  BrnEnhanceNumberCardConfig get enhanceNumberCardConfig =>
      _enhanceNumberCardConfig ??
      BrnDefaultConfigUtils.defaultEnhanceNumberInfoConfig;

  BrnTabBarConfig? _tabBarConfig;

  BrnTabBarConfig get tabBarConfig =>
      _tabBarConfig ?? BrnDefaultConfigUtils.defaultTabBarConfig;

  BrnFormItemConfig? _formItemConfig;

  BrnFormItemConfig get formItemConfig =>
      _formItemConfig ?? BrnDefaultConfigUtils.defaultFormItemConfig;

  BrnSelectionConfig? _selectionConfig;

  BrnSelectionConfig get selectionConfig =>
      _selectionConfig ?? BrnDefaultConfigUtils.defaultSelectionConfig;

  BrnGalleryDetailConfig? _galleryDetailConfig;

  BrnGalleryDetailConfig get galleryDetailConfig =>
      _galleryDetailConfig ?? BrnDefaultConfigUtils.defaultGalleryDetailConfig;

  void initThemeConfig(String configId) {
    this._commonConfig ??= BrnCommonConfig();
    this._appBarConfig ??= BrnAppBarConfig();
    this._buttonConfig ??= BrnButtonConfig();
    this._dialogConfig ??= BrnDialogConfig();
    this._formItemConfig ??= BrnFormItemConfig();
    this._cardTitleConfig ??= BrnCardTitleConfig();
    this._abnormalStateConfig ??= BrnAbnormalStateConfig();
    this._tagConfig ??= BrnTagConfig();
    this._appBarConfig ??= BrnAppBarConfig();
    this._pairInfoTableConfig ??= BrnPairInfoTableConfig();
    this._pairRichInfoGridConfig ??= BrnPairRichInfoGridConfig();
    this._actionSheetConfig ??= BrnActionSheetConfig();
    this._pickerConfig ??= BrnPickerConfig();
    this._enhanceNumberCardConfig ??= BrnEnhanceNumberCardConfig();
    this._tabBarConfig ??= BrnTabBarConfig();
    this._selectionConfig ??= BrnSelectionConfig();
    this._galleryDetailConfig ??= BrnGalleryDetailConfig();

    commonConfig.initThemeConfig(configId);
    appBarConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    buttonConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    dialogConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    formItemConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    cardTitleConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    abnormalStateConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    tagConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    pairInfoTableConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    pairRichInfoGridConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    selectionConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    actionSheetConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    pickerConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    enhanceNumberCardConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    tabBarConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    galleryDetailConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
  }
}
