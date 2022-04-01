

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
    return BrnCalendarView.single(
      displayMode: DisplayMode.week,
      showControllerBar: false,
      dateChange: (date) {
        BrnToast.show('选中的时间： $date', context);
      },
    );
  }

  Widget _calendarViewWeekNocontrollCustomWeekName(context) {
    return BrnCalendarView.single(
      displayMode: DisplayMode.week,
      showControllerBar: false,
      weekNames: ['星期天', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
      dateChange: (date) {
        BrnToast.show('选中的时间： $date', context);
      },
    );
  }

  Widget _calendarViewWeek(context) {
    return BrnCalendarView.single(
      displayMode: DisplayMode.week,
      initDisplayDate: DateTime.parse('2020-06-01'),
      minDate: DateTime(2020),
      maxDate: DateTime(2021),
      dateChange: (date) {
        BrnToast.show('选中的时间： $date', context);
      },
    );
  }

  Widget _calendarViewWeekRange(context) {
    return BrnCalendarView.range(
      displayMode: DisplayMode.week,
      rangeDateChange: (rangeDate) {
        BrnToast.show(
            '开始时间： ${rangeDate.start} , 结束时间：${rangeDate.end}', context);
      },
    );
  }

  Widget _calendarViewMonth(context) {
    return BrnCalendarView.single(
      initDisplayDate: DateTime.parse('2020-06-01'),
      minDate: DateTime(2020),
      maxDate: DateTime(2021),
      dateChange: (date) {
        BrnToast.show('选中的时间： $date', context);
      },
    );
  }

  Widget _calendarViewMonthRange(context) {
    return BrnCalendarView.range(
      minDate: DateTime(2020),
      maxDate: DateTime(2023),
      rangeDateChange: (rangeDate) {
        BrnToast.show(
            '开始时间： ${rangeDate.start} , 结束时间：${rangeDate.end}', context);
      },
    );
  }
}
