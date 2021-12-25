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
    required this.commonConfig,
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
    String configId = GLOBAL_CONFIG_ID,
  });

  BrnCommonConfig? commonConfig;
  BrnAppBarConfig? appBarConfig;
  BrnButtonConfig? buttonConfig;
  BrnDialogConfig? dialogConfig;
  BrnCardTitleConfig? cardTitleConfig;
  BrnAbnormalStateConfig? abnormalStateConfig;
  BrnTagConfig? tagConfig;
  BrnPairInfoTableConfig? pairInfoTableConfig;
  BrnPairRichInfoGridConfig? pairRichInfoGridConfig;
  BrnActionSheetConfig? actionSheetConfig;
  BrnPickerConfig? pickerConfig;
  BrnEnhanceNumberCardConfig? enhanceNumberCardConfig;
  BrnTabBarConfig? tabBarConfig;
  BrnFormItemConfig? formItemConfig;
  BrnSelectionConfig? selectionConfig;
  BrnGalleryDetailConfig? galleryDetailConfig;

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
    appBarConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    buttonConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    dialogConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    formItemConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    cardTitleConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    abnormalStateConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    tagConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    pairInfoTableConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    pairRichInfoGridConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    selectionConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    actionSheetConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    pickerConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    enhanceNumberCardConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    tabBarConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
    galleryDetailConfig?.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
  }
}
