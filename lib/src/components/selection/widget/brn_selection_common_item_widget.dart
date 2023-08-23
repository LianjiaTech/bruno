import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:bruno/src/utils/css/brn_css_2_text.dart';
import 'package:flutter/material.dart';

/// [BrnSelectionSingleListWidget] 子组件中的单项
class BrnSelectionCommonItemWidget extends StatelessWidget {

  /// 单项数据
  final BrnSelectionEntity item;

  /// 背景色
  final Color? backgroundColor;

  /// 选中项背景色
  final Color? selectedBackgroundColor;

  /// 是否当前焦点
  final bool isCurrentFocused;

  /// 是否是第一级
  final bool isFirstLevel;

  /// 是否是多选列表类型
  final bool isMoreSelectionListType;

  /// 单选回调
  final ValueChanged<BrnSelectionEntity>? itemSelectFunction;

  /// 主题配置
  final BrnSelectionConfig? themeData;

  BrnSelectionCommonItemWidget({
    Key? key,
    required this.item,
    this.backgroundColor,
    this.isFirstLevel = false,
    this.isMoreSelectionListType = false,
    this.itemSelectFunction,
    this.selectedBackgroundColor,
    this.isCurrentFocused = false,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Container checkbox;
    if (!item.isUnLimit() && (item.children.isEmpty)) {
      if (item.isInLastLevel() && item.hasCheckBoxBrother()) {
        checkbox = Container(
          padding: EdgeInsets.only(left: 6),
          width: 21,
          child: (item.isSelected)
              ? BrunoTools.getAssetImageWithBandColor(
                  BrnAsset.iconMultiSelected)
              : BrunoTools.getAssetImage(BrnAsset.iconUnSelect),
        );
      } else {
        checkbox = Container();
      }
    } else {
      checkbox = Container();
    }

    return GestureDetector(
      onTap: () {
        if (itemSelectFunction != null) {
          itemSelectFunction!(item);
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        color: getItemBGColor(),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Expanded(
                      child: Text(
                        item.title + getSelectedItemCount(item),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: getItemTextStyle(),
                      ),
                    ),
                  ),
                  checkbox
                ],
              ),
              Visibility(
                visible: !BrunoTools.isEmpty(item.subTitle),
                child: Padding(
                  padding:
                      EdgeInsets.only(right: item.isInLastLevel() ? 21 : 0),
                  child: BrnCSS2Text.toTextView(item.subTitle ?? '',
                      defaultStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          color: themeData?.commonConfig.colorTextSecondary),
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 获取当前节点的背景色
  Color? getItemBGColor() {
    if (isCurrentFocused) {
      return this.selectedBackgroundColor;
    } else {
      return this.backgroundColor;
    }
  }

  /// 是否高亮
  bool isHighLight(BrnSelectionEntity item) {
    if (item.isInLastLevel()) {
      if (item.isUnLimit()) {
        return isCurrentFocused;
      } else {
        return item.isSelected;
      }
    } else {
      return isCurrentFocused;
    }
  }

  /// 是否加粗
  bool isBold(BrnSelectionEntity item) {
    if (isHighLight(item)) {
      return true;
    } else {
      return item.hasCheckBoxBrother() && item.selectedList().isNotEmpty;
    }
  }

  /// 获取当前节点的文本样式
  TextStyle? getItemTextStyle() {
    if (isHighLight(item)) {
      return themeData?.itemSelectedTextStyle.generateTextStyle();
    } else if (isBold(item)) {
      return themeData?.itemBoldTextStyle.generateTextStyle();
    }
    return themeData?.itemNormalTextStyle.generateTextStyle();
  }

  /// 获取当前节点的子节点中，选中的数量
  String getSelectedItemCount(BrnSelectionEntity item) {
    String itemCount = "";
    if ((BrnSelectionUtil.getTotalLevel(item) < 3 || !isFirstLevel) &&
        item.children.isNotEmpty) {
      int count =
          item.children.where((f) => f.isSelected && !f.isUnLimit()).length;
      if (count > 1) {
        return '($count)';
      } else if (count == 1 && item.hasCheckBoxBrother()) {
        return '($count)';
      } else {
        var unLimited =
            item.children.where((f) => f.isSelected && f.isUnLimit()).toList();
        if (unLimited.isNotEmpty) {
          return '(全部)';
        }
      }
    }
    return itemCount;
  }
}
