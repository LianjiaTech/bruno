import 'dart:math';

import 'package:bruno/src/components/picker/base/brn_picker.dart';
import 'package:bruno/src/components/picker/time_picker/brn_date_picker_constants.dart';
import 'package:bruno/src/components/picker/time_picker/brn_date_time_formatter.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';

/// Solar months of 31 days.
const List<int> _solarMonthsOf31Days = const <int>[1, 3, 5, 7, 8, 10, 12];

enum ColumnType { year, month, day }

/// one side widget of DateRangePicker
// ignore: must_be_immutable
class BrnDateRangeSideWidget extends StatefulWidget {
  /// 可选最小时间
  final DateTime? minDateTime;

  /// 可选最大时间
  final DateTime? maxDateTime;

  /// 初始开始选中时间
  final DateTime? initialStartDateTime;

  /// 时间展示格式
  final String? dateFormat;

  /// 时间选择变化时回调
  final DateRangeSideValueCallback? onChange;

  /// 当前默认选择的时间变化时对外部回调，外部监听该事件同步修改默认初始选中的时间
  final DateRangeSideValueCallback? onInitSelectChange;

  /// 主题定制
  BrnPickerConfig? themeData;

  BrnDateRangeSideWidget({
    Key? key,
    this.minDateTime,
    this.maxDateTime,
    this.initialStartDateTime,
    this.dateFormat = datetimeRangePickerDateFormat,
    this.onInitSelectChange,
    this.onChange,
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
  State<StatefulWidget> createState() => _DatePickerWidgetState(
      this.minDateTime,
      this.maxDateTime,
      this.initialStartDateTime,
      this.onInitSelectChange);
}

class _DatePickerWidgetState extends State<BrnDateRangeSideWidget> {
  late DateTime _minDateTime, _maxDateTime;
  late int _currYear, _currMonth, _currDay;
  late List<int> _yearRange, _monthRange, _dayRange;
  late FixedExtentScrollController _yearScrollCtrl,
      _monthScrollCtrl,
      _dayScrollCtrl;

  late Map<String, FixedExtentScrollController?> _scrollCtrlMap;
  late Map<String, List<int>> _valueRangeMap;

  bool _isChangeDateRange = false;

  bool _scrolledNotDay = false;

  DateRangeSideValueCallback? _onInitSelectChange;

  _DatePickerWidgetState(
      DateTime? minDateTime,
      DateTime? maxDateTime,
      DateTime? initialDateTime,
      DateRangeSideValueCallback? onInitSelectChange) {
    _onInitSelectChange = onInitSelectChange;
    _initData(initialDateTime, minDateTime, maxDateTime);
  }

  void _initData(
      DateTime? initialDateTime, DateTime? minDateTime, DateTime? maxDateTime) {
    DateTime initDateTime = initialDateTime ?? DateTime.now();
    this._currYear = initDateTime.year;
    this._currMonth = initDateTime.month;
    this._currDay = initDateTime.day;

    // handle DateTime range
    this._minDateTime = minDateTime ?? DateTime.parse(datePickerMinDatetime);
    this._maxDateTime = maxDateTime ?? DateTime.parse(datePickerMaxDatetime);

    // limit the range of year
    this._yearRange = _calcYearRange();
    this._currYear = min(max(_minDateTime.year, _currYear), _maxDateTime.year);

    // limit the range of month
    this._monthRange = _calcMonthRange();
    this._currMonth = min(max(_monthRange.first, _currMonth), _monthRange.last);

    // limit the range of day
    this._dayRange = _calcDayRange();
    this._currDay = min(max(_dayRange.first, _currDay), _dayRange.last);
    _onInitSelectedChange();
    // create scroll controller
    _yearScrollCtrl =
        FixedExtentScrollController(initialItem: _currYear - _yearRange.first);
    _monthScrollCtrl = FixedExtentScrollController(
        initialItem: _currMonth - _monthRange.first);
    _dayScrollCtrl =
        FixedExtentScrollController(initialItem: _currDay - _dayRange.first);
    _scrollCtrlMap = {
      'y': _yearScrollCtrl,
      'M': _monthScrollCtrl,
      'd': _dayScrollCtrl
    };
    _valueRangeMap = {'y': _yearRange, 'M': _monthRange, 'd': _dayRange};
  }

  @override
  Widget build(BuildContext context) {
    _initData(
        widget.initialStartDateTime, widget.minDateTime, widget.maxDateTime);
    return GestureDetector(
      child: Container(
          color: widget.themeData!.backgroundColor,
          child: _renderDatePickerWidget()),
    );
  }

  /// on init, selected date changed
  void _onInitSelectedChange() {
    if (_onInitSelectChange != null) {
      DateTime dateTime = DateTime(_currYear, _currMonth, _currDay);
      _onInitSelectChange!(dateTime, _calcSelectIndexList());
    }
  }

  /// notify selected date changed
  void _onSelectedChange() {
    if (widget.onChange != null) {
      DateTime dateTime = DateTime(_currYear, _currMonth, _currDay);
      widget.onChange!(dateTime, _calcSelectIndexList());
    }
  }

  /// find scroll controller by specified format
  FixedExtentScrollController? _findScrollCtrl(String format) {
    FixedExtentScrollController? scrollCtrl;
    _scrollCtrlMap.forEach((key, value) {
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
      List<int> valueRange = _findPickerItemRange(format)!;

      Widget pickerColumn = _renderDatePickerColumnComponent(
        scrollCtrl: _findScrollCtrl(format),
        valueRange: valueRange,
        format: format,
        valueChanged: (value) {
          if (format.contains('y')) {
            _changeYearSelection(value);
          } else if (format.contains('M')) {
            _changeMonthSelection(value);
          } else if (format.contains('d')) {
            _changeDaySelection(value);
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
    required List<int> valueRange,
    required String format,
    required ValueChanged<int> valueChanged,
  }) {
    GlobalKey? globalKey;
    if (_scrolledNotDay && format.contains("d")) {
      globalKey = GlobalKey();
      _scrolledNotDay = false;
    }
    return Expanded(
      flex: 1,
      child: Container(
        height: widget.themeData!.pickerHeight,
        decoration: BoxDecoration(color: widget.themeData!.backgroundColor),
        child: BrnPicker.builder(
          key: globalKey,
          backgroundColor: widget.themeData!.backgroundColor,
          lineColor: widget.themeData!.dividerColor,
          scrollController: scrollCtrl,
          itemExtent: widget.themeData!.itemHeight,
          onSelectedItemChanged: (int index) {
            if (!format.contains("d")) {
              _scrolledNotDay = true;
            }
            valueChanged(index);
          },
          childCount: valueRange.last - valueRange.first + 1,
          itemBuilder: (context, index) => _renderDatePickerItemComponent(
              format.contains("y")
                  ? ColumnType.year
                  : (format.contains("M") ? ColumnType.month : ColumnType.day),
              index,
              valueRange.first + index,
              format),
        ),
      ),
    );
  }

  Widget _renderDatePickerItemComponent(
      ColumnType columnType, int index, int value, String format) {
    TextStyle textStyle = widget.themeData!.itemTextStyle.generateTextStyle();
    if ((ColumnType.year == columnType && index == _calcSelectIndexList()[0]) ||
        (ColumnType.month == columnType &&
            index == _calcSelectIndexList()[1]) ||
        (ColumnType.day == columnType && index == _calcSelectIndexList()[2])) {
      textStyle = widget.themeData!.itemTextSelectedStyle.generateTextStyle();
    }
    return Container(
        height: widget.themeData!.itemHeight,
        alignment: Alignment.center,
        child: Text(
          DateTimeFormatter.formatDateTime(value, format),
          style: textStyle,
        ));
  }

  /// change the selection of year picker
  void _changeYearSelection(int index) {
    int year = _yearRange.first + index;
    _currYear = year;
    _changeDateRange();
    _onSelectedChange();
  }

  /// change the selection of month picker
  void _changeMonthSelection(int index) {
    int month = _monthRange.first + index;
    _currMonth = month;
    _changeDateRange();
    _onSelectedChange();
  }

  /// change the selection of day picker
  void _changeDaySelection(int index) {
    int dayOfMonth = _dayRange.first + index;
    _currDay = dayOfMonth;
    _changeDateRange();
    _onSelectedChange();
  }

  /// change range of month and day
  void _changeDateRange() {
    if (_isChangeDateRange) {
      return;
    }
    _isChangeDateRange = true;

    List<int> monthRange = _calcMonthRange();
    bool monthRangeChanged = _monthRange.first != monthRange.first ||
        _monthRange.last != monthRange.last;
    if (monthRangeChanged) {
      // selected year changed
      _currMonth = max(min(_currMonth, monthRange.last), monthRange.first);
    }

    List<int> dayRange = _calcDayRange();
    bool dayRangeChanged =
        _dayRange.first != dayRange.first || _dayRange.last != dayRange.last;
    if (dayRangeChanged) {
      // day range changed, need limit the value of selected day
      _currDay = max(min(_currDay, dayRange.last), dayRange.first);
    }

    setState(() {
      _monthRange = monthRange;
      _dayRange = dayRange;

      _valueRangeMap['M'] = monthRange;
      _valueRangeMap['d'] = dayRange;
    });

    if (monthRangeChanged) {
      // CupertinoPicker refresh data not working (https://github.com/flutter/flutter/issues/22999)
      int currMonth = _currMonth;
      _monthScrollCtrl.jumpToItem(monthRange.last - monthRange.first);
      if (currMonth <= monthRange.last) {
        _monthScrollCtrl.jumpToItem(currMonth - monthRange.first);
      }
    }

    if (dayRangeChanged) {
      // CupertinoPicker refresh data not working (https://github.com/flutter/flutter/issues/22999)
      int currDay = _currDay;
      _dayScrollCtrl.jumpToItem(dayRange.last - dayRange.first);
      if (currDay <= dayRange.last) {
        _dayScrollCtrl.jumpToItem(currDay - dayRange.first);
      }
    }

    _isChangeDateRange = false;
  }

  /// calculate the count of day in current month
  int _calcDayCountOfMonth() {
    if (_currMonth == 2) {
      return isLeapYear(_currYear) ? 29 : 28;
    } else if (_solarMonthsOf31Days.contains(_currMonth)) {
      return 31;
    }
    return 30;
  }

  /// whether or not is leap year
  bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  /// calculate selected index list
  List<int> _calcSelectIndexList() {
    int yearIndex = _currYear - _minDateTime.year;
    int monthIndex = _currMonth - _monthRange.first;
    int dayIndex = _currDay - _dayRange.first;
    return [yearIndex, monthIndex, dayIndex];
  }

  /// calculate the range of year
  List<int> _calcYearRange() {
    return [_minDateTime.year, _maxDateTime.year];
  }

  /// calculate the range of month
  List<int> _calcMonthRange() {
    int minMonth = 1, maxMonth = 12;
    int minYear = _minDateTime.year;
    int maxYear = _maxDateTime.year;
    if (minYear == _currYear) {
      // selected minimum year, limit month range
      minMonth = _minDateTime.month;
    }
    if (maxYear == _currYear) {
      // selected maximum year, limit month range
      maxMonth = _maxDateTime.month;
    }
    return [minMonth, maxMonth];
  }

  /// calculate the range of day
  List<int> _calcDayRange({currMonth}) {
    int minDay = 1, maxDay = _calcDayCountOfMonth();
    int minYear = _minDateTime.year;
    int maxYear = _maxDateTime.year;
    int minMonth = _minDateTime.month;
    int maxMonth = _maxDateTime.month;
    if (currMonth == null) {
      currMonth = _currMonth;
    }
    if (minYear == _currYear && minMonth == currMonth) {
      // selected minimum year and month, limit day range
      minDay = _minDateTime.day;
    }
    if (maxYear == _currYear && maxMonth == currMonth) {
      // selected maximum year and month, limit day range
      maxDay = _maxDateTime.day;
    }
    return [minDay, maxDay];
  }
}
