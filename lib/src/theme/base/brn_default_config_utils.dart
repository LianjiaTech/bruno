import 'package:bruno/src/components/navbar/brn_appbar_theme.dart';
import 'package:bruno/src/components/picker/base/brn_picker_constants.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/constants/brn_strings_constants.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart'
    show BRUNO_CONFIG_ID;
import 'package:bruno/src/theme/configs/brn_abnormal_state_config.dart';
import 'package:bruno/src/theme/configs/brn_action_sheet_config.dart';
import 'package:bruno/src/theme/configs/brn_all_config.dart';
import 'package:bruno/src/theme/configs/brn_appbar_config.dart';
import 'package:bruno/src/theme/configs/brn_button_config.dart';
import 'package:bruno/src/theme/configs/brn_card_title_config.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:bruno/src/theme/configs/brn_dialog_config.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:bruno/src/theme/configs/brn_gallery_detail_config.dart';
import 'package:bruno/src/theme/configs/brn_enhance_number_card_config.dart';
import 'package:bruno/src/theme/configs/brn_pair_info_config.dart';
import 'package:bruno/src/theme/configs/brn_picker_config.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/theme/configs/brn_tabbar_config.dart';
import 'package:bruno/src/theme/configs/brn_tag_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Bruno默认配置
class BrnDefaultConfigUtils {
  const BrnDefaultConfigUtils._();

  /// 默认全局配置
  static BrnAllThemeConfig defaultAllConfig = BrnAllThemeConfig(
    commonConfig: defaultCommonConfig,
    formItemConfig: defaultFormItemConfig,
    dialogConfig: defaultDialogConfig,
    cardTitleConfig: defaultCardTitleConfig,
    abnormalStateConfig: defaultAbnormalStateConfig,
    tagConfig: defaultTagConfig,
    appBarConfig: defaultAppBarConfig,
    pairInfoTableConfig: defaultPairInfoTableConfig,
    pairRichInfoGridConfig: defaultPairRichInfoGridConfig,
    buttonConfig: defaultButtonConfig,
    actionSheetConfig: defaultActionSheetConfig,
    pickerConfig: defaultPickerConfig,
    enhanceNumberCardConfig: defaultEnhanceNumberInfoConfig,
    tabBarConfig: defaultTabBarConfig,
    selectionConfig: defaultSelectionConfig,
    galleryDetailConfig: defaultGalleryDetailConfig,
  );

  /// 全局默认配置
  static BrnCommonConfig defaultCommonConfig = BrnCommonConfig(
    /// 主题色相关
    ///
    /// 主题色
    brandPrimary: const Color(0xFF0984F9),

    /// 主题色按下效果
    brandPrimaryTap: const Color(0x190984F9),

    /// 成功色
    brandSuccess: const Color(0xFF00AE66),

    /// 警告色
    brandWarning: const Color(0xFFFAAD14),

    /// 失败色
    brandError: const Color(0xFFFA3F3F),

    /// 重要-多用于红点色
    brandImportant: const Color(0xFFFA3F3F),

    /// 重要数值色
    brandImportantValue: const Color(0xFFFF5722),

    /// 辅助色
    brandAuxiliary: const Color(0xFF44C2FF),

    /// 文本色相关
    ///
    /// 基础文字纯黑色
    colorTextBase: const Color(0xFF222222),

    /// 基础文字重要色
    colorTextImportant: const Color(0xFF666666),

    /// 基础文字-反色
    colorTextBaseInverse: const Color(0xFFFFFFFF),

    /// 辅助文字色
    colorTextSecondary: const Color(0xFF999999),

    /// 失效或不可更改文字色
    colorTextDisabled: const Color(0xFF999999),

    /// 文本框提示暗文文字色
    colorTextHint: const Color(0xFFCCCCCC),

    /// 跟随主题色[brandPrimary]
    colorLink: const Color(0xFF0984F9),

    /// 背景色相关
    ///
    /// 组件背景色
    fillBase: const Color(0xFFFFFFFF),

    /// 页面背景色
    fillBody: const Color(0xFFF8F8F8),

    /// 遮罩背景
    fillMask: const Color(0x99000000),

    /// 边框色
    borderColorBase: const Color(0xFFF0F0F0),

    /// 分割线色
    dividerColorBase: const Color(0xFFF0F0F0),

    /// 文本字号
    ///
    /// 特殊数据展示，Bebas 数字字体，用于强吸引
    fontSizeBebas: 28.0,

    /// 标题字体
    /// 名称/页面大标题
    fontSizeHeadLg: 22.0,

    /// 标题字体
    /// 内容模块标题/一级标题
    fontSizeHead: 18.0,

    /// 子标题字体
    /// 标题/录入文字/大按钮文字/二级标题
    fontSizeSubHead: 16.0,

    /// 基础字体
    /// 内容副文本/普通说明文字
    fontSizeBase: 14.0,

    /// 辅助字体-普通
    fontSizeCaption: 12.0,

    ///辅助字体-小
    fontSizeCaptionSm: 11.0,

    /// 圆角尺寸
    radiusXs: 2.0,
    radiusSm: 4.0,
    radiusMd: 6.0,
    radiusLg: 8.0,

    /// 边框尺寸
    borderWidthSm: 0.5,
    borderWidthMd: 1.0,
    borderWidthLg: 2.0,

    /// 水平间距
    hSpacingXs: 8.0,
    hSpacingSm: 12.0,
    hSpacingMd: 16.0,
    hSpacingLg: 20.0,
    hSpacingXl: 24.0,
    hSpacingXxl: 42.0,

    /// 垂直间距
    vSpacingXs: 4.0,
    vSpacingSm: 8.0,
    vSpacingMd: 12.0,
    vSpacingLg: 14.0,
    vSpacingXl: 16.0,
    vSpacingXxl: 28.0,

    /// 图标大小
    iconSizeXxs: 8.0,
    iconSizeXs: 12.0,
    iconSizeSm: 14.0,
    iconSizeMd: 16.0,
    iconSizeLg: 32.0,
  );

  ///******** 以下是子配置项 ********///

  /// 表单项默认配置
  static BrnFormItemConfig defaultFormItemConfig = BrnFormItemConfig(
    backgroundColor: Colors.white,
    headTitleTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeHead,
    ),
    titleTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    subTitleTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextSecondary,
      fontSize: defaultCommonConfig.fontSizeCaption,
    ),
    errorTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandError,
      fontSize: defaultCommonConfig.fontSizeCaption,
    ),
    hintTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextHint,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    contentTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    optionsMiddlePadding: EdgeInsets.only(
      left: defaultCommonConfig.hSpacingMd,
    ),
    optionTextStyle: BrnTextStyle(
      height: 1.3,
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    optionSelectedTextStyle: BrnTextStyle(
      height: 1.3,
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    formPadding: EdgeInsets.only(
      left: 0.0,
      top: defaultCommonConfig.vSpacingLg,
      right: defaultCommonConfig.hSpacingLg,
      bottom: defaultCommonConfig.vSpacingLg,
    ),
    titlePaddingSm: EdgeInsets.only(left: 10),
    titlePaddingLg: EdgeInsets.only(left: defaultCommonConfig.hSpacingLg),
    subTitlePadding: EdgeInsets.only(
      left: defaultCommonConfig.hSpacingLg,
      top: defaultCommonConfig.vSpacingXs,
    ),
    errorPadding: EdgeInsets.only(
      left: defaultCommonConfig.hSpacingLg,
      top: defaultCommonConfig.vSpacingXs,
    ),
    disableTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextDisabled,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    tipsTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextSecondary,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
  );

  /// Dialog默认配置
  static BrnDialogConfig defaultDialogConfig = BrnDialogConfig(
    dialogWidth: 300.0,
    radius: defaultCommonConfig.radiusLg,
    iconPadding: EdgeInsets.only(top: defaultCommonConfig.vSpacingXxl),
    titlePaddingSm: EdgeInsets.only(
      top: 12.0,
      left: defaultCommonConfig.hSpacingXxl,
      right: defaultCommonConfig.hSpacingXxl,
    ),
    titlePaddingLg: EdgeInsets.only(
      top: 28.0,
      left: defaultCommonConfig.hSpacingXxl,
      right: defaultCommonConfig.hSpacingXxl,
    ),
    titleTextStyle: BrnTextStyle(
      fontWeight: FontWeight.w600,
      fontSize: defaultCommonConfig.fontSizeHead,
      color: defaultCommonConfig.colorTextBase,
    ),
    titleTextAlign: TextAlign.center,
    contentPaddingSm: EdgeInsets.only(
      top: 8.0,
      left: defaultCommonConfig.hSpacingXl,
      right: defaultCommonConfig.hSpacingXl,
    ),
    contentPaddingLg: EdgeInsets.only(
      top: 28.0,
      left: defaultCommonConfig.hSpacingXl,
      right: defaultCommonConfig.hSpacingXl,
    ),
    contentTextStyle: BrnTextStyle(
      fontSize: defaultCommonConfig.fontSizeBase,
      color: defaultCommonConfig.colorTextImportant,
      decoration: TextDecoration.none,
    ),
    contentTextAlign: TextAlign.center,
    warningPaddingSm: EdgeInsets.only(
      top: 6.0,
      left: defaultCommonConfig.hSpacingXl,
      right: defaultCommonConfig.hSpacingXl,
    ),
    warningPaddingLg: EdgeInsets.only(
      top: 28.0,
      left: defaultCommonConfig.hSpacingXl,
      right: defaultCommonConfig.hSpacingXl,
    ),
    warningTextAlign: TextAlign.center,
    warningTextStyle: BrnTextStyle(
      fontSize: defaultCommonConfig.fontSizeBase,
      color: defaultCommonConfig.brandError,
      decoration: TextDecoration.none,
    ),
    dividerPadding: EdgeInsets.only(top: 28.0),
    mainActionTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontWeight: FontWeight.w600,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    assistActionsTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontWeight: FontWeight.w600,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    mainActionBackgroundColor: defaultCommonConfig.fillBase,
    assistActionsBackgroundColor: defaultCommonConfig.fillBase,
    bottomHeight: 44.0,
    backgroundColor: defaultCommonConfig.fillBase,
  );

  /// 卡片标题配置
  static BrnCardTitleConfig defaultCardTitleConfig = BrnCardTitleConfig(
    titleWithHeightTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeHead,
      height: 25.0 / 18.0,
      fontWeight: FontWeight.w600,
    ),
    titleTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeHead,
      fontWeight: FontWeight.w600,
    ),
    subtitleTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextSecondary,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    detailTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    accessoryTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextSecondary,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    cardTitlePadding: EdgeInsets.only(
      top: defaultCommonConfig.vSpacingXl,
      bottom: defaultCommonConfig.vSpacingMd,
    ),
    alignment: PlaceholderAlignment.middle,
    cardBackgroundColor: defaultCommonConfig.fillBase,
  );

  /// 空页面配置
  static BrnAbnormalStateConfig defaultAbnormalStateConfig =
      BrnAbnormalStateConfig(
    titleTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextHint,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    operateTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    btnRadius: 4,
    doubleTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    singleTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBaseInverse,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    singleMinWidth: 160.0,
    doubleMinWidth: 120.0,
  );

  /// 标签配置
  static BrnTagConfig defaultTagConfig = BrnTagConfig(
    tagTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeCaption,
    ),
    selectTagTextStyle: BrnTextStyle(
      fontWeight: FontWeight.w600,
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeCaption,
    ),
    tagBackgroundColor: defaultCommonConfig.fillBody,
    selectedTagBackgroundColor: defaultCommonConfig.brandPrimary,
    tagRadius: defaultCommonConfig.radiusXs,
    tagHeight: 34.0,
    tagWidth: 75.0,
    tagMinWidth: 75.0,
  );

  /// 导航栏配置
  static BrnAppBarConfig defaultAppBarConfig = BrnAppBarConfig(
    backgroundColor: Colors.white,
    appBarHeight: BrnAppBarTheme.appBarHeight,
    leadIconBuilder: () => Image.asset(
      BrnAsset.iconBackBlack,
      package: BrnStrings.flutterPackageName,
      width: BrnAppBarTheme.iconSize,
      height: BrnAppBarTheme.iconSize,
      fit: BoxFit.fitHeight,
    ),
    titleStyle: BrnTextStyle(
      fontSize: BrnAppBarTheme.titleFontSize,
      fontWeight: FontWeight.w600,
      color: BrnAppBarTheme.lightTextColor,
    ),
    actionsStyle: BrnTextStyle(
      color: BrnAppBarTheme.lightTextColor,
      fontSize: BrnAppBarTheme.actionFontSize,
      fontWeight: FontWeight.w600,
    ),
    titleMaxLength: BrnAppBarTheme.maxLength,
    leftAndRightPadding: 20.0,
    itemSpacing: BrnAppBarTheme.iconMargin,
    titlePadding: EdgeInsets.zero,
    iconSize: BrnAppBarTheme.iconSize,
    configId: BRUNO_CONFIG_ID,
    systemUiOverlayStyle: SystemUiOverlayStyle.dark,
    showDefaultBottom: false,
  );

  /// 内容信息（两列）配置
  static BrnPairInfoTableConfig defaultPairInfoTableConfig =
      BrnPairInfoTableConfig(
    rowSpacing: 4,
    itemSpacing: 2,
    keyTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextSecondary,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    valueTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    linkTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    configId: BRUNO_CONFIG_ID,
  );

  /// 内容信息（一列）配置
  static BrnPairRichInfoGridConfig defaultPairRichInfoGridConfig =
      BrnPairRichInfoGridConfig(
    rowSpacing: 4.0,
    itemSpacing: 2.0,
    itemHeight: 20.0,
    keyTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextSecondary,
      fontSize: defaultCommonConfig.fontSizeBase,
      textBaseline: TextBaseline.ideographic,
    ),
    valueTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeBase,
      textBaseline: TextBaseline.ideographic,
    ),
    linkTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeBase,
      textBaseline: TextBaseline.ideographic,
    ),
    configId: BRUNO_CONFIG_ID,
  );

  /// 按钮配置
  static BrnButtonConfig defaultButtonConfig = BrnButtonConfig(
    bigButtonRadius: 6.0,
    bigButtonHeight: 48.0,
    bigButtonFontSize: 16.0,
    smallButtonRadius: 4.0,
    smallButtonHeight: 32.0,
    smallButtonFontSize: 14.0,
    configId: BRUNO_CONFIG_ID,
  );

  static BrnActionSheetConfig defaultActionSheetConfig = BrnActionSheetConfig(
    topRadius: defaultCommonConfig.radiusLg,
    titleStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextSecondary,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    itemTitleStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
    itemTitleStyleLink: BrnTextStyle(
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
      color: defaultCommonConfig.colorLink,
    ),
    itemTitleStyleAlert: BrnTextStyle(
      color: defaultCommonConfig.brandError,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
    itemDescStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeCaption,
      fontWeight: FontWeight.w600,
    ),
    itemDescStyleLink: BrnTextStyle(
      color: defaultCommonConfig.colorLink,
      fontSize: defaultCommonConfig.fontSizeCaption,
      fontWeight: FontWeight.w600,
    ),
    itemDescStyleAlert: BrnTextStyle(
      color: defaultCommonConfig.brandError,
      fontSize: defaultCommonConfig.fontSizeCaption,
      fontWeight: FontWeight.w600,
    ),
    cancelStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
    titlePadding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 16.0),
    contentPadding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 12.0),
  );

  static BrnPickerConfig defaultPickerConfig = BrnPickerConfig(
    backgroundColor: pickerBackgroundColor,
    cancelTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    confirmTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    titleTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    ),
    pickerHeight: pickerHeight,
    titleHeight: pickerTitleHeight,
    itemHeight: pickerItemHeight,
    dividerColor: Color(0xFFF0F0F0),
    itemTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeHead,
    ),
    itemTextSelectedStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeHead,
      fontWeight: FontWeight.w600,
    ),
    cornerRadius: 8,
  );

  /// 数字增强信息配置
  static BrnEnhanceNumberCardConfig defaultEnhanceNumberInfoConfig =
      BrnEnhanceNumberCardConfig(
    runningSpace: 16.0,
    itemRunningSpace: 8.0,
    titleTextStyle: BrnTextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
    descTextStyle: BrnTextStyle(
      fontSize: 12.0,
      color: defaultCommonConfig.colorTextSecondary,
    ),
    dividerWidth: 0.5,
  );

  /// TabBar配置
  static BrnTabBarConfig defaultTabBarConfig = BrnTabBarConfig(
    backgroundColor: Colors.white,
    tabHeight: 50.0,
    indicatorHeight: 2.0,
    indicatorWidth: 24.0,
    labelStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.normal,
    ),
    tagRadius: defaultCommonConfig.radiusSm,
    tagNormalTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeCaption,
    ),
    tagNormalBgColor: defaultCommonConfig.fillBody,
    tagSelectedTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeCaption,
    ),
    tagSelectedBgColor: defaultCommonConfig.brandPrimary.withAlpha(0x14),
    tagSpacing: 12.0,
    preLineTagCount: 4,
    tagHeight: 32.0,
  );

  /// 筛选项配置
  static BrnSelectionConfig defaultSelectionConfig = BrnSelectionConfig(
    menuNormalTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    menuSelectedTextStyle: BrnTextStyle(
      fontWeight: FontWeight.w600,
      fontSize: defaultCommonConfig.fontSizeBase,
      color: defaultCommonConfig.brandPrimary,
    ),
    tagNormalTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeCaption,
    ),
    tagSelectedTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeCaption,
      fontWeight: FontWeight.w600,
    ),
    tagRadius: defaultCommonConfig.radiusSm,
    tagNormalBackgroundColor: defaultCommonConfig.fillBody,
    tagSelectedBackgroundColor:
        defaultCommonConfig.brandPrimary.withOpacity(0.12),
    rangeTitleTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
    hintTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextHint,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    inputTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    itemNormalTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    itemSelectedTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeBase,
      fontWeight: FontWeight.w600,
    ),
    itemBoldTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeBase,
      fontWeight: FontWeight.w600,
    ),
    lightSelectBgColor: Colors.white,
    lightNormalBgColor: Colors.white,
    middleSelectBgColor: Colors.white,
    middleNormalBgColor: Color(0xFFF8F8F8),
    deepSelectBgColor: Color(0xFFF8F8F8),
    deepNormalBgColor: Color(0xFFF0F0F0),
    resetTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextImportant,
      fontSize: defaultCommonConfig.fontSizeCaption,
    ),
    titleForMoreTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeBase,
      fontWeight: FontWeight.w600,
    ),
    optionTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    moreTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextSecondary,
      fontSize: defaultCommonConfig.fontSizeCaption,
    ),
    flayerNormalTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
    ),
    flayerSelectedTextStyle: BrnTextStyle(
      color: defaultCommonConfig.brandPrimary,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
    flayerBoldTextStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBase,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
  );

  /// 查看图片配置
  static BrnGalleryDetailConfig defaultGalleryDetailConfig =
      BrnGalleryDetailConfig(
    appbarTitleStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBaseInverse,
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
    appbarActionStyle: BrnTextStyle(
      color: BrnAppBarTheme.lightTextColor,
      fontSize: BrnAppBarTheme.actionFontSize,
      fontWeight: FontWeight.w600,
    ),
    appbarBackgroundColor: Colors.black,
    appbarConfig: BrnAppBarConfig.dark(),
    tabBarUnSelectedLabelStyle: BrnTextStyle(
      fontSize: 16.0,
      color: Color(0XFFCCCCCC),
    ),
    tabBarLabelStyle: BrnTextStyle(
      fontSize: defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
      color: defaultCommonConfig.colorTextBaseInverse,
    ),
    tabBarBackgroundColor: Colors.black,
    pageBackgroundColor: Colors.black,
    bottomBackgroundColor: Color(0X88000000),
    titleStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBaseInverse,
      fontSize: defaultCommonConfig.fontSizeHead,
      fontWeight: FontWeight.w600,
    ),
    contentStyle: BrnTextStyle(
      color: Color(0xFFCCCCCC),
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    actionStyle: BrnTextStyle(
      color: defaultCommonConfig.colorTextBaseInverse,
      fontSize: defaultCommonConfig.fontSizeBase,
    ),
    iconColor: Colors.white,
  );
}
