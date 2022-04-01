

import 'package:bruno/bruno.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

class DatePickerExamplePage extends StatelessWidget {
  final String _title;

  DatePickerExamplePage(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: _title,
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              title: "TimeStyle",
              describe: '时间样式选择器',
              onPressed: () {
                _showPicker(context, BrnDateTimePickerMode.time);
              },
            ),
            ListItem(
              title: "DateStyle",
              describe: '日期样式时间选择器',
              onPressed: () {
                _showPicker(context, BrnDateTimePickerMode.date);
              },
            ),
            ListItem(
              title: "DateAndTimeStyle",
              describe: '日期和时间样式选择器',
              onPressed: () {
                _showPicker(context, BrnDateTimePickerMode.datetime);
              },
            ),
            ListItem(
              title: "Time Range Style",
              describe: '时间范围选择器',
              onPressed: () {
                _showRangePicker(context, BrnDateTimeRangePickerMode.time);
              },
            ),
            ListItem(
              title: "Time Range Style",
              describe: '时间范围选择器-不限制选择的时间范围',
              onPressed: () {
                _showRangePickerNoLimited(
                    context, BrnDateTimeRangePickerMode.time);
              },
            ),
            ListItem(
              title: "Date Range Style",
              describe: '日期范围选择器',
              onPressed: () {
                _showRangePicker(context, BrnDateTimeRangePickerMode.date);
              },
            ),
            ListItem(
              title: "Date Range Style",
              describe: '日期范围选择器(yyyy年MM月dd日)',
              onPressed: () {
                _showyyyyMMddRangePicker(context);
              },
            ),
          ],
        ));
  }

//  ///时间样式时间选择器
//  void _showTimeStyle(BuildContext context) {
//    DatePickerWidget(
//      context: context,
//      title: "请选择开始看房时间",
//      mode: CupertinoDatePickerMode.time,
//      minuteInterval: 20,
//      currentDate: DateTime.now(),
//      confirmTimeClick: (date) {
//        print("the date is ${date.toString()}");
//      },
//    ).show();
//  }
//
//  ///日期样式选择器
//  void _showDateStyle(BuildContext context) {
//    DatePickerWidget(
//      context: context,
//      title: "请选择入住时间",
//      mode: CupertinoDatePickerMode.date,
//      minYear: 2019,
//      currentDate: DateTime.now(),
//      confirmTimeClick: (date) {
//        print("the date is ${date.toString()}");
//      },
//    ).show();
//  }
//
//  ///日期和时间样式选择器
//  void _showDateAndTimeStyle(BuildContext context) {
//    DatePickerWidget(
//      context: context,
//      title: "请选择入住时间",
//      mode: CupertinoDatePickerMode.dateAndTime,
//      minDate: DateTime.now(),
//      currentDate: DateTime.now(),
//      confirmTimeClick: (date) {
//        print("the date is ${date.toString()}");
//      },
//    ).show();
//  }

  _showPicker(BuildContext context, BrnDateTimePickerMode mode) {
    String format;
    const String MIN_DATETIME = '2020-01-15 00:00:00';
    const String MAX_DATETIME = '2021-12-31 23:59:59';
    switch (mode) {
      case BrnDateTimePickerMode.date:
        format = 'yyyy年,MMMM月,dd日';
        break;
      case BrnDateTimePickerMode.datetime:
        format = 'yyyy年,MM月,dd日,HH时:mm分:ss秒';
        break;
      case BrnDateTimePickerMode.time:
        format = 'HH:mm:ss';
        break;
      default:
        format = 'yyyy-MMMM-dd';
        break;
    }

    BrnDatePicker.showDatePicker(context,
        maxDateTime: DateTime.parse(MAX_DATETIME),
        minDateTime: DateTime.parse(MIN_DATETIME),
        initialDateTime: DateTime.parse('2020-01-01 18:26:59'),
        pickerMode: mode,
        minuteDivider: 30,
        pickerTitleConfig: BrnPickerTitleConfig.Default,
        dateFormat: format, onConfirm: (dateTime, list) {
      BrnToast.show("onConfirm:  $dateTime   $list", context);
    }, onClose: () {
      print("onClose");
    }, onCancel: () {
      print("onCancel");
    }, onChange: (dateTime, list) {
      print("onChange:  $dateTime    $list");
    });
  }

  _showRangePickerNoLimited(
      BuildContext context, BrnDateTimeRangePickerMode mode) {
    String format;
    const String MIN_DATETIME = '2020-01-01 00:00:00';
    const String MAX_DATETIME = '2020-12-31 23:59:59';
    format = 'HH时:mm分';
    BrnPickerTitleConfig timePickerTheme = BrnPickerTitleConfig(
        title: BrnPickerTitleConfig.Default.title,
        showTitle: pickerShowTitleDefault,
        titleContent: "选择时间范围");
    BrnDateRangePicker.showDatePicker(context,
        minDateTime: DateTime.parse(MIN_DATETIME),
        maxDateTime: DateTime.parse(MAX_DATETIME),
        pickerMode: mode,
        isLimitTimeRange: false,
        minuteDivider: 10,
        pickerTitleConfig: timePickerTheme,
        dateFormat: format,
        initialStartDateTime: DateTime(2020, 06, 21, 08, 00, 00),
        initialEndDateTime: DateTime(2020, 06, 23, 10, 00, 00),
        onConfirm: (startDateTime, endDateTime, startlist, endlist) {
      BrnToast.show(
          "onConfirm:  $startDateTime   $endDateTime     $startlist     $endlist",
          context);
    }, onClose: () {
      print("onClose");
    }, onCancel: () {
      print("onCancel");
    }, onChange: (startDateTime, endDateTime, startlist, endlist) {
      BrnToast.show(
          "onChange:  $startDateTime   $endDateTime     $startlist     $endlist",
          context);
    });
  }

  _showRangePicker(BuildContext context, BrnDateTimeRangePickerMode mode) {
    String format;
    const String MIN_DATETIME = '2020-01-01 00:00:00';
    const String MAX_DATETIME = '2020-12-31 23:59:59';
    switch (mode) {
      case BrnDateTimeRangePickerMode.date:
        format = 'MM月-dd日';
        BrnPickerTitleConfig pickerTitleConfig =
            BrnPickerTitleConfig(titleContent: "选择时间范围");
        BrnDateRangePicker.showDatePicker(context,
            isDismissible: false,
            minDateTime: DateTime.parse(MIN_DATETIME),
            maxDateTime: DateTime.parse(MAX_DATETIME),
            pickerMode: BrnDateTimeRangePickerMode.date,
            pickerTitleConfig: pickerTitleConfig,
            dateFormat: format,
            initialStartDateTime: DateTime(2021, 06, 21, 11, 00, 00),
            initialEndDateTime: DateTime(2021, 06, 23, 10, 00, 00),
            onConfirm: (startDateTime, endDateTime, startlist, endlist) {
          BrnToast.show(
              "onConfirm:  $startDateTime   $endDateTime     $startlist     $endlist",
              context);
        }, onClose: () {
          print("onClose");
        }, onCancel: () {
          print("onCancel");
        }, onChange: (startDateTime, endDateTime, startlist, endlist) {
          BrnToast.show(
              "onChange:  $startDateTime   $endDateTime     $startlist     $endlist",
              context);
        });
        break;

      case BrnDateTimeRangePickerMode.time:
        format = 'HH时:mm分';
        BrnPickerTitleConfig pickerTitleConfig =
            BrnPickerTitleConfig(titleContent: "选择时间范围");
        BrnDateRangePicker.showDatePicker(context,
            minDateTime: DateTime.parse(MIN_DATETIME),
            maxDateTime: DateTime.parse(MAX_DATETIME),
            pickerMode: mode,
            minuteDivider: 10,
            pickerTitleConfig: pickerTitleConfig,
            dateFormat: format,
            initialStartDateTime: DateTime(2020, 06, 21, 08, 00, 00),
            initialEndDateTime: DateTime(2020, 06, 23, 10, 00, 00),
            onConfirm: (startDateTime, endDateTime, startlist, endlist) {
          BrnToast.show(
              "onConfirm:  $startDateTime   $endDateTime     $startlist     $endlist",
              context);
        }, onClose: () {
          print("onClose");
        }, onCancel: () {
          print("onCancel");
        }, onChange: (startDateTime, endDateTime, startlist, endlist) {
          BrnToast.show(
              "onChange:  $startDateTime   $endDateTime     $startlist     $endlist",
              context);
        });
        break;
      default:
        break;
    }
  }

  void _showyyyyMMddRangePicker(BuildContext context) {
    String format = 'yyyy年-MM月-dd日';
    BrnPickerTitleConfig pickerTitleConfig =
        BrnPickerTitleConfig(titleContent: "选择时间范围");
    BrnDateRangePicker.showDatePicker(context,
        isDismissible: false,
        minDateTime: DateTime(2010, 06, 01, 00, 00, 00),
        maxDateTime: DateTime(2029, 07, 24, 23, 59, 59),
        pickerMode: BrnDateTimeRangePickerMode.date,
        minuteDivider: 10,
        pickerTitleConfig: pickerTitleConfig,
        dateFormat: format,
        initialStartDateTime: DateTime(2020, 06, 21, 11, 00, 00),
        initialEndDateTime: DateTime(2020, 06, 23, 10, 00, 00),
        onConfirm: (startDateTime, endDateTime, startlist, endlist) {
      BrnToast.show(
          "onConfirm:  $startDateTime   $endDateTime     $startlist     $endlist",
          context);
    }, onClose: () {
      print("onClose");
    }, onCancel: () {
      print("onCancel");
    }, onChange: (startDateTime, endDateTime, startlist, endlist) {
      BrnToast.show(
          "onChange:  $startDateTime   $endDateTime     $startlist     $endlist",
          context);
    });
  }
}
