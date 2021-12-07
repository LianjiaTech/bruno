import 'package:bruno/src/theme/brn_theme.dart';
import 'package:bruno/src/theme/configs/brn_abnormal_state_config.dart';

/// 描述: 全局配置
///
/// 当用户使用时对单个组件自定义配置，优先走单个组件特定配置（作用范围档次使用）
/// 当用户配置组件通用配置时如[BrnDialogConfig]优先使用该配置
/// 若没有配置组件通用配置，走[BrnCommonConfig]全局配置
/// 如果以上都没有配置走Bruno默认配置即[BrnDefaultConfigUtils]中配置
/// 当没有配置组件的特定属性时使用上一级特定配置
///
class BrnAllThemeConfig {
  BrnCommonConfig commonConfig;
  BrnAppBarConfig appBarConfig;
  BrnButtonConfig buttonConfig;
  BrnDialogConfig dialogConfig;
  BrnCardTitleConfig cardTitleConfig;
  BrnAbnormalStateConfig abnormalStateConfig;
  BrnTagConfig tagConfig;
  BrnPairInfoTableConfig pairInfoTableConfig;
  BrnPairRichInfoGridConfig pairRichInfoGridConfig;
  BrnActionSheetConfig actionSheetConfig;
  BrnPickerConfig pickerConfig;
  BrnEnhanceNumberCardConfig enhanceNumberCardConfig;
  BrnTabBarConfig tabBarConfig;
  BrnFormItemConfig formItemConfig;
  BrnSelectionConfig selectionConfig;
  BrnGalleryDetailConfig galleryDetailConfig;

  BrnAllThemeConfig(
      {this.commonConfig,
      this.appBarConfig,
      this.buttonConfig,
      this.dialogConfig,
      this.formItemConfig,
      this.cardTitleConfig,
      this.abnormalStateConfig,
      this.tagConfig,
      this.pairInfoTableConfig,
      this.pairRichInfoGridConfig,
      this.actionSheetConfig,
      this.pickerConfig,
      this.enhanceNumberCardConfig,
      this.tabBarConfig,
      this.selectionConfig,
      this.galleryDetailConfig,
      String configId = BrnThemeConfigurator.GLOBAL_CONFIG_ID});

  void initThemeConfig(String configId) {

    this.commonConfig ??= BrnCommonConfig();
    this.appBarConfig ??= BrnAppBarConfig();
    this.buttonConfig ??= BrnButtonConfig();
    this.dialogConfig ??= BrnDialogConfig();
    this.formItemConfig ??= BrnFormItemConfig();
    this.cardTitleConfig ??= BrnCardTitleConfig();
    this.abnormalStateConfig ??= BrnAbnormalStateConfig();
    this.tagConfig ??= BrnTagConfig();
    this.appBarConfig ??= BrnAppBarConfig();
    this.pairInfoTableConfig ??= BrnPairInfoTableConfig();
    this.pairRichInfoGridConfig ??= BrnPairRichInfoGridConfig();
    this.actionSheetConfig ??= BrnActionSheetConfig();
    this.pickerConfig ??= BrnPickerConfig();
    this.enhanceNumberCardConfig ??= BrnEnhanceNumberCardConfig();
    this.tabBarConfig ??= BrnTabBarConfig();
    this.selectionConfig ??= BrnSelectionConfig();
    this.galleryDetailConfig ??= BrnGalleryDetailConfig();

    commonConfig?.initThemeConfig(configId);
    appBarConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    buttonConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    dialogConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    formItemConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    cardTitleConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    abnormalStateConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    tagConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    pairInfoTableConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    pairRichInfoGridConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    selectionConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    actionSheetConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    pickerConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    enhanceNumberCardConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    tabBarConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
    galleryDetailConfig?.initThemeConfig(configId, currentLevelCommonConfig: commonConfig);
  }
}
