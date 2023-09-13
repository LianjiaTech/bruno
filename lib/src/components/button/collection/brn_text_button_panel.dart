import 'package:bruno/src/components/popup/brn_popup_window.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/utils/brn_multi_click_util.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 多个文字按钮组成的按钮集合
/// 展示规则：
///
///  * 文本平分屏幕
///  * 文本数目不超过4个时，文本平分屏幕
///  * 文本数目超过4个时，展示3个文本按钮和更多

class BrnTextButtonPanel extends StatefulWidget {
  /// 操作文字列表
  final List<String> nameList;

  /// 点击某个文本按钮的回调
  final void Function(int index)? onTap;

  /// popUpWindow位于targetView的方向
  /// 取[BrnPopupDirection]里面的值
  /// 默认值为PopDirection.bottom
  final BrnPopupDirection popDirection;

  /// create BrnTextButtonPanel
  const BrnTextButtonPanel({
    Key? key,
    required this.nameList,
    this.onTap,
    this.popDirection = BrnPopupDirection.bottom,
  }) : super(key: key);

  @override
  _BrnTextButtonPanelState createState() => _BrnTextButtonPanelState();
}

class _BrnTextButtonPanelState extends State<BrnTextButtonPanel> {
  GlobalKey _popWindowKey = GlobalKey();

  /// 更多按钮的展开收起状态
  bool _isExpanded = false;

  /// 展示的文本按钮的最大数目，超过这个数目时展示更多
  int _maxNum = 4;

  @override
  Widget build(BuildContext context) {
    if (widget.nameList.isNotEmpty) {
      Row row = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _textOperationWidgetList(context).reversed.toList(),
      );
      return Container(color: Colors.white, height: 50, child: row);
    }
    return Container();
  }

  List<Widget> _textOperationWidgetList(context) {
    List<Widget> widgetList = <Widget>[];
    //文本按钮不超过4个，就全不显示
    //超过4个的话，就只显示3个，剩下的显示在更多里
    int length = widget.nameList.length <= _maxNum ? widget.nameList.length : _maxNum - 1;
    for (int textIndex = 0; textIndex < length; textIndex++) {
      Widget operationWidget = _operationWidgetAtIndex(textIndex);
      widgetList.add(operationWidget);
    }

    if (widget.nameList.length > _maxNum) {
      widgetList.add(_moreButton());
    }

    List<Widget> showWidget = [];
    for (int i = 0, n = widgetList.length; i < n; ++i) {
      showWidget.add(Expanded(
        child: widgetList[i],
      ));
      if (i != n - 1) {
        showWidget.add(
          Container(
            alignment: Alignment.center,
            height: 26,
            width: 1,
            color: Color(0xFFf8f8f8),
          ),
        );
      }
    }
    return showWidget;
  }

  Widget _operationWidgetAtIndex(int index) {
    String title = widget.nameList[index];
    Text tx = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary),
    );

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: tx,
        ),
        onTap: () {
          if (BrnMultiClickUtils.isMultiClick()) {
            return;
          }
          if (null != widget.onTap) {
            widget.onTap!(index);
          }
        });
  }

  /// 更多按钮
  Widget _moreButton() {
    if (widget.nameList.length > _maxNum) {
      List<String> list = [];
      for (int i = _maxNum - 1; i < widget.nameList.length; i++) {
        list.add(widget.nameList[i]);
      }

      Text tx = Text(
        _isExpanded ? BrnIntl.of(context).localizedResource.collapse : BrnIntl.of(context).localizedResource.more,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff999999),
        ),
      );

      Widget imageWidget = _isExpanded
          ? BrunoTools.getAssetImage(BrnAsset.iconUpArrow)
          : BrunoTools.getAssetImage(BrnAsset.iconDownArrow);

      return GestureDetector(
          behavior:HitTestBehavior.opaque,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              tx,
              SizedBox(
                width: 4,
              ),
              imageWidget
            ],
          ),
          key: _popWindowKey,
          onTap: () {
            BrnPopupListWindow.showPopListWindow(context, _popWindowKey,
                offset: 10,
                popDirection: widget.popDirection,
                data: list, onItemClick: (index, item) {
              Navigator.pop(context);
              if (widget.onTap != null) {
                widget.onTap!(index + 3);
              }
              return true;
            }, onDismiss: () {
              setState(() {
                _isExpanded = false;
              });
            });
            setState(() {
              _isExpanded = true;
            });
          });
    } else {
      return const SizedBox.shrink();
    }
  }
}
