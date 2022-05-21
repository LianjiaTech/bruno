import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_card_title_config.dart';
import 'package:flutter/material.dart';

/// 卡片标题组件面板
///
/// 组合多个标题组件
/// BrnCardTitlePanel(
///   children: [
///     BrnActionCardTitle(
///       title: '箭头标题1',
///       onTap: () {
///         BrnToast.show('BrnActionCardTitle1 is clicked', context);
///       },
///     ),
///     BrnActionCardTitle(
///       title: '箭头标题2',
///       onTap: () {
///         BrnToast.show('BrnActionCardTitle2 is clicked', context);
///       },
///     ),
///   ],
/// ),
///
/// 相关按钮如下:
///  * [BrnActionCardTitle], 右侧为箭头的卡片标题组件
///  * [BrnCommonCardTitle], 普通卡片标题组件
///
class BrnCardTitlePanel extends StatelessWidget {
  ///标题右侧的显示widget
  final List<Widget> children;

  final BrnCardTitleConfig? themeData;

  BrnCardTitlePanel({
    Key? key,
    required this.children,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BrnCardTitleConfig defaultConfig = themeData ?? BrnCardTitleConfig();
    defaultConfig = BrnThemeConfigurator.instance
        .getConfig(configId: defaultConfig.configId)
        .cardTitleConfig
        .merge(defaultConfig);
    if (children.isNotEmpty) {
      List<Widget> acc = [];
      children.fold(acc, (previousValue, element) {
        if (acc.length % 2 == 1) {
          acc.add(Divider(
            indent: 2,
            endIndent: 2,
            height: 1,
            color: Color(0xFFECECEC),
          ));
        }
        acc.add(element);
      });
      return Container(
        padding: defaultConfig.cardTitlePanelPadding,
        decoration: BoxDecoration(
          color: defaultConfig.cardBackgroundColor,
          borderRadius:
              BorderRadius.circular(defaultConfig.cardTitlePanelRadius),
        ),
        child: Column(
          children: acc,
        ),
      );
    }
    return SizedBox.shrink();
  }
}
