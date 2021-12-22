import 'package:bruno/src/components/navbar/brn_appbar_theme.dart';
import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// 查看大图配置
class BrnGalleryDetailConfig extends BrnBaseConfig {
  /// 遵循全局配置
  /// 默认为 [BrnDefaultConfigUtils.defaultGalleryDetailConfig]
  BrnGalleryDetailConfig({
    this.appbarTitleStyle,
    this.appbarActionStyle,
    this.appbarBackgroundColor,
    this.appbarBrightness,
    this.tabBarUnSelectedLabelStyle,
    this.tabBarLabelStyle,
    this.tabBarBackgroundColor,
    this.pageBackgroundColor,
    this.bottomBackgroundColor,
    this.titleStyle,
    this.contentStyle,
    this.actionStyle,
    this.iconColor,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// 黑色主题
  BrnGalleryDetailConfig.dark({
    this.appbarTitleStyle,
    this.appbarActionStyle,
    this.appbarBackgroundColor,
    this.appbarBrightness,
    this.tabBarUnSelectedLabelStyle,
    this.tabBarLabelStyle,
    this.tabBarBackgroundColor,
    this.pageBackgroundColor,
    this.bottomBackgroundColor,
    this.titleStyle,
    this.contentStyle,
    this.actionStyle,
    this.iconColor,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId) {
    appbarTitleStyle = BrnTextStyle(color: commonConfig.colorTextBaseInverse);
    appbarActionStyle = BrnTextStyle(color: BrnAppBarTheme.lightTextColor);
    appbarBackgroundColor = Colors.black;
    appbarBrightness = Brightness.dark;
    tabBarUnSelectedLabelStyle = BrnTextStyle(color: Color(0XFFCCCCCC));
    tabBarLabelStyle = BrnTextStyle(color: commonConfig.colorTextBaseInverse);
    tabBarBackgroundColor = Colors.black;
    pageBackgroundColor = Colors.black;
    bottomBackgroundColor = Color(0X88000000);
    titleStyle = BrnTextStyle(color: commonConfig.colorTextBaseInverse);
    contentStyle = BrnTextStyle(color: Color(0xFFCCCCCC));
    actionStyle = BrnTextStyle(color: commonConfig.colorTextBaseInverse);
    iconColor = Colors.white;
  }

  /// 白色主题
  BrnGalleryDetailConfig.light({
    this.appbarTitleStyle,
    this.appbarActionStyle,
    this.appbarBackgroundColor,
    this.appbarBrightness,
    this.tabBarUnSelectedLabelStyle,
    this.tabBarLabelStyle,
    this.tabBarBackgroundColor,
    this.pageBackgroundColor,
    this.bottomBackgroundColor,
    this.titleStyle,
    this.contentStyle,
    this.actionStyle,
    this.iconColor,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId) {
    appbarTitleStyle = BrnTextStyle(color: commonConfig.colorTextBase);
    appbarActionStyle = BrnTextStyle(color: commonConfig.colorTextBase);
    appbarBackgroundColor = commonConfig.fillBody;
    appbarBrightness = Brightness.light;
    tabBarUnSelectedLabelStyle = BrnTextStyle(
      color: commonConfig.colorTextBase,
    );
    tabBarLabelStyle = BrnTextStyle(color: commonConfig.brandPrimary);
    tabBarBackgroundColor = commonConfig.fillBody;
    pageBackgroundColor = commonConfig.fillBody;
    bottomBackgroundColor = commonConfig.fillBody?.withOpacity(.85);
    titleStyle = BrnTextStyle(color: commonConfig.colorTextBase);
    contentStyle = BrnTextStyle(color: commonConfig.colorTextBase);
    actionStyle = BrnTextStyle(color: commonConfig.colorTextSecondary);
    iconColor = commonConfig.colorTextSecondary;
  }

  /// appbar   brightness待定

  /// appbar 标题样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBaseInverse],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? appbarTitleStyle;

  /// 右侧操作区域文案样式
  ///
  /// BrnTextStyle(
  ///   color: AppBarBrightness(brightness).textColor,
  ///   fontSize: BrnAppBarTheme.actionFontSize,
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? appbarActionStyle;

  /// appBar 背景色
  /// 默认为 Colors.black
  Color? appbarBackgroundColor;

  /// appbar brightness
  /// 默认为 [Brightness.dark]
  Brightness? appbarBrightness;

  /// tabBar 标题普通样式
  ///
  /// BrnTextStyle(
  ///   color: Colors.red,
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? tabBarUnSelectedLabelStyle;

  /// tabBar 标题选中样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBaseInverse],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? tabBarLabelStyle;

  /// tabBar 背景色
  /// 默认为 Colors.black
  Color? tabBarBackgroundColor;

  /// 页面 背景色
  /// 默认为 Colors.black
  Color? pageBackgroundColor;

  /// 底部内容区域的背景色
  /// 默认为 Color(0x88000000)
  Color? bottomBackgroundColor;

  /// 标题文案样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBaseInverse],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? titleStyle;

  /// 内容文案样式
  ///
  /// BrnTextStyle(
  ///   color: Color(0xFFCCCCCC),
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? contentStyle;

  /// 右侧展开收起样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBaseInverse],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? actionStyle;

  /// icon 颜色
  /// 默认为 Colors.white
  Color? iconColor;

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
    BrnGalleryDetailConfig? galleryDetailConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .galleryDetailConfig;

    appbarTitleStyle = galleryDetailConfig?.appbarTitleStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBaseInverse,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(appbarTitleStyle),
    );
    appbarActionStyle = galleryDetailConfig?.appbarActionStyle?.merge(
      appbarActionStyle,
    );
    appbarBrightness ??= galleryDetailConfig?.appbarBrightness;
    appbarBackgroundColor ??= galleryDetailConfig?.appbarBackgroundColor;
    tabBarUnSelectedLabelStyle = galleryDetailConfig?.tabBarUnSelectedLabelStyle
        ?.merge(BrnTextStyle(fontSize: commonConfig.fontSizeSubHead))
        .merge(tabBarUnSelectedLabelStyle);
    tabBarLabelStyle = galleryDetailConfig?.tabBarLabelStyle
        ?.merge(
          BrnTextStyle(
            color: commonConfig.colorTextBaseInverse,
            fontSize: commonConfig.fontSizeSubHead,
          ),
        )
        .merge(tabBarLabelStyle);
    tabBarBackgroundColor ??= galleryDetailConfig?.tabBarBackgroundColor;
    pageBackgroundColor ??= galleryDetailConfig?.pageBackgroundColor;
    bottomBackgroundColor ??= galleryDetailConfig?.bottomBackgroundColor;
    titleStyle = galleryDetailConfig?.titleStyle
        ?.merge(
          BrnTextStyle(
            color: commonConfig.colorTextBaseInverse,
            fontSize: commonConfig.fontSizeHead,
          ),
        )
        .merge(titleStyle);
    contentStyle = galleryDetailConfig?.contentStyle
        ?.merge(BrnTextStyle(fontSize: commonConfig.fontSizeBase))
        .merge(contentStyle);
    actionStyle = galleryDetailConfig?.actionStyle
        ?.merge(
          BrnTextStyle(
            color: commonConfig.colorTextBaseInverse,
            fontSize: commonConfig.fontSizeBase,
          ),
        )
        .merge(actionStyle);
    iconColor ??= galleryDetailConfig?.iconColor;
  }

  BrnGalleryDetailConfig copyWith({
    BrnTextStyle? appbarTitleStyle,
    BrnTextStyle? appbarActionStyle,
    Color? appbarBackgroundColor,
    Brightness? appbarBrightness,
    BrnTextStyle? tabBarUnSelectedLabelStyle,
    Color? tabBarUnselectedLabelColor,
    BrnTextStyle? tabBarLabelStyle,
    Color? tabBarLabelColor,
    Color? tabBarBackgroundColor,
    Color? indicatorColor,
    Color? pageBackgroundColor,
    Color? bottomBackgroundColor,
    BrnTextStyle? titleStyle,
    BrnTextStyle? contentStyle,
    BrnTextStyle? actionStyle,
    Color? iconColor,
  }) {
    return BrnGalleryDetailConfig(
      appbarTitleStyle: appbarTitleStyle ?? this.appbarTitleStyle,
      appbarActionStyle: appbarActionStyle ?? this.appbarActionStyle,
      appbarBackgroundColor:
          appbarBackgroundColor ?? this.appbarBackgroundColor,
      appbarBrightness: appbarBrightness ?? this.appbarBrightness,
      tabBarUnSelectedLabelStyle:
          tabBarUnSelectedLabelStyle ?? this.tabBarUnSelectedLabelStyle,
      tabBarLabelStyle: tabBarLabelStyle ?? this.tabBarLabelStyle,
      tabBarBackgroundColor:
          tabBarBackgroundColor ?? this.tabBarBackgroundColor,
      pageBackgroundColor: pageBackgroundColor ?? this.pageBackgroundColor,
      bottomBackgroundColor:
          bottomBackgroundColor ?? this.bottomBackgroundColor,
      titleStyle: titleStyle ?? this.titleStyle,
      contentStyle: contentStyle ?? this.contentStyle,
      actionStyle: actionStyle ?? this.actionStyle,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  BrnGalleryDetailConfig merge(BrnGalleryDetailConfig? other) {
    if (other == null) return this;
    return copyWith(
      appbarTitleStyle: appbarTitleStyle?.merge(other.appbarTitleStyle) ??
          other.appbarTitleStyle,
      appbarActionStyle: appbarActionStyle?.merge(other.appbarActionStyle) ??
          other.appbarActionStyle,
      appbarBackgroundColor: other.appbarBackgroundColor,
      appbarBrightness: other.appbarBrightness,
      tabBarUnSelectedLabelStyle:
          tabBarUnSelectedLabelStyle?.merge(other.tabBarUnSelectedLabelStyle) ??
              other.tabBarUnSelectedLabelStyle,
      tabBarLabelStyle: tabBarLabelStyle?.merge(other.tabBarLabelStyle) ??
          other.tabBarLabelStyle,
      tabBarBackgroundColor: other.tabBarBackgroundColor,
      pageBackgroundColor: other.pageBackgroundColor,
      bottomBackgroundColor: other.bottomBackgroundColor,
      titleStyle: titleStyle?.merge(other.titleStyle) ?? other.titleStyle,
      contentStyle:
          contentStyle?.merge(other.contentStyle) ?? other.contentStyle,
      actionStyle: actionStyle?.merge(other.actionStyle) ?? other.actionStyle,
      iconColor: other.iconColor,
    );
  }
}
