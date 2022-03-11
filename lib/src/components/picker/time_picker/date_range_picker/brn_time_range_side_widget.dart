

import 'dart:math';

import 'package:bruno/src/components/picker/base/brn_picker.dart';
import 'package:bruno/src/components/picker/time_picker/brn_date_picker_constants.dart';
import 'package:bruno/src/components/picker/time_picker/brn_date_time_formatter.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:bruno/src/utils/i18n/brn_date_picker_i18n.dart';
import 'package:flutter/material.dart';

/// TimeRangeSidePicker widget.

// ignore: must_be_immutable
class BrnTimeRangeSideWidget extends StatefulWidget {
  /// 可选最小时间
  final DateTime? minDateTime;

  /// 可选最大时间
  final DateTime? maxDateTime;

  /// 初始开始选中时间
  final DateTime? initialStartDateTime;

  /// 时间展示格式
  final String? dateFormat;
  final DateTimePickerLocale locale;

  /// 时间选择变化时回调
  final DateRangeSideValueCallback? onChange;

  /// 分钟的展示间隔
  final int? minuteDivider;

  /// 当前默认选择的时间变化时对外部回调，外部监听该事件同步修改默认初始选中的时间
  final DateRangeSideValueCallback? onInitSelectChange;

  /// 主题定制
  BrnPickerConfig? themeData;

  BrnTimeRangeSideWidget({
    Key? key,
    this.minDateTime,
    this.maxDateTime,
    this.initialStartDateTime,
    this.dateFormat: datetimeRangePickerTimeFormat,
    this.locale: datetimePickerLocaleDefault,
    this.minuteDivider = 1,
    this.onChange,
    this.onInitSelectChange,
  }) : super(key: key) {
    DateTime minTime = minDateTime ?? DateTime.parse(datePickerMinDatetime);
    DateTime maxTime = maxDateTime ?? DateTime.parse(datePickerMaxDatetime);
    assert(minTime.compareTo(maxTime) <= 0);
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
      this.minuteDivider,
      this.onInitSelectChange);
}

class _TimePickerWidgetState extends State<BrnTimeRangeSideWidget> {
  final int _defaultMinuteDivider = 1;

  late DateTime _minTime, _maxTime;
  late int _currStartHour, _currStartMinute;
  late int _minuteDivider;
  late List<int> _hourRange, _minuteRange;
  late FixedExtentScrollController _startHourScrollCtrl, _startMinuteScrollCtrl;

  late Map<String, FixedExtentScrollController> _startScrollCtrlMap;
  late Map<String, List<int>> _valueRangeMap;

  bool _isChangeTimeRange = false;

  bool _scrolledNotMinute = false;

  DateRangeSideValueCallback? _onInitSelectChange;

  _TimePickerWidgetState(
      DateTime? minTime,
      DateTime? maxTime,
      DateTime? initStartTime,
      int? minuteDivider,
      DateRangeSideValueCallback? onInitSelectChange) {
    _onInitSelectChange = onInitSelectChange;
    _initData(minTime, maxTime, initStartTime, minuteDivider);
  }

  void _initData(DateTime? minTime, DateTime? maxTime, DateTime? initStartTime,
      int? minuteDivider) {
    if (minTime == null) {
      minTime = DateTime.parse(datePickerMinDatetime);
    }
    if (maxTime == null) {
      maxTime = DateTime.parse(datePickerMaxDatetime);
    }
    this._minTime = minTime;
    this._maxTime = maxTime;

    if (initStartTime == null) {
      // init time is now
      initStartTime = DateTime.now();
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

    _onInitSelectedChange();
    // create scroll controller
    _startHourScrollCtrl = FixedExtentScrollController(
        initialItem: _currStartHour - _hourRange.first);
    _startMinuteScrollCtrl = FixedExtentScrollController(
        initialItem: (_currStartMinute - _minuteRange.first) ~/ _minuteDivider);
    _startScrollCtrlMap = {
      'H': _startHourScrollCtrl,
      'm': _startMinuteScrollCtrl,
    };

    _valueRangeMap = {'H': _hourRange, 'm': _minuteRange};
  }

  @override
  Widget build(BuildContext context) {
    _initData(_minTime, _maxTime, widget.initialStartDateTime, _minuteDivider);
    return GestureDetector(
      child: Container(
          color: widget.themeData!.backgroundColor,
          child: _renderPickerView(context)),
    );
  }

  /// render time picker widgets
  Widget _renderPickerView(BuildContext context) {
    return _renderDatePickerWidget();
  }

  /// notify selected time changed
  void _onInitSelectedChange() {
    if (_onInitSelectChange != null) {
      DateTime now = DateTime.now();
      DateTime startDateTime = DateTime(
          now.year, now.month, now.day, _currStartHour, _currStartMinute);
      _onInitSelectChange!(startDateTime, _calcStartSelectIndexList());
    }
  }

  /// notify selected time changed
  void _onSelectedChange() {
    if (widget.onChange != null) {
      DateTime now = DateTime.now();
      DateTime startDateTime = DateTime(
          now.year, now.month, now.day, _currStartHour, _currStartMinute);
      widget.onChange!(startDateTime, _calcStartSelectIndexList());
    }
  }

  /// find start scroll controller by specified format
  FixedExtentScrollController? _findScrollCtrl(String format) {
    FixedExtentScrollController? scrollCtrl;
    _startScrollCtrlMap.forEach((key, value) {
      if (format.contains(key)) {
        scrollCtrl = value;
      }
    });
    return scrollCtrl;
  }

  /// find item value range by specified format
  List<int>? _findPickerItemRange(String format) {
    List<int>? valueRange;
    _valueRangeMap.forEach((key, value) {
      if (format.contains(key)) {
        valueRange = value;
      }
    });
    return valueRange;
  }

  /// render the picker widget of year、month and day
  Widget _renderDatePickerWidget() {
    List<Widget> pickers = [];
    List<String> formatArr =
        DateTimeFormatter.splitDateFormat(widget.dateFormat);
    formatArr.forEach((format) {
      List<int>? valueRange = _findPickerItemRange(format);

      Widget pickerColumn = _renderDatePickerColumnComponent(
        scrollCtrl: _findScrollCtrl(format),
        valueRange: valueRange,
        format: format,
        valueChanged: (value) {
          if (format.contains('H')) {
            _changeHourSelection(value);
          } else if (format.contains('m')) {
            _changeMinuteSelection(value);
          }
        },
      );
      pickers.add(pickerColumn);
    });
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: pickers);
  }

  Widget _renderDatePickerColumnComponent({
    required FixedExtentScrollController? scrollCtrl,
    required List<int>? valueRange,
    required String format,
    required ValueChanged<int> valueChanged,
  }) {
    var globalKey;
    if (_scrolledNotMinute && format.contains("m")) {
      globalKey = GlobalKey();
      _scrolledNotMinute = false;
    }

    return Expanded(
      flex: 1,
      child: Container(
        height: widget.themeData!.pickerHeight,
        color: widget.themeData!.backgroundColor,
        child: BrnPicker.builder(
          key: globalKey,
          backgroundColor: widget.themeData!.backgroundColor,
          lineColor: widget.themeData!.dividerColor,
          scrollController: scrollCtrl,
          itemExtent: widget.themeData!.itemHeight,
          onSelectedItemChanged: (int index) {
            if (!format.contains("m")) {
              _scrolledNotMinute = true;
            }
            valueChanged(index);
          },
          childCount: format.contains('m')
              ? _calculateMinuteChildCount(valueRange, _minuteDivider)
              : valueRange!.last - valueRange.first + 1,
          itemBuilder: (context, index) {
            int value = valueRange!.first + index;

            if (format.contains('m')) {
              value = valueRange.first + _minuteDivider * index;
            }
            return _renderDatePickerItemComponent(
                index, format.contains('m'), value, format);
          },
        ),
      ),
    );
  }

  _calculateMinuteChildCount(List<int>? valueRange, int? divider) {
    if (divider == 0 || divider == 1) {
      debugPrint("Cant devide by 0");
      return (valueRange!.last - valueRange.first + 1);
    }

    return ((valueRange!.last - valueRange.first) ~/ divider!) + 1;
  }

  Widget _renderDatePickerItemComponent(
      int index, bool isMinuteColumn, int value, String format) {
    TextStyle textStyle = widget.themeData!.itemTextStyle.generateTextStyle();
    if ((!isMinuteColumn && (index == _calcStartSelectIndexList()[0])) ||
        ((isMinuteColumn && (index == _calcStartSelectIndexList()[1])))) {
      textStyle = widget.themeData!.itemTextSelectedStyle.generateTextStyle();
    }
    return Container(
        height: widget.themeData!.itemHeight,
        alignment: Alignment.center,
        child: Text(
          DateTimeFormatter.formatDateTime(value, format, widget.locale),
          style: textStyle,
        ));
  }

  /// change the selection of hour picker
  void _changeHourSelection(int index) {
    int value = _hourRange.first + index;
    _currStartHour = value;
    _changeStartTimeRange();
    _onSelectedChange();
  }

  /// change the selection of month picker
  void _changeMinuteSelection(int index) {
    int value = _minuteRange.first + index * _minuteDivider;
    _currStartMinute = value;
    _changeStartTimeRange();
    _onSelectedChange();
  }

  /// change range of minute and second
  void _changeStartTimeRange() {
    if (_isChangeTimeRange) {
      return;
    }
    _isChangeTimeRange = true;

    List<int> minuteRange = _calcMinuteRange();
    bool minuteRangeChanged = _minuteRange.first != minuteRange.first ||
        _minuteRange.last != minuteRange.last;
    if (minuteRangeChanged) {
      // selected hour changed
      _currStartMinute =
          max(min(_currStartMinute, minuteRange.last), minuteRange.first);
    }

    setState(() {
      _minuteRange = minuteRange;
      _valueRangeMap['m'] = minuteRange;
    });

    if (minuteRangeChanged) {
      // CupertinoPicker refresh data not working (https://github.com/flutter/flutter/issues/22999)
      int currMinute = _currStartMinute;
      _startMinuteScrollCtrl
          .jumpToItem((minuteRange.last - minuteRange.first) ~/ _minuteDivider);
      if (currMinute < minuteRange.last) {
        _startMinuteScrollCtrl
            .jumpToItem((currMinute - minuteRange.first) ~/ _minuteDivider);
      }
    }

    _isChangeTimeRange = false;
  }

  /// calculate selected index list
  List<int> _calcStartSelectIndexList() {
    int hourIndex = _currStartHour - _hourRange.first;
    int minuteIndex = (_currStartMinute - _minuteRange.first) ~/ _minuteDivider;
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
}
