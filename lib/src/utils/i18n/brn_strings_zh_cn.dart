part of 'brn_date_picker_i18n.dart';

/// Chinese (ZH) Simplified
class _StringsZhCn extends _StringsI18n {
  const _StringsZhCn();

  @override
  String getCancelText() {
    return '取消';
  }

  @override
  String getDoneText() {
    return '确定';
  }

  @override
  List<String> getMonths() {
    return ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
  }

  @override
  List<String> getWeeksFull() {
    return [
      "星期一",
      "星期二",
      "星期三",
      "星期四",
      "星期五",
      "星期六",
      "星期日",
    ];
  }

  @override
  List<String> getWeeksShort() {
    return [
      "周一",
      "周二",
      "周三",
      "周四",
      "周五",
      "周六",
      "周日",
    ];
  }
}
