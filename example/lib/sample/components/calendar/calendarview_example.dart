// @dart=2.9

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

///标签选择view
class CalendarViewExample extends StatefulWidget {
  final String _title;

  CalendarViewExample(this._title);

  @override
  State<StatefulWidget> createState() => TagViewExamplePageState();
}

class TagViewExamplePageState extends State<CalendarViewExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: widget._title,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Text('单选-无控制-周视图'),
              _calendarViewWeekNocontroll(context),
              BrnLine(
                height: 40.0,
              ),
              Text('单选-无控制-周视图-自定义 WeekName'),
              _calendarViewWeekNocontrollCustomWeekName(context),
              BrnLine(
                height: 40.0,
              ),
              Text('单选-周视图'),
              _calendarViewWeek(context),
              BrnLine(
                height: 40.0,
              ),
              Text('范围选-周视图'),
              _calendarViewWeekRange(context),
              BrnLine(
                height: 40.0,
              ),
              Text('单选-月视图'),
              _calendarViewMonth(context),
              BrnLine(
                height: 40.0,
              ),
              Text('范围选-月视图'),
              _calendarViewMonthRange(context),
            ],
          ),
        ));
  }

  Widget _calendarViewWeekNocontroll(context) {
    return BrnCalendarView(
      displayMode: DisplayMode.Week,
      selectMode: SelectMode.SINGLE,
      showControllerBar: false,
      startEndDateChange: (startDate, endDate) {
        BrnToast.show('开始时间： $startDate , 结束时间：$endDate', context);
      },
    );
  }

  Widget _calendarViewWeekNocontrollCustomWeekName(context) {
    return BrnCalendarView(
      displayMode: DisplayMode.Week,
      selectMode: SelectMode.SINGLE,
      showControllerBar: false,
      weekNames: ['星期天', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
      startEndDateChange: (startDate, endDate) {
        BrnToast.show('开始时间： $startDate , 结束时间：$endDate', context);
      },
    );
  }

  Widget _calendarViewWeek(context) {
    return BrnCalendarView(
      displayMode: DisplayMode.Week,
      initDisplayDate: DateTime.parse('2020-06-01'),
      minDate: DateTime(2020),
      maxDate: DateTime(2021),
      startEndDateChange: (startDate, endDate) {
        BrnToast.show('开始时间： $startDate , 结束时间：$endDate', context);
      },
    );
  }

  Widget _calendarViewWeekRange(context) {
    return BrnCalendarView(
      displayMode: DisplayMode.Week,
      selectMode: SelectMode.RANGE,
      startEndDateChange: (startDate, endDate) {
        BrnToast.show('开始时间： $startDate , 结束时间：$endDate', context);
      },
    );
  }

  Widget _calendarViewMonth(context) {
    return BrnCalendarView(
      selectMode: SelectMode.SINGLE,
      initDisplayDate: DateTime.parse('2020-06-01'),
      minDate: DateTime(2020),
      maxDate: DateTime(2021),
      startEndDateChange: (startDate, endDate) {
        BrnToast.show('开始时间： $startDate , 结束时间：$endDate', context);
      },
    );
  }

  Widget _calendarViewMonthRange(context) {
    return BrnCalendarView(
      selectMode: SelectMode.RANGE,
      minDate: DateTime(2020),
      maxDate: DateTime(2023),
      startEndDateChange: (startDate, endDate) {
        BrnToast.show('开始时间： $startDate , 结束时间：$endDate', context);
      },
    );
  }
}
