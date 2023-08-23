import 'package:bruno/src/components/picker/base/brn_picker_title_config.dart';
import 'package:bruno/src/components/picker/time_picker/brn_date_time_formatter.dart';
import 'package:bruno/src/components/picker/time_picker/date_picker/brn_date_widget.dart';
import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/controller/brn_selection_view_date_picker_controller.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_datepicker_animate_widget.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String _defaultDateFormat = 'yyyy年MM月dd日';

/// 日期范围选择，筛选组件的子组件
// ignore: must_be_immutable
class BrnSelectionDateRangeItemWidget extends StatefulWidget {

  /// 筛选数据
  final BrnSelectionEntity item;

  /// 输入框显示文字大小
  final double showTextSize;

  /// 是否需要标题
  final bool isNeedTitle;

  /// 日期格式
  final String dateFormat;

  /// 最小日期输入框控制器
  final TextEditingController minTextEditingController;

  /// 最大日期输入框控制器
  final TextEditingController maxTextEditingController;

  /// 选择日期时的点击事件
  final VoidCallback? onTapped;

  /// 主题配置
  BrnSelectionConfig themeData;

  BrnSelectionDateRangeItemWidget(
      {Key? key,
      required this.item,
      required this.minTextEditingController,
      required this.maxTextEditingController,
      this.isNeedTitle = true,
      this.showTextSize = 16,
      this.dateFormat = _defaultDateFormat,
      this.onTapped,
      required this.themeData})
      : super(key: key);

  _BrnSelectionDateRangeItemWidgetState createState() =>
      _BrnSelectionDateRangeItemWidgetState();
}

class _BrnSelectionDateRangeItemWidgetState
    extends State<BrnSelectionDateRangeItemWidget> {
  BrnSelectionDatePickerController _datePickerController =
      BrnSelectionDatePickerController();

  @override
  void initState() {
    DateTime? minDateTime;
    if (widget.item.customMap != null &&
        widget.item.customMap!['min'] != null) {
      minDateTime = DateTimeFormatter.convertIntValueToDateTime(
          widget.item.customMap!['min']);
    }
    DateTime? maxDateTime;
    if (widget.item.customMap != null &&
        widget.item.customMap!['max'] != null) {
      maxDateTime = DateTimeFormatter.convertIntValueToDateTime(
          widget.item.customMap!['max']);
    }
    widget.minTextEditingController.text = minDateTime != null
        ? DateTimeFormatter.formatDate(
            minDateTime, widget.dateFormat)
        : '';
    widget.maxTextEditingController.text = maxDateTime != null
        ? DateTimeFormatter.formatDate(
            maxDateTime, widget.dateFormat)
        : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            widget.isNeedTitle
                ? Container(
                    margin: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.item.title.isEmpty ? BrnIntl.of(context).localizedResource.customRange : widget.item.title,
                      textAlign: TextAlign.left,
                      style: widget.themeData.rangeTitleTextStyle
                          .generateTextStyle(),
                    ),
                  )
                : Container(),
            Row(
              children: <Widget>[
                getDateRangeTextField(false),
                Container(
                  child: Text(
                    BrnIntl.of(context).localizedResource.to,
                    style: widget.themeData.inputTextStyle.generateTextStyle(),
                  ),
                ),
                getDateRangeTextField(true),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getDateRangeTextField(bool isMax) {
    return Expanded(
      child: TextField(
        enableInteractiveSelection: false,
        readOnly: true,
        onTap: () {
          if (widget.onTapped != null) {
            widget.onTapped!();
          }
          onTextTapped(isMax);
        },
        style: widget.themeData.inputTextStyle.generateTextStyle(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        onChanged: (input) {
          widget.item.isSelected = true;
        },
        controller: isMax
            ? widget.maxTextEditingController
            : widget.minTextEditingController,
        cursorColor: widget.themeData.commonConfig.brandPrimary,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintStyle: widget.themeData.hintTextStyle.generateTextStyle(),
          hintText: (!isMax ? BrnIntl.of(context).localizedResource.startDate : BrnIntl.of(context).localizedResource.endDate),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: widget.themeData.commonConfig.borderColorBase,
          )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: widget.themeData.commonConfig.borderColorBase,
          )),
          contentPadding: EdgeInsets.all(0),
        ),
      ),
    );
  }

  void onTextTapped(bool isMax) {
    if (_datePickerController.isShow) return;
    String format = 'yyyy年,MM月,dd日';
    DateTime? minDate = DateTimeFormatter.convertIntValueToDateTime(
        (widget.item.extMap)['min']);
    DateTime? maxDate = DateTimeFormatter.convertIntValueToDateTime(
        (widget.item.extMap)['max']);

    DateTime? minSelectedDateTime = BrunoTools.isEmpty(widget.item.customMap)
        ? null
        : DateTimeFormatter.convertIntValueToDateTime(
            widget.item.customMap!['min']);
    DateTime? maxSelectedDateTime = BrunoTools.isEmpty(widget.item.customMap)
        ? null
        : DateTimeFormatter.convertIntValueToDateTime(
            widget.item.customMap!['max']);

    DateTime? _minDateTime;
    DateTime? _maxDateTime;
    if (widget.item.customMap == null ||
        (widget.item.customMap!['min'] == null &&
            widget.item.customMap!['max'] == null)) {
      // 如果开始时间和结束时间均未选择
      _minDateTime = minDate;
      _maxDateTime = maxDate;
    } else {
      _minDateTime = !isMax ? minDate : (minSelectedDateTime ?? minDate);
      _maxDateTime = isMax ? maxDate : (maxSelectedDateTime ?? maxDate);
    }

    Widget content = BrnDateWidget(
      canPop: false,
      minDateTime: _minDateTime,
      maxDateTime: _maxDateTime,
      initialDateTime: isMax ? maxSelectedDateTime : minSelectedDateTime,
      dateFormat: format,
      pickerTitleConfig: BrnPickerTitleConfig(
          showTitle: true,
          // UI 规范规定高度按照比例设置，UI稿的比利为 240 / 812
          titleContent: isMax ? BrnIntl.of(context).localizedResource.selectEndDate : BrnIntl.of(context).localizedResource.selectStartDate),
      onCancel: () {
        closeSelectionPopupWindow();
      },
      onConfirm: (DateTime selectedDate, List<int> selectedIndex) {
        widget.item.isSelected = true;
        String selectedDateStr = DateTimeFormatter.formatDate(
            selectedDate, widget.dateFormat);
        if (isMax) {
          widget.maxTextEditingController.text = selectedDateStr;
        } else {
          widget.minTextEditingController.text = selectedDateStr;
        }
        if (widget.item.customMap == null) {
          widget.item.customMap = Map();
        }
        widget.item.customMap![isMax ? 'max' : 'min'] =
            selectedDate.millisecondsSinceEpoch.toString();
        closeSelectionPopupWindow();

        if (!isMax &&
            BrunoTools.isEmpty(widget.maxTextEditingController.text)) {
          onTextTapped(true);
        }
        setState(() {});
      },
    );
    OverlayEntry entry = _createDatePickerEntry(context, content);
    Overlay.of(context).insert(entry);
    _datePickerController.entry = entry;
    _datePickerController.show();
  }

  OverlayEntry _createDatePickerEntry(BuildContext context, Widget content) {
    return OverlayEntry(builder: (context) {
      return GestureDetector(
        onTap: () {
          closeSelectionPopupWindow();
        },
        child: Container(
          color: Color(0xB3000000),
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.bottomCenter,
          child: BrnSelectionDatePickerAnimationWidget(
              controller: _datePickerController, view: content),
        ),
      );
    });
  }

  /// 关闭选择弹窗
  void closeSelectionPopupWindow() {
    if (_datePickerController.isShow) {
      _datePickerController.hide();
    }
  }

  @override
  void dispose() {
    _datePickerController.hide();
    super.dispose();
  }
}
