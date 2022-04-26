import 'package:bruno/src/components/picker/multi_range_picker/bean/brn_multi_column_picker_entity.dart';
import 'package:bruno/src/components/picker/multi_range_picker/brn_multi_column_picker_util.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

class BrnMultiRangePickerCommonItem extends StatelessWidget {
  final BrnPickerEntity item;
  final Color normalColor;
  final Color selectColor;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final bool? isCurrentFocused;
  final bool isFirstLevel;

  final bool isMoreSelectionListType;

  final ValueChanged<BrnPickerEntity>? itemSelectFunction;

  BrnMultiRangePickerCommonItem({
    required this.item,
    this.normalColor = const Color(0Xff4a4e59),
    this.selectColor = const Color(0xff41bc6a),
    this.backgroundColor,
    this.isFirstLevel = false,
    this.isMoreSelectionListType = false,
    this.itemSelectFunction,
    this.selectedBackgroundColor,
    this.isCurrentFocused,
  });

  @override
  Widget build(BuildContext context) {
    Container checkbox;
    if (!item.isUnLimit() && (item.children.isEmpty)) {
      if (item.isInLastLevel() && _hasCheckBoxBrother(item)) {
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
        height: 40,
        padding: EdgeInsets.only(left: 20, right: 20),
        color: _getItemBGColor(),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Container(
                  child: Expanded(
                child: Text(
                  item.name + _getSelectedItemCount(item),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: _getItemFontWeight(),
                      decoration: TextDecoration.none,
                      color: _getItemTextColor()),
                ),
              )),
              checkbox
            ],
          ),
        ),
      ),
    );
  }

  Color? _getItemBGColor() {
    if (isCurrentFocused!) {
      return this.selectedBackgroundColor;
    } else {
      return this.backgroundColor;
    }
  }

  Color _getItemTextColor() {
    Color itemColor = (item.isUnLimit() ? isCurrentFocused : item.isSelected)!
        ? selectColor
        : normalColor;
    if (!item.isInLastLevel()) {
      itemColor = isCurrentFocused! ? selectColor : normalColor;
    }
    return itemColor;
  }

  FontWeight _getItemFontWeight() {
    FontWeight fontWeight =
        (item.isUnLimit() ? isCurrentFocused : item.isSelected)!
            ? FontWeight.w600
            : FontWeight.normal;

    if (!item.isInLastLevel()) {
      fontWeight = isCurrentFocused! ? FontWeight.w600 : FontWeight.normal;
    }
    return fontWeight;
  }

  String _getSelectedItemCount(BrnPickerEntity item) {
    String itemCount = "";
    if ((BrnMultiColumnPickerUtil.getTotalColumnCount(item) < 3 ||
        !isFirstLevel)) {
      int count =
          item.children.where((f) => f.isSelected && !f.isUnLimit()).length;
      if (count > 1) {
        return '($count)';
      }
    }
    return itemCount;
  }

  bool _hasCheckBoxBrother(BrnPickerEntity item) {
    int? count;
    if (item.parent != null) {
      count = item.parent!.children
          .where((f) => f.filterType == PickerFilterType.checkbox)
          .length;
    }
    return count == null ? false : count > 0;
  }
}
