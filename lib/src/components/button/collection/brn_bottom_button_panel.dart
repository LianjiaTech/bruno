

import 'package:bruno/src/components/button/brn_vertical_icon_button.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';

/// 用于页面底部的组合按钮，由固定的一个主按钮（主题色按钮）、最多一个次按钮、数量不定的图标按钮组成。
///
/// 布局规则：
///     主按钮 [mainButtonName] 必须存在
///     主按钮和次按钮的宽度大小是 不固定的，随着icon按钮的多少而变化
///
/// 布局步骤（从左至右）：
///     第一步：摆放icon按钮，如果[iconButtonList]为null，那么表示没有icon按钮。可用空间为 父节点分配。
///
///     第二步：摆放次按钮，如果[secondaryButtonName]为null，那么表示没有次按钮。可用空间为 父节点分配-icon按钮的空间
///            如果没有icon按钮，那么可用空间为 父节点分的配空间
///
///     第三步：摆放主按钮，可用空间为 父节点分配空间分配完第一步和第二步的剩余空间
///
///            如果只有一个主按钮，那么主按钮的宽度是 可用空间的最大宽度
///            如果存在次按钮，那么两个按钮平分 可用的最大宽度
///            如果存在次按钮和icon按钮，那么主按钮占满 剩余空间
///
/// 组合按钮有一个白色的背景，并且存在一个右20, 左8, 底18, 上16的内边距，因此开发者不需要关注安全区域
///
/// ```dart
///   BrnBottomButtonPanel(
///      mainButtonName: '主按钮',
///      mainButtonOnTap: () {
///          BrnToast.show('主按钮', context);
///      },
///   )
///
///   BrnBottomButtonPanel(
///      mainButtonName: '主按钮',
///      secondaryButtonName: '次按钮',
///      mainButtonOnTap: () {
///          BrnToast.show('主按钮', context);
///      },
///      secondaryButtonOnTap: () {
///          BrnToast.show('次按钮', context);
///      },
///      iconButtonList: [
///          BrnVerticalIconButton(
///             name: '写备注',
///             iconWidget: Icon(Icons.add),
///          ),
///      ],
///   )
///
///
/// ```
///
/// 相关按钮如下:
///  * [BrnButtonPanel], 小主次按钮组成的横向面板
///  * [BrnMultipleBottomButton], 具备编辑选择状态的底部操作按钮
///  * [BrnTextButtonPanel], 平分可用空间的文本按钮面板
///  * [BrnVerticalIconButton], 小主次按钮组成的横向面板
///
class BrnBottomButtonPanel extends StatelessWidget {
  /// 主按钮的文案
  final String mainButtonName;

  /// 主按钮点击的回调
  final VoidCallback mainButtonOnTap;

  /// 次按钮的文案
  final String? secondaryButtonName;

  /// 次按钮的点击回调
  final VoidCallback? secondaryButtonOnTap;

  /// icon按钮的集合
  final List<BrnVerticalIconButton>? iconButtonList;

  /// 主按钮是否可用 默认可用
  /// 如果设置为false，按钮置灰且不响应[mainButtonOnTap]
  final bool enableMainButton;

  /// 次按钮是否可用 默认可用
  /// 如果设置为false，按钮置灰且不响应[secondaryButtonName]
  final bool enableSecondaryButton;

  const BrnBottomButtonPanel(
      {Key? key,
      required this.mainButtonName,
      required this.mainButtonOnTap,
      this.secondaryButtonName,
      this.secondaryButtonOnTap,
      this.enableMainButton = true,
      this.enableSecondaryButton = true,
      this.iconButtonList})
      : super(key: key);

  /// 新增快捷的数组使用方式
  /// 注意事项：由于该只支持主按钮和次按钮，因此如果数组长度大于2，也只会取出来第一个和第二个显示
  ///         如果数组的长度是1，那么只显示主按钮
  ///         如果数组的长度是0，那么不显示
  ///         数组的第1个是 主按钮
  ///         数组的第2个是 次按钮
  /// buttonTitleList 数组显示文案
  /// mainButtonOnTap 主按钮的点击事件
  /// secondaryButtonOnTap 次按钮的点击事件
  /// iconButtonList icon按钮
  static Widget createByList(List<String> buttonTitleList,
      {VoidCallback? mainButtonOnTap,
      VoidCallback? secondaryButtonOnTap,
      bool enableMainButton = true,
      List<BrnVerticalIconButton>? iconButtonList}) {
    if ((buttonTitleList.isEmpty) && iconButtonList == null) {
      return SizedBox.shrink();
    }
    if (buttonTitleList.length >= 2) {
      return BrnBottomButtonPanel(
        mainButtonName: buttonTitleList[0],
        enableMainButton: enableMainButton,
        secondaryButtonName: buttonTitleList[1],
        mainButtonOnTap: () {
          if (mainButtonOnTap != null && enableMainButton) {
            mainButtonOnTap();
          }
        },
        secondaryButtonOnTap: () {
          if (secondaryButtonOnTap != null) {
            secondaryButtonOnTap();
          }
        },
        iconButtonList: iconButtonList,
      );
    }

    if (buttonTitleList.length == 1) {
      return BrnBottomButtonPanel(
        mainButtonName: buttonTitleList[0],
        enableMainButton: enableMainButton,
        mainButtonOnTap: () {
          if (mainButtonOnTap != null && enableMainButton) {
            mainButtonOnTap();
          }
        },
        iconButtonList: iconButtonList,
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = <Widget>[];
    if (null != iconButtonList) {
      Widget iconListWidget = _iconWidgetListWidget();
      rowChildren.add(iconListWidget);
    }

    Widget btnListWidget = _buttonListWidget();
    rowChildren.add(btnListWidget);

    return Container(
      padding: EdgeInsets.only(right: 20, left: 8, bottom: 18, top: 16),
      color: Colors.white,
      child: Row(
        children: rowChildren,
      ),
    );
  }

  Widget _buttonListWidget() {
    List<Widget> btnList = <Widget>[];
    Widget mBtn = _mainButtonWidget();
    btnList.add(mBtn);
    if (secondaryButtonName != null) {
      Widget sBtn = _secondaryWidget();
      btnList.add(sBtn);
    }

    return Expanded(
      child: Row(
        children: btnList.reversed.toList(),
      ),
    );
  }

  Widget _iconWidgetListWidget() {
    List<Widget> finalIconList = iconButtonList!.map((wdt) {
      return Padding(padding: EdgeInsets.only(left: 0), child: wdt);
    }).toList();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: finalIconList.reversed.toList(),
    );
  }

  Widget _secondaryWidget() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: _isEmptyIcon() ? 12 : 8),
        child: GestureDetector(
          onTap: () {
            if (secondaryButtonOnTap != null && enableSecondaryButton) {
              secondaryButtonOnTap!();
            }
          },
          child: Container(
              height: 48,
              padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
              decoration: BoxDecoration(
                color: enableSecondaryButton
                    ? BrnThemeConfigurator.instance
                        .getConfig()
                        .commonConfig
                        .brandAuxiliary
                    : Color(0xFFCCCCCC),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Center(
                child: Text(
                  secondaryButtonName ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: enableSecondaryButton
                        ? Colors.white
                        : BrnThemeConfigurator.instance
                            .getConfig()
                            .commonConfig.colorTextBaseInverse.withOpacity(0.7),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget _mainButtonWidget() {
    Widget mainWidget = GestureDetector(
      onTap: () {
        if (enableMainButton) {
          mainButtonOnTap();
        }
      },
      child: Container(
          height: 48,
          padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
          decoration: BoxDecoration(
            color: enableMainButton
                ? BrnThemeConfigurator.instance
                    .getConfig()
                    .commonConfig
                    .brandPrimary
                : Color(0xFFCCCCCC),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Center(
            child: Text(
              mainButtonName,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: enableMainButton
                    ? Colors.white
                    : BrnThemeConfigurator.instance
                        .getConfig()
                        .commonConfig.colorTextBaseInverse.withOpacity(0.7),
              ),
            ),
          )),
    );

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
            left: (_isEmptyIcon() && _isEmptySecondary()) ? 12 : 8),
        child: mainWidget,
      ),
    );
  }

  bool _isEmptyIcon() {
    return iconButtonList == null || iconButtonList!.isEmpty;
  }

  bool _isEmptySecondary() {
    return secondaryButtonName == null;
  }
}
