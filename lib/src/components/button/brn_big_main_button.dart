import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';
import 'brn_normal_button.dart';

/// 页面中的主按钮,支持动态设置背景颜色，置灰
///
/// 和[BrnSmallMainButton]相比，该按钮是占据父节点分配的最大可用空间，按钮文案居中对齐
///
/// 按钮是圆角矩形的形状，不支持改变形状。
///
/// 按钮也存在可用和不可用两种状态，[isEnable]如果设置为false，那么按钮呈现灰色态，点击事件不响应
///
/// 大的 提交 按钮
/// BrnBigMainButtonWidget(
///    title: '提交',
/// )
///
/// BrnBigMainButtonWidget(
///   title: '提交',
///   isEnable: false,
///   onTap: () {
///     BrnToast.show('点击了主按钮', context);
///   },
/// ),

/// 其他按钮如下：
///  * [BrnBigGhostButton], 大主色调的幽灵按钮
///  * [BrnBigOutlineButton], 大边框按钮
class BrnBigMainButton extends StatelessWidget {
  ///按钮显示文案,默认'确认'
  final String? title;

  ///是否可用,false 是置灰效果
  final bool isEnable;

  ///点击回调
  final VoidCallback? onTap;

  ///默认父布局可用空间
  final double? width;

  ///背景颜色
  final Color? bgColor;

  /// button theme config
  final BrnButtonConfig? themeData;

  /// create BrnBigMainButton
  const BrnBigMainButton({
    Key? key,
    this.title,
    this.width,
    this.isEnable = true,
    this.onTap,
    this.themeData,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BrnButtonConfig defaultThemeConfig = themeData ?? BrnButtonConfig();

    defaultThemeConfig = BrnThemeConfigurator.instance
        .getConfig(configId: defaultThemeConfig.configId)
        .buttonConfig.merge(defaultThemeConfig);

    return BrnNormalButton(
      constraints: BoxConstraints.tightFor(
          width: width ?? double.infinity,
          height: defaultThemeConfig.bigButtonHeight),
      alignment: Alignment.center,
      isEnable: isEnable,
      text: title ?? BrnIntl.of(context).localizedResource.confirm,
      borderRadius: BorderRadius.all(Radius.circular(defaultThemeConfig.bigButtonRadius)),
      fontSize: defaultThemeConfig.bigButtonFontSize,
      backgroundColor: bgColor ?? defaultThemeConfig.commonConfig.brandPrimary,
      disableBackgroundColor: Color(0xFFCCCCCC),
      onTap: onTap,
      textColor: Colors.white,
      disableTextColor:
          defaultThemeConfig.commonConfig.colorTextBaseInverse.withOpacity(0.7),
    );
  }
}
