

import 'dart:math';

import 'package:bruno/src/components/picker/base/brn_picker.dart';
import 'package:bruno/src/components/picker/base/brn_picker_title.dart';
import 'package:bruno/src/components/picker/base/brn_picker_title_config.dart';
import 'package:bruno/src/components/picker/time_picker/brn_date_picker_constants.dart';
import 'package:bruno/src/components/picker/time_picker/date_range_picker/brn_time_range_side_widget.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:bruno/src/utils/i18n/brn_date_picker_i18n.dart';
import 'package:flutter/material.dart';

/// 时间范围选择 TimeRange widget.
// ignore: must_be_immutable
class BrnTimeRangeWidget extends StatefulWidget {
  /// 可选最小时间
  final DateTime? minDateTime;

  /// 可选最大时间
  final DateTime? maxDateTime;

  /// 初始开始选中时间
  final DateTime? initialStartDateTime;

  /// 初始结束选中时间
  final DateTime? initialEndDateTime;

  /// 是否限制 Picker 选择的时间范围（开始时间≤结束时间）
  final isLimitTimeRange;

  /// 时间格式
  final String? dateFormat;
  final DateTimePickerLocale locale;

  /// cancel 回调
  final DateVoidCallback? onCancel;

  /// 选中时间变化时的回调，返回选中的开始、结束时间
  final DateRangeValueCallback? onChange;

  /// 确定回调，返回选中的开始、结束时间
  final DateRangeValueCallback? onConfirm;

  /// Picker title  相关内容配置
  final BrnPickerTitleConfig pickerTitleConfig;

  /// 分钟展示的间隔
  final int minuteDivider;

  /// Picker 主题配置
  BrnPickerConfig? themeData;

  /// 内部变量，记录左右两侧是否触发了滚动
  bool _isFirstScroll = false, _isSecondScroll = false;

  BrnTimeRangeWidget({
    Key? key,
    this.minDateTime,
    this.maxDateTime,
    this.isLimitTimeRange = true,
    this.initialStartDateTime,
    this.initialEndDateTime,
    this.dateFormat: datetimeRangePickerTimeFormat,
    this.locale: datetimePickerLocaleDefault,
    this.pickerTitleConfig: BrnPickerTitleConfig.Default,
    this.minuteDivider = 1,
    this.onCancel,
    this.onChange,
    this.onConfirm,
    this.themeData,
  }) : super(key: key) {
    DateTime minTime = minDateTime ?? DateTime.parse(datePickerMinDatetime);
    DateTime maxTime = maxDateTime ?? DateTime.parse(datePickerMaxDatetime);
    assert(minTime.compareTo(maxTime) < 0);
    this.themeData ??= BrnPickerConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .pickerConfig
        .merge(this.themeData);
  }

  @override
  State<StatefulWidget> createState() => _TimePickerWidgetState(
      this.minDateTime,
      this.maxDateTime,
      this.initialStartDateTime,
      this.initialEndDateTime,
      this.minuteDivider);
}

class _TimePickerWidgetState extends State<BrnTimeRangeWidget> {
  final int _defaultMinuteDivider = 1;

  late int _minuteDivider;
  late DateTime _minTime, _maxTime;
  late int _currStartHour, _currStartMinute;
  late int _currEndHour, _currEndMinute;
  late List<int> _hourRange, _minuteRange;
  late List<int> _startSelectedIndex;
  late List<int> _endSelectedIndex;
  late DateTime _startSelectedDateTime;
  late DateTime _endSelectedDateTime;

  _TimePickerWidgetState(DateTime? minTime, DateTime? maxTime,
      DateTime? initStartTime, DateTime? initEndTime, int minuteDivider) {
    _initData(minTime, maxTime, initStartTime, initEndTime, minuteDivider);
  }

  void _initData(DateTime? minTime, DateTime? maxTime, DateTime? initStartTime,
      DateTime? initEndTime, int? minuteDivider) {
    if (minTime == null) {
      minTime = DateTime.parse(datePickerMinDatetime);
    }
    if (maxTime == null) {
      maxTime = DateTime.parse(datePickerMaxDatetime);
    }
    DateTime now = DateTime.now();
    this._minTime = DateTime(now.year, now.month, now.day, minTime.hour,
        minTime.minute, minTime.second);
    this._maxTime = DateTime(now.year, now.month, now.day, maxTime.hour,
        maxTime.minute, maxTime.second);

    if (initStartTime == null) {
      // init time is now
      initStartTime = DateTime.now();
    }

    if (initEndTime == null) {
      // init time is now
      initEndTime = DateTime.now();
    }

    if (minuteDivider == null || minuteDivider <= 0) {
      this._minuteDivider = _defaultMinuteDivider;
    } else {
      this._minuteDivider = minuteDivider;
    }

    this._currStartHour = initStartTime.hour;
    this._hourRange = _calcHourRange();
    this._currStartHour =
        min(max(_hourRange.first, _currStartHour), _hourRange.last);

    this._currStartMinute = initStartTime.minute;
    this._minuteRange = _calcMinuteRange();
    this._currStartMinute =
        min(max(_minuteRange.first, _currStartMinute), _minuteRange.last);
    _currStartMinute -= _currStartMinute % _minuteDivider;

    this._currEndHour = initEndTime.hour;
    this._currEndHour = min(_currEndHour, _hourRange.last);

    this._currEndMinute = initEndTime.minute;
    this._currEndMinute = min(_currEndMinute, _minuteRange.last);
    _currEndMinute -= _currEndMinute % _minuteDivider;

    _startSelectedDateTime = DateTime(
        now.year, now.month, now.day, _currStartHour, _currStartMinute);
    _endSelectedDateTime =
        DateTime(now.year, now.month, now.day, _currEndHour, _currEndMinute);

    _startSelectedIndex = _calcStartSelectIndexList(_minuteDivider);
    _endSelectedIndex = _calcEndSelectIndexList(_minuteDivider);
  }

  @override
  Widget build(BuildContext context) {
    _initData(_minTime, _maxTime, _startSelectedDateTime, _endSelectedDateTime,
        _minuteDivider);
    return GestureDetector(
      child: Material(
          color: Colors.transparent, child: _renderPickerView(context)),
    );
  }

  /// render time picker widgets
  Widget _renderPickerView(BuildContext context) {
    Widget pickerWidget = _renderDatePickerWidget();

    // display the title widget
    if (widget.pickerTitleConfig.title != null ||
        widget.pickerTitleConfig.showTitle) {
      Widget titleWidget = BrnPickerTitle(
        pickerTitleConfig: widget.pickerTitleConfig,
        locale: widget.locale,
        onCancel: () => _onPressedCancel(),
        onConfirm: () => _onPressedConfirm(),
      );
      return Column(children: <Widget>[titleWidget, pickerWidget]);
    }
    return pickerWidget;
  }

  /// pressed cancel widget
  void _onPressedCancel() {
    if (widget.onCancel != null) {
      widget.onCancel!();
    }
    Navigator.pop(context);
  }

  /// pressed confirm widget
  void _onPressedConfirm() {
    if (widget.onConfirm != null) {
      widget.onConfirm!(_startSelectedDateTime, _endSelectedDateTime,
          _startSelectedIndex, _endSelectedIndex);
    }
    Navigator.pop(context);
  }

  /// render the picker widget of year、month and day
  Widget _renderDatePickerWidget() {
    /// 用于强制刷新 Widget
    var firstGlobalKey;
    var secondGlobalKey;

    if (widget._isFirstScroll) {
      secondGlobalKey = GlobalKey();
      widget._isFirstScroll = false;
    }
    if (widget._isSecondScroll) {
      firstGlobalKey = GlobalKey();
      widget._isSecondScroll = false;
    }

    List<Widget> pickers = [];
    pickers.add(Expanded(
        flex: 6,
        child: Container(
            height: widget.themeData!.pickerHeight,
            color: widget.themeData!.backgroundColor,
            child: BrnTimeRangeSideWidget(
              key: firstGlobalKey,
              dateFormat: widget.dateFormat,
              minDateTime: _minTime,
              maxDateTime: _maxTime,
              initialStartDateTime: _startSelectedDateTime,
              minuteDivider: _minuteDivider,
              onInitSelectChange: (widget.isLimitTimeRange ?? true)
                  ? (DateTime selectedDateTime, List<int> selected) {
                      _startSelectedDateTime = selectedDateTime;
                      _startSelectedIndex = selected;
                    }
                  : null,
              onChange: (DateTime selectedDateTime, List<int> selected) {
                setState(() {
                  _startSelectedDateTime = selectedDateTime;
                  _startSelectedIndex = selected;
                  widget._isFirstScroll = true;
                });
              },
            ))));
    pickers.add(_renderDatePickerMiddleColumnComponent());
    pickers.add(Expanded(
        flex: 6,
        child: Container(
            height: widget.themeData!.pickerHeight,
            color: widget.themeData!.backgroundColor,
            child: BrnTimeRangeSideWidget(
              key: secondGlobalKey,
              dateFormat: widget.dateFormat,
              minDateTime: (widget.isLimitTimeRange ?? true)
                  ? _startSelectedDateTime
                  : _minTime,
              maxDateTime: _maxTime,
              initialStartDateTime: (widget.isLimitTimeRange ?? true)
                  ? _endSelectedDateTime.compareTo(_startSelectedDateTime) > 0
                      ? _endSelectedDateTime
                      : _startSelectedDateTime
                  : _endSelectedDateTime,
              minuteDivider: _minuteDivider,
              onInitSelectChange: (widget.isLimitTimeRange ?? true)
                  ? (DateTime selectedDateTime, List<int> selected) {
                      _endSelectedDateTime = selectedDateTime;
                      _endSelectedIndex = selected;
                    }
                  : null,
              onChange: (DateTime selectedDateTime, List<int> selected) {
                setState(() {
                  _endSelectedDateTime = selectedDateTime;
                  _endSelectedIndex = selected;
                  widget._isSecondScroll = true;
                });
              },
            ))));
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: pickers);
  }

  /// calculate selected index list
  List<int> _calcStartSelectIndexList(int minuteDivider) {
    int hourIndex = _currStartHour - _hourRange.first;
    int minuteIndex = (_currStartMinute - _minuteRange.first) ~/ minuteDivider;
    return [hourIndex, minuteIndex];
  }

  /// calculate selected index list
  List<int> _calcEndSelectIndexList(int minuteDivider) {
    int hourIndex = _currEndHour - _hourRange.first;
    int minuteIndex = (_currEndMinute - _minuteRange.first) ~/ minuteDivider;
    return [hourIndex, minuteIndex];
  }

  /// calculate the range of hour
  List<int> _calcHourRange() {
    return [_minTime.hour, _maxTime.hour];
  }

  /// calculate the range of minute
  List<int> _calcMinuteRange({currHour}) {
    int minMinute = 0, maxMinute = 59;
    int minHour = _minTime.hour;
    int maxHour = _maxTime.hour;
    if (currHour == null) {
      currHour = _currStartHour;
    }

    if (minHour == currHour) {
      // selected minimum hour, limit minute range
      minMinute = _minTime.minute;
    }
    if (maxHour == currHour) {
      // selected maximum hour, limit minute range
      maxMinute = _maxTime.minute;
    }
    return [minMinute, maxMinute];
  }

  Widget _renderDatePickerMiddleColumnComponent() {
    return Expanded(
      flex: 1,
      child: Container(
        height: widget.themeData!.pickerHeight,
        decoration: BoxDecoration(
            border: Border(left: BorderSide.none, right: BorderSide.none),
            color: widget.themeData!.backgroundColor),
        child: BrnPicker.builder(
          backgroundColor: widget.themeData!.backgroundColor,
          lineColor: widget.themeData!.dividerColor,
          itemExtent: widget.themeData!.itemHeight,
          childCount: 1,
          itemBuilder: (context, index) {
            return Container(
              height: widget.themeData!.itemHeight,
              alignment: Alignment.center,
              child: Text(
                "至",
                style: widget.themeData!.itemTextStyle.generateTextStyle(),
              ),
            );
          },
          onSelectedItemChanged: (int value) {},
        ),
      ),
    );
  }
}
