import 'package:bruno/src/components/picker/time_picker/brn_date_time_formatter.dart';
import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/components/toast/brn_toast.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// /// /// /// /// /// /// /// /// /
/// 描述: 多选 tag 组件
/// /// /// /// /// /// /// /// /// /
class BrnSelectionRangeTagWidget extends StatefulWidget {
  /// tag 显示的文本
  @required
  final List<BrnSelectionEntity> tagFilterList;

  /// 初始选中的 Index 列表
  final List<bool>? initSelectStatus;

  /// 选择tag的回调
  final void Function(int, bool)? onSelect;

  /// tag 之间的间距
  final double spacing;

  /// tag 之间的垂直间距
  final double verticalSpacing;

  /// tag 的宽度
  final int tagWidth;

  /// tag 的高度
  final double tagHeight;

  /// 初始选择的焦点位置
  final int initFocusedIndex;

  /// 主题配置
  final BrnSelectionConfig themeData;

  BrnSelectionRangeTagWidget(
      {Key? key,
      required this.tagFilterList,
      this.initSelectStatus,
      this.onSelect,
      this.spacing = 12,
      this.verticalSpacing = 10,
      this.tagWidth = 75,
      this.tagHeight = 34,
      required this.themeData,
      this.initFocusedIndex = -1})
      : super(key: key);

  @override
  _BrnSelectionRangeTagWidgetState createState() =>
      _BrnSelectionRangeTagWidgetState();
}

class _BrnSelectionRangeTagWidgetState
    extends State<BrnSelectionRangeTagWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: widget.verticalSpacing,
      spacing: widget.spacing,
      children: _tagWidgetList(context),
    );
  }

  List<Widget> _tagWidgetList(context) {
    List<Widget> list = [];
    for (int nameIndex = 0;
        nameIndex < widget.tagFilterList.length;
        nameIndex++) {
      Widget tagWidget = _tagWidgetAtIndex(nameIndex);
      GestureDetector gdt = GestureDetector(
          child: tagWidget,
          onTap: () {
            var selectedEntity = widget.tagFilterList[nameIndex];
            if (BrnSelectionFilterType.checkbox == selectedEntity.filterType &&
                !selectedEntity.isSelected) {
              if (!BrnSelectionUtil.checkMaxSelectionCount(selectedEntity)) {
                BrnToast.show(BrnIntl.of(context).localizedResource.filterConditionCountLimited, context);
                return;
              }
            }
            BrnSelectionUtil.processBrotherItemSelectStatus(selectedEntity);
            if (null != widget.onSelect) {
              widget.onSelect!(nameIndex, selectedEntity.isSelected);
            }
            setState(() {});
          });
      list.add(gdt);
    }
    return list;
  }

  Widget _tagWidgetAtIndex(int nameIndex) {
    bool selected = widget.tagFilterList[nameIndex].isSelected ||
        nameIndex == widget.initFocusedIndex;
    String text = widget.tagFilterList[nameIndex].title;
    if (widget.tagFilterList[nameIndex].filterType ==
            BrnSelectionFilterType.date &&
        !BrunoTools.isEmpty(widget.tagFilterList[nameIndex].value)) {
      if (int.tryParse(widget.tagFilterList[nameIndex].value ?? '') != null) {
        DateTime? dateTime = DateTimeFormatter.convertIntValueToDateTime(
            widget.tagFilterList[nameIndex].value);
        if (dateTime != null) {
          text = DateTimeFormatter.formatDate(
              dateTime, BrnIntl.of(context).localizedResource.dateFormatYYYYMMDD);
        }
      } else {
        text = widget.tagFilterList[nameIndex].value ?? '';
      }
    }

    Text tx =
        Text(text, style: selected ? _selectedTextStyle() : _tagTextStyle());
    Container tagItem = Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: selected
              ? widget.themeData.tagSelectedBackgroundColor
              : widget.themeData.tagNormalBackgroundColor,
          borderRadius: BorderRadius.circular(widget.themeData.tagRadius)),
      width: widget.tagWidth.toDouble(),
      height: widget.tagHeight,
      child: tx,
    );
    return tagItem;
  }

  TextStyle _tagTextStyle() {
    return widget.themeData.tagNormalTextStyle.generateTextStyle();
  }

  TextStyle _selectedTextStyle() {
    return widget.themeData.tagSelectedTextStyle.generateTextStyle();
  }
}
