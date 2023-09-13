

import 'package:bruno/src/components/button/brn_normal_button.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';

/// 页面中和主题色相关的幽灵按钮 可以支持自定义背景颜色、文字颜色等
///
/// 和[BrnBigMainButton]相比，该按钮的背景色仅仅是其背景色的withOpacity(0.1)
/// 并且该按钮不支持不可用状态
///
/// 按钮是圆角矩形的形状，不支持改变形状。
///
/// BrnBigGhostButtonWidget(
///    title: '提交',
/// )
///
/// 其他按钮如下：
///  * [BrnBigMainButton], 大主色调按钮
///  * [BrnBigOutlineButton], 大边框按钮

class BrnBigGhostButton extends StatelessWidget {
  /// 按钮文案，默认'确认'
  final String? title;

  /// 文案颜色
  final Color? titleColor;

  /// 按钮背景颜色
  final Color? bgColor;

  /// 点击回调
  final VoidCallback? onTap;

  /// 默认父布局可用空间
  final double? width;

  /// button theme config
  final BrnButtonConfig? themeData;

  /// create BrnBigGhostButton
  const BrnBigGhostButton({
    Key? key,
    this.title,
    this.titleColor,
    this.bgColor,
    this.onTap,
    this.width,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BrnButtonConfig defaultThemeConfig = themeData ?? BrnButtonConfig();
    defaultThemeConfig = BrnThemeConfigurator.instance
        .getConfig(configId: defaultThemeConfig.configId)
        .buttonConfig.merge(defaultThemeConfig);

    return BrnNormalButton(
      borderRadius: BorderRadius.circular(defaultThemeConfig.bigButtonRadius),
      constraints: BoxConstraints.tightFor(
          width: width ?? double.infinity,
          height: defaultThemeConfig.bigButtonHeight),
      backgroundColor: bgColor ??
          defaultThemeConfig.commonConfig.brandPrimary.withOpacity(0.05),
      onTap: onTap,
      alignment: Alignment.center,
      text: title ?? BrnIntl.of(context).localizedResource.confirm,
      textColor: titleColor ?? defaultThemeConfig.commonConfig.brandPrimary,
      fontSize: defaultThemeConfig.bigButtonFontSize,
    );
  }
}
