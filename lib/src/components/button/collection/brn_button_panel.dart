import 'package:bruno/src/components/button/brn_small_main_button.dart';
import 'package:bruno/src/components/button/brn_small_outline_button.dart';
import 'package:bruno/src/components/popup/brn_popup_window.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 描述: 主次按钮组成的横向面板
/// 主按钮和边框按钮组成的集合
/// 展示规则：
///
///  * 一个主按钮 和 多个次级按钮
///  * 次按钮不多于两个时，优先显示主按钮，剩下的地方平分给次按钮
///  * 次按钮两个以上时，所有按钮等分，显示更多
///  * 按钮之间的间距是 8

class BrnButtonPanel extends StatefulWidget {
  /// 主按钮的文案
  final String mainButtonName;

  /// 主按钮点击的回调
  final VoidCallback mainButtonOnTap;

  /// 主按enable状态
  /// 默认值为true
  final bool isMainBtnEnable;

  /// 默认状态下，次按钮的文案集合。如果需要改变按钮的可用状态，请使用 [secondaryButtonList] 初始化。
  final List<String>? secondaryButtonNameList;

  /// 包含config状态的次按钮，默认状态的话直接传[secondaryButtonNameList]即可
  final List<BrnButtonPanelConfig>? secondaryButtonList;

  /// 次按钮的点击回调
  final void Function(int)? secondaryButtonOnTap;

  /// 控件的左右的padding
  /// 默认值为20
  final double horizontalPadding;

  /// popUpWindow位于targetView的方向,默认在下面
  final BrnPopupDirection popDirection;

  const BrnButtonPanel(
      {Key? key,
      required this.mainButtonName,
      required this.mainButtonOnTap,
      this.isMainBtnEnable = true,
      this.secondaryButtonNameList,
      this.secondaryButtonOnTap,
      this.secondaryButtonList,
      this.horizontalPadding = 20,
      this.popDirection = BrnPopupDirection.bottom})
      : super(key: key);

  @override
  _BrnButtonPanelState createState() => _BrnButtonPanelState();
}

class _BrnButtonPanelState extends State<BrnButtonPanel> {
  late GlobalKey _popWindowKey;

  List<BrnButtonPanelConfig> _secondaryButtonList = [];

  @override
  void initState() {
    super.initState();
    _popWindowKey = GlobalKey();
    initSecondaryButton();
  }

  @override
  void didUpdateWidget(BrnButtonPanel oldWidget) {
    initSecondaryButton();
    super.didUpdateWidget(oldWidget);
  }

  /// 初始化次按钮列表
  void initSecondaryButton() {
    _secondaryButtonList = [];
    if (widget.secondaryButtonList?.isNotEmpty ?? false) {
      _secondaryButtonList = widget.secondaryButtonList!;
    } else if (widget.secondaryButtonNameList?.isNotEmpty ?? false) {
      widget.secondaryButtonNameList!.forEach((name) {
        _secondaryButtonList
            .add(BrnButtonPanelConfig(name: name, isEnable: true));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = <Widget>[];

    if (_secondaryButtonList.length > 2) {
      //次按钮两个以上特殊处理，所有button等分
      list.add(
        _moreButton(),
      );
      list.add(
        SizedBox(
          width: 20,
        ),
      );
      list.add(Expanded(
        child: _secondaryButton(1),
      ));
      list.add(Expanded(
        child: _secondaryButton(0),
      ));
      list.add(Expanded(
        child: _mainButton(),
      ));
    } else {
      // 次按钮两个以下优先显示主按钮，剩下的地方平分给次按钮
      if (_secondaryButtonList.length == 2) {
        list.add(
          Flexible(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: _secondaryButton(1),
              ),
              Flexible(
                child: _secondaryButton(0),
              ),
            ],
          )),
        );
      } else if (_secondaryButtonList.length == 1) {
        list.add(
          Flexible(child: _secondaryButton(0)),
        );
      }
      //添加主按钮
      list.add(_mainButton());
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
          widget.horizontalPadding, 0, widget.horizontalPadding, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: list,
      ),
    );
  }

  Widget _mainButton() {
    return BrnSmallMainButton(
      title: widget.mainButtonName,
      onTap: widget.mainButtonOnTap,
      isEnable: widget.isMainBtnEnable,
      maxWidth: 132,
    );
  }

  Widget _secondaryButton(int btnIndex) {
    BrnSmallOutlineButton button = BrnSmallOutlineButton(
      title: _secondaryButtonList[btnIndex].name,
      isEnable: _secondaryButtonList[btnIndex].isEnable,
      onTap: () {
        if (widget.secondaryButtonOnTap != null) {
          widget.secondaryButtonOnTap!(btnIndex);
        }
      },
    );
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: button,
    );
  }

  /// 更多按钮
  Widget _moreButton() {
    if (_secondaryButtonList.length > 2) {
      List<String> list = [];
      for (int i = 2; i < _secondaryButtonList.length; i++) {
        list.add(_secondaryButtonList[i].name);
      }

      return GestureDetector(
        child: Container(
          color: Colors.transparent,
          height: 32,
          child: BrunoTools.getAssetImage(BrnAsset.iconMore),
        ),
        key: _popWindowKey,
        onTap: () {
          BrnPopupListWindow.showButtonPanelPopList(context, _popWindowKey,
              data: list,
              itemBuilder: (int index, String item) {
                return Text(item,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: _secondaryButtonList[index + 2].isEnable
                            ? BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase
                            : BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextHint,
                        fontSize: 16));
              },
              popDirection: widget.popDirection,
              onItemClick: (index, item) {
                // 按钮不可用的时候，点击无响应；
                if (widget.secondaryButtonOnTap != null) {
                  if (_secondaryButtonList[index + 2].isEnable) {
                    widget.secondaryButtonOnTap!(index + 2);
                    return false;
                  } else {
                    return true;
                  }
                }
                return false;
              });
        },
      );
    } else {
      return Container();
    }
  }
}

/// 次按钮的配置类
class BrnButtonPanelConfig {
  /// 次按钮的名称
  final String name;

  /// 次按钮的enable状态，默认为true
  final bool isEnable;

  BrnButtonPanelConfig({
    required this.name,
    this.isEnable = true,
  });
}
