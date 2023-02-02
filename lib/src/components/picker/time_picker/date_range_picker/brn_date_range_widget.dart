import 'dart:math';

import 'package:bruno/src/components/picker/base/brn_picker.dart';
import 'package:bruno/src/components/picker/base/brn_picker_title.dart';
import 'package:bruno/src/components/picker/base/brn_picker_title_config.dart';
import 'package:bruno/src/components/picker/time_picker/brn_date_picker_constants.dart';
import 'package:bruno/src/components/picker/time_picker/date_range_picker/brn_date_range_side_widget.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';

/// Solar months of 31 days.
const List<int> _solarMonthsOf31Days = const <int>[1, 3, 5, 7, 8, 10, 12];

/// DatePicker widget.
// ignore: must_be_immutable
class BrnDateRangeWidget extends StatefulWidget {
  /// 可选最小时间
  final DateTime? minDateTime;

  /// 可选最大时间
  final DateTime? maxDateTime;

  /// 初始选中的开始时间
  final DateTime? initialStartDateTime;

  /// 初始选中的结束时间
  final DateTime? initialEndDateTime;

  /// 时间展示格式
  final String? dateFormat;

  /// cancel 回调
  final DateVoidCallback? onCancel;

  /// 选中时间变化时的回调，返回选中的开始、结束时间
  final DateRangeValueCallback? onChange;

  /// 确定回调，返回选中的开始、结束时间
  final DateRangeValueCallback? onConfirm;

  /// Picker title  相关内容配置
  final BrnPickerTitleConfig pickerTitleConfig;

  /// Picker 主题配置
  BrnPickerConfig? themeData;

  BrnDateRangeWidget({
    Key? key,
    this.minDateTime,
    this.maxDateTime,
    this.initialStartDateTime,
    this.initialEndDateTime,
    this.dateFormat = datetimeRangePickerDateFormat,
    this.pickerTitleConfig = BrnPickerTitleConfig.Default,
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
  State<StatefulWidget> createState() => _DatePickerWidgetState(
      this.minDateTime,
      this.maxDateTime,
      this.initialStartDateTime,
      this.initialEndDateTime);
}

class _DatePickerWidgetState extends State<BrnDateRangeWidget> {
  late DateTime _minDateTime, _maxDateTime;
  late int _currStartYear, _currStartMonth, _currStartDay;
  late int _currEndYear, _currEndMonth, _currEndDay;

  late List<int> _monthRange, _startDayRange, _endDayRange;
  late List<int> _startSelectedIndex;
  late List<int> _endSelectedIndex;
  late DateTime _startSelectedDateTime;
  late DateTime _endSelectedDateTime;

  bool _isFirstScroll = false;
  bool _isSecondScroll = false;

  _DatePickerWidgetState(DateTime? minDateTime, DateTime? maxDateTime,
      DateTime? initialStartDateTime, DateTime? initialEndDateTime) {
    // handle current selected year、month、day
    _initData(
        initialStartDateTime, initialEndDateTime, minDateTime, maxDateTime);
  }

  void _initData(DateTime? initialStartDateTime, DateTime? initialEndDateTime,
      DateTime? minDateTime, DateTime? maxDateTime) {
    DateTime initStartDateTime = initialStartDateTime ?? DateTime.now();
    DateTime initEndDateTime = initialEndDateTime ?? DateTime.now();

    this._currStartYear = initStartDateTime.year;
    this._currStartMonth = initStartDateTime.month;
    this._currStartDay = initStartDateTime.day;

    this._currEndYear = initEndDateTime.year;
    this._currEndMonth = initEndDateTime.month;
    this._currEndDay = initEndDateTime.day;

    // handle DateTime range
    this._minDateTime = minDateTime ?? DateTime.parse(datePickerMinDatetime);
    this._maxDateTime = maxDateTime ?? DateTime.parse(datePickerMaxDatetime);

    // limit the range of year
    this._currStartYear =
        min(max(_minDateTime.year, _currStartYear), _maxDateTime.year);
    this._currEndYear = min(_maxDateTime.year, _currEndYear);

    // limit the range of month
    this._monthRange = _calcMonthRange();
    this._currStartMonth =
        min(max(_monthRange.first, _currStartMonth), _monthRange.last);
    this._currEndMonth = min(_monthRange.last, _currEndMonth);

    // limit the range of day
    this._startDayRange = _calcDayRange(currMonth: _currStartMonth);
    this._currStartDay =
        min(max(_startDayRange.first, _currStartDay), _startDayRange.last);
    this._endDayRange = _calcDayRange(currMonth: _currEndMonth);
    this._currEndDay = min(_endDayRange.last, _currEndDay);

    _startSelectedDateTime =
        DateTime(_currStartYear, _currStartMonth, _currStartDay);
    _endSelectedDateTime = DateTime(_currEndYear, _currEndMonth, _currEndDay);
    _startSelectedIndex = _calcSelectIndexList(true);
    _endSelectedIndex = _calcSelectIndexList(false);
  }

  @override
  Widget build(BuildContext context) {
    _initData(_startSelectedDateTime, _endSelectedDateTime, _minDateTime,
        _maxDateTime);
    return GestureDetector(
      child: Material(
          color: Colors.transparent, child: _renderPickerView(context)),
    );
  }

  /// render date picker widgets
  Widget _renderPickerView(BuildContext context) {
    Widget datePickerWidget = _renderDatePickerWidget();

    // display the title widget
    if (widget.pickerTitleConfig.title != null ||
        widget.pickerTitleConfig.showTitle) {
      Widget titleWidget = BrnPickerTitle(
        pickerTitleConfig: widget.pickerTitleConfig,
        onCancel: () => _onPressedCancel(),
        onConfirm: () => _onPressedConfirm(),
      );
      return Column(children: <Widget>[titleWidget, datePickerWidget]);
    }
    return datePickerWidget;
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
    GlobalKey? firstGlobalKey;
    GlobalKey? secondGlobalKey;

    if (_isFirstScroll) {
      secondGlobalKey = GlobalKey();
      _isFirstScroll = false;
    }
    if (_isSecondScroll) {
      firstGlobalKey = GlobalKey();
      _isSecondScroll = false;
    }

    List<Widget> pickers = [];
    pickers.add(Expanded(
        flex: 6,
        child: Container(
            height: widget.themeData!.pickerHeight,
            color: widget.themeData!.backgroundColor,
            child: BrnDateRangeSideWidget(
              key: firstGlobalKey,
              dateFormat: widget.dateFormat,
              minDateTime: widget.minDateTime,
              maxDateTime: widget.maxDateTime,
              initialStartDateTime: _startSelectedDateTime,
              onInitSelectChange:
                  (DateTime selectedDateTime, List<int> selected) {
                _startSelectedDateTime = selectedDateTime;
                _startSelectedIndex = selected;
              },
              onChange: (DateTime selectedDateTime, List<int> selectedIndex) {
                setState(() {
                  _startSelectedDateTime = selectedDateTime;
                  _startSelectedIndex = selectedIndex;
                  _isFirstScroll = true;
                });
              },
            ))));
    pickers.add(_renderDatePickerMiddleColumnComponent());
    pickers.add(Expanded(
        flex: 6,
        child: Container(
            height: widget.themeData!.pickerHeight,
            color: widget.themeData!.backgroundColor,
            child: BrnDateRangeSideWidget(
              key: secondGlobalKey,
              dateFormat: widget.dateFormat,
              minDateTime: _startSelectedDateTime,
              maxDateTime: widget.maxDateTime,
              initialStartDateTime:
                  _endSelectedDateTime.compareTo(_startSelectedDateTime) > 0
                      ? _endSelectedDateTime
                      : _startSelectedDateTime,
              onInitSelectChange:
                  (DateTime selectedDateTime, List<int> selectedIndex) {
                _endSelectedDateTime = selectedDateTime;
                _endSelectedIndex = selectedIndex;
              },
              onChange: (DateTime selectedDateTime, List<int> selectedIndex) {
                setState(() {
                  _endSelectedDateTime = selectedDateTime;
                  _endSelectedIndex = selectedIndex;
                  _isSecondScroll = true;
                });
              },
            ))));
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: pickers);
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
                BrnIntl.of(context).localizedResource.to,
                style: widget.themeData!.itemTextStyle.generateTextStyle(),
              ),
            );
          },
          onSelectedItemChanged: (int value) {},
        ),
      ),
    );
  }

  /// calculate the count of day in current month
  int _calcDayCountOfMonth() {
    if (_currStartMonth == 2) {
      return isLeapYear(_currStartYear) ? 29 : 28;
    } else if (_solarMonthsOf31Days.contains(_currStartMonth)) {
      return 31;
    }
    return 30;
  }

  /// whether or not is leap year
  bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  /// calculate selected index list
  List<int> _calcSelectIndexList(bool isStart) {
    if (isStart) {
      int yearIndex = _currStartYear - _minDateTime.year;
      int monthIndex = _currStartMonth - _monthRange.first;
      int dayIndex = _currStartDay - _startDayRange.first;
      return [yearIndex, monthIndex, dayIndex];
    } else {
      int yearIndex = _currEndYear - _minDateTime.year;
      int monthIndex = _currEndMonth - _monthRange.first;
      int dayIndex = _currEndDay - _endDayRange.first;
      return [yearIndex, monthIndex, dayIndex];
    }
  }

  /// calculate the range of month
  List<int> _calcMonthRange() {
    int minMonth = 1, maxMonth = 12;
    int minYear = _minDateTime.year;
    int maxYear = _maxDateTime.year;
    if (minYear == _currStartYear) {
      // selected minimum year, limit month range
      minMonth = _minDateTime.month;
    }
    if (maxYear == _currStartYear) {
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
      currMonth = _currStartMonth;
    }
    if (minYear == _currStartYear && minMonth == currMonth) {
      // selected minimum year and month, limit day range
      minDay = _minDateTime.day;
    }
    if (maxYear == _currStartYear && maxMonth == currMonth) {
      // selected maximum year and month, limit day range
      maxDay = _maxDateTime.day;
    }
    return [minDay, maxDay];
  }
}
