import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:bruno/src/utils/css/brn_css_2_text.dart';
import 'package:flutter/material.dart';

typedef void ItemSelectFunction(BrnSelectionEntity entity);

class BrnSelectionCommonItemWidget extends StatelessWidget {
  final BrnSelectionEntity item;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final bool isCurrentFocused;
  final bool isFirstLevel;
  final bool isMoreSelectionListType;

  final ItemSelectFunction? itemSelectFunction;

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
    var checkbox;
    if (!item.isUnLimit() && (item.children.length == 0)) {
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

  Color? getItemBGColor() {
    if (isCurrentFocused) {
      return this.selectedBackgroundColor;
    } else {
      return this.backgroundColor;
    }
  }

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

  bool isBold(BrnSelectionEntity item) {
    if (isHighLight(item)) {
      return true;
    } else {
      return item.hasCheckBoxBrother() && item.selectedList().length > 0;
    }
  }

  TextStyle? getItemTextStyle() {
    if (isHighLight(item)) {
      return themeData?.itemSelectedTextStyle.generateTextStyle();
    } else if (isBold(item)) {
      return themeData?.itemBoldTextStyle.generateTextStyle();
    }
    return themeData?.itemNormalTextStyle.generateTextStyle();
  }

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
        if (unLimited.length > 0) {
          return '(全部)';
        }
      }
    }
    return itemCount;
  }
}
