import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///单选日期回调函数
typedef CalendarDateChange = Function(DateTime date);

///范围选择日期回调函数
typedef CalendarRangeDateChange = Function(DateTimeRange range);

/// 展示模式，周视图模式，月视图模式
enum DisplayMode { week, month }

/// 时间选择模式，单个时间，时间范围
enum SelectMode { single, range }

/// 日历组件 包括月视图，周视图、日期单选、日期范围选等功能。
/// 1、点击不同月份日期，自动切换到最新选中日期所在月份。
/// 2、日历组件支持时间范围展示，仅展示范围内的日历视图，范围外日期置灰不可点击。日期范围边界后不可再翻页。
class BrnCalendarView extends StatefulWidget {
  BrnCalendarView(
      {Key? key,
      this.selectMode = SelectMode.single,
      this.displayMode = DisplayMode.month,
      this.weekNames,
      this.showControllerBar = true,
      this.initStartSelectedDate,
      this.initEndSelectedDate,
      this.initDisplayDate,
      this.dateChange,
      this.rangeDateChange,
      this.minDate,
      this.maxDate})
      : assert(selectMode == SelectMode.single && dateChange != null ||
            selectMode == SelectMode.range && rangeDateChange != null),
        super(key: key);

  /// 选择时间-单选构造 仅能选择一个日期
  BrnCalendarView.single(
      {Key? key,
      this.displayMode = DisplayMode.month,
      this.weekNames,
      this.showControllerBar = true,
      this.initStartSelectedDate,
      this.initEndSelectedDate,
      this.initDisplayDate,
      required this.dateChange,
      this.minDate,
      this.maxDate})
      : this.selectMode = SelectMode.single,
        this.rangeDateChange = null,
        super(key: key);

  /// 选择时间-时间范围选择
  BrnCalendarView.range(
      {Key? key,
      this.displayMode = DisplayMode.month,
      this.weekNames,
      this.showControllerBar = true,
      this.initStartSelectedDate,
      this.initEndSelectedDate,
      this.initDisplayDate,
      required this.rangeDateChange,
      this.minDate,
      this.maxDate})
      : this.selectMode = SelectMode.range,
        this.dateChange = null,
        super(key: key);

  /// 展示模式， Week, Month
  final DisplayMode displayMode;

  /// 选择模式， 单选, 范围选择
  final SelectMode selectMode;

  /// 日历日期选择范围最小值
  ///
  /// 默认 `DateTime(1970)`
  final DateTime? minDate;

  /// 日历日期选择范围最大值
  ///
  /// 默认 `DateTime(2100)`
  final DateTime? maxDate;

  /// 日历日期初始选中最小值
  final DateTime? initStartSelectedDate;

  /// 日历日期初始选中最大值
  final DateTime? initEndSelectedDate;

  /// 是否展示顶部控制按钮
  final bool showControllerBar;

  /// 自定义星期的名称
  final List<String>? weekNames;

  /// 初始展示月份
  ///
  /// 默认当前时间
  final DateTime? initDisplayDate;

  /// single 类型选择日期回调
  final CalendarDateChange? dateChange;

  /// range 类型选择日期回调
  final CalendarRangeDateChange? rangeDateChange;

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<BrnCalendarView> {
  List<DateTime> dateList = <DateTime>[];
  late DateTime _currentDate;
  late DisplayMode _displayMode;
  late DateTime _minDate, _maxDate;
  DateTime? _currentStartSelectedDate, _currentEndSelectedDate;

  @override
  void initState() {
    _displayMode = widget.displayMode;
    _currentDate = widget.initDisplayDate ?? DateTime.now();
    _minDate = widget.minDate ?? DateTime(1970);
    _maxDate = widget.maxDate ?? DateTime(2100);
    _currentStartSelectedDate = widget.initStartSelectedDate;
    _currentEndSelectedDate = widget.initEndSelectedDate;

    if (_displayMode == DisplayMode.month) {
      _setListOfMonthDate(_currentDate);
    } else if (_displayMode == DisplayMode.week) {
      _setListOfWeekDate(_currentDate);
    }
    super.initState();
  }

  void _setListOfWeekDate(DateTime weekDate) {
    dateList.clear();
    List<DateTime> tmpDateList = [];
    int previousDay = weekDate.weekday % 7;
    for (int i = 0; i < weekDate.weekday; i++) {
      tmpDateList.add(weekDate.subtract(Duration(days: previousDay - i)));
    }
    int preCount = tmpDateList.length;
    for (int i = 0; i < (7 - preCount); i++) {
      tmpDateList.add(weekDate.add(Duration(days: i)));
    }

    dateList.addAll(tmpDateList.map((f) => DateTime(f.year, f.month, f.day)));
  }

  void _setListOfMonthDate(DateTime monthDate) {
    dateList.clear();
    List<DateTime> tmpDateList = [];
    final DateTime newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMonthDay = (newDate.weekday + 1) % 7;
    for (int i = 1; i <= previousMonthDay; i++) {
      tmpDateList.add(newDate.subtract(Duration(days: previousMonthDay - i)));
    }
    int preMonthCount = tmpDateList.length;
    for (int i = 0; i < (42 - preMonthCount); i++) {
      tmpDateList.add(newDate.add(Duration(days: i + 1)));
    }
    dateList.addAll(tmpDateList.map((f) => DateTime(f.year, f.month, f.day)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _controllerBar(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: _getDaysNameUI(),
            ),
          ),
          Column(
            children: _getDaysNoUI(),
          ),
        ],
      ),
    );
  }

  Widget _controllerBar() {
    bool isPreIconEnable = _isIconEnable(true);
    bool isNextIconEnable = _isIconEnable(false);
    if (widget.showControllerBar) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (!isPreIconEnable) return;
                setState(() {
                  if (_displayMode == DisplayMode.month) {
                    _currentDate =
                        DateTime(_currentDate.year, _currentDate.month, 0);
                    _setListOfMonthDate(_currentDate);
                  } else if (_displayMode == DisplayMode.week) {
                    _currentDate = _currentDate.subtract(Duration(days: 7));
                    _setListOfWeekDate(_currentDate);
                  }
                });
              },
              child: Container(
                height: 25,
                width: 40,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 15),
                child: isPreIconEnable
                    ? BrunoTools.getAssetImage(BrnAsset.iconCalendarPreMonth)
                    : BrunoTools.getAssetImageWithColor(
                        BrnAsset.iconCalendarPreMonth, Color(0xFFCCCCCC)),
                alignment: Alignment.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  DateFormat(BrnIntl.of(context).localizedResource.dateFormatYYYYMM).format(_currentDate),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: BrnThemeConfigurator.instance
                          .getConfig()
                          .commonConfig
                          .colorTextBase),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!isNextIconEnable) return;
                setState(() {
                  if (_displayMode == DisplayMode.month) {
                    _currentDate =
                        DateTime(_currentDate.year, _currentDate.month + 2, 0);
                    _setListOfMonthDate(_currentDate);
                  } else if (_displayMode == DisplayMode.week) {
                    _currentDate = _currentDate.add(Duration(days: 7));
                    _setListOfWeekDate(_currentDate);
                  }
                });
              },
              child: Container(
                height: 25,
                width: 40,
                color: Colors.transparent,
                padding: EdgeInsets.only(right: 15),
                child: isNextIconEnable
                    ? BrunoTools.getAssetImage(BrnAsset.iconCalendarNextMonth)
                    : BrunoTools.getAssetImageWithColor(
                        BrnAsset.iconCalendarNextMonth, Color(0xFFCCCCCC)),
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  bool _isIconEnable(bool isPre) {
    if (isPre) {
      if (dateList[0].year < _minDate.year) {
        return false;
      }
      if (dateList[0].year == _minDate.year) {
        if (_displayMode == DisplayMode.week) {
          if (dateList[0].month < _minDate.month) {
            return false;
          }
          if (dateList[0].month == _minDate.month) {
            if (dateList[0].day <= _minDate.day) {
              return false;
            }
          }
        } else {
          if (dateList[0].month <= _minDate.month &&
              _currentDate.month == _minDate.month) {
            return false;
          }
        }
      }
      return true;
    } else {
      if (dateList.last.year > _maxDate.year) {
        return false;
      }
      if (dateList.last.year == _maxDate.year) {
        if (_displayMode == DisplayMode.week) {
          if (dateList.last.month > _maxDate.month) {
            return false;
          }
          if (dateList.last.month == _maxDate.month) {
            if (dateList.last.day >= _maxDate.day) {
              return false;
            }
          }
        } else {
          if (dateList.last.month >= _maxDate.month &&
              _currentDate.month == _maxDate.month) {
            return false;
          }
        }
      }
      return true;
    }
  }

  List<Widget> _getDaysNameUI() {
    final List<Widget> listUI = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              _getChinaWeekName(i),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: BrnThemeConfigurator.instance
                      .getConfig()
                      .commonConfig
                      .colorTextBase),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  List<Widget> _getDaysNoUI() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    for (int i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    // 范围颜色条
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: _isStartDateRadius(date) ? 8 : 0,
                            right: _isEndDateRadius(date) ? 8 : 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _currentStartSelectedDate != null &&
                                    _currentEndSelectedDate != null
                                ? (_getIsItStartAndEndDate(date) ||
                                        _getIsInRange(date)
                                    ? BrnThemeConfigurator.instance
                                        .getConfig()
                                        .commonConfig
                                        .brandPrimary
                                        .withOpacity(0.14)
                                    : Colors.transparent)
                                : Colors.transparent,
                            // 范围选择两端圆角
                            borderRadius: BorderRadius.horizontal(
                              left: _isStartDateRadius(date)
                                  ? const Radius.circular(24.0)
                                  : const Radius.circular(0.0),
                              right: _isEndDateRadius(date)
                                  ? const Radius.circular(24.0)
                                  : const Radius.circular(0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 8, right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _getIsItStartAndEndDate(date)
                                  ? BrnThemeConfigurator.instance
                                      .getConfig()
                                      .commonConfig
                                      .brandPrimary
                                  : Colors.transparent,
                              borderRadius:
                                  // 选中色圆角
                                  const BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                        onTap: () {
                          final DateTime newMinimumDate = DateTime(
                              _minDate.year, _minDate.month, _minDate.day - 1);
                          final DateTime newMaximumDate = DateTime(
                              _maxDate.year, _maxDate.month, _maxDate.day + 1);
                          if (date.isAfter(newMinimumDate) &&
                              date.isBefore(newMaximumDate)) {
                            _currentDate = date;
                            if (_displayMode == DisplayMode.week) {
                              _setListOfWeekDate(_currentDate);
                            } else if (_displayMode == DisplayMode.month) {
                              _setListOfMonthDate(_currentDate);
                            }
                            if (widget.selectMode == SelectMode.single) {
                              _onSingleDateClick(date);
                            } else {
                              _onRangeDateClick(date);
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: Container(
                            child: Center(
                              child: Text(
                                date.day > 9 ? '${date.day}' : '0${date.day}',
                                style: TextStyle(
                                    color: _displayMode == DisplayMode.month
                                        ? (_getIsItStartAndEndDate(date)
                                            ? Colors.white
                                            : _currentDate.month ==
                                                        date.month &&
                                                    0 <=
                                                        date.compareTo(
                                                            _minDate) &&
                                                    date.compareTo(_maxDate) <=
                                                        0
                                                ? BrnThemeConfigurator.instance
                                                    .getConfig()
                                                    .commonConfig
                                                    .colorTextBase
                                                : BrnThemeConfigurator.instance
                                                    .getConfig()
                                                    .commonConfig
                                                    .colorTextHint)
                                        : (_getIsItStartAndEndDate(date)
                                            ? Colors.white
                                            : (0 <= date.compareTo(_minDate) &&
                                                    date.compareTo(_maxDate) <=
                                                        0
                                                ? BrnThemeConfigurator.instance
                                                    .getConfig()
                                                    .commonConfig
                                                    .colorTextBase
                                                : BrnThemeConfigurator.instance
                                                    .getConfig()
                                                    .commonConfig
                                                    .colorTextHint)),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                            color: DateTime.now().day == date.day &&
                                    DateTime.now().month == date.month &&
                                    DateTime.now().year == date.year
                                ? BrnThemeConfigurator.instance
                                    .getConfig()
                                    .commonConfig
                                    .brandPrimary
                                : Colors.transparent,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        count += 1;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  bool _getIsInRange(DateTime date) {
    if (_currentStartSelectedDate != null && _currentEndSelectedDate != null) {
      if (date.isAfter(_currentStartSelectedDate!) &&
          date.isBefore(_currentEndSelectedDate!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool _getIsItStartAndEndDate(DateTime date) {
    if (_currentStartSelectedDate != null &&
        _currentStartSelectedDate!.day == date.day &&
        _currentStartSelectedDate!.month == date.month &&
        _currentStartSelectedDate!.year == date.year) {
      return true;
    } else if (_currentEndSelectedDate != null &&
        _currentEndSelectedDate!.day == date.day &&
        _currentEndSelectedDate!.month == date.month &&
        _currentEndSelectedDate!.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool _isStartDateRadius(DateTime date) {
    if (_currentStartSelectedDate != null &&
        _currentStartSelectedDate!.day == date.day &&
        _currentStartSelectedDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  bool _isEndDateRadius(DateTime date) {
    if (_currentEndSelectedDate != null &&
        _currentEndSelectedDate!.day == date.day &&
        _currentEndSelectedDate!.month == date.month) {
      return true;
    } else if (date.weekday == 6) {
      return true;
    } else {
      return false;
    }
  }

  void _onSingleDateClick(DateTime date) {
    _currentStartSelectedDate = date;
    _currentEndSelectedDate = date;
    setState(() {
      try {
        if (widget.dateChange != null) {
          widget.dateChange!(date);
        }
      } catch (_) {}
    });
  }

  /// 在选择 [date] 这个时间时，startDate、endDate 的状态共四种组合（×: 代表无值， √: 代表有值）
  ///   start    end
  /// ①  √       √
  /// ②  ×       ×
  /// ③  √       ×
  /// ④  ×       √
  void _onRangeDateClick(DateTime date) {
    // 当为 ①、② 都有值，或都无值的时候，在选择 date 后，将date 赋值给 start，end 置空
    if ((_currentStartSelectedDate != null  && _currentEndSelectedDate != null) ||
        (_currentStartSelectedDate == null  && _currentEndSelectedDate == null)) {
      _currentStartSelectedDate = date;
      _currentEndSelectedDate = null;
    } else{
      // 当为 ③、④ 其中有一个有值时，在选择 date 后，将 date 赋值给为空的一方
      if(_currentStartSelectedDate == null) {
        _currentStartSelectedDate = date;
      }
      if(_currentEndSelectedDate == null) {
        _currentEndSelectedDate = date;
      }
    }

    // 根据 start、end 时间大小，交换其值
    if (_currentStartSelectedDate != null && _currentEndSelectedDate != null) {
      if (!_currentEndSelectedDate!.isAfter(_currentStartSelectedDate!)) {
        final DateTime d = _currentStartSelectedDate!;
        _currentStartSelectedDate = _currentEndSelectedDate;
        _currentEndSelectedDate = d;
      }
    }

    setState(() {
      if (_currentStartSelectedDate != null &&
          _currentEndSelectedDate != null &&
          widget.rangeDateChange != null) {
        widget.rangeDateChange!(DateTimeRange(
          start: _currentStartSelectedDate!,
          end: _currentEndSelectedDate!,
        ));
      }
    });
  }

  String _getChinaWeekName(int weekOfDay) {
    return (widget.weekNames ?? BrnIntl.of(context).localizedResource.weekMinName)[weekOfDay];
  }
}
