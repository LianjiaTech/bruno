import 'dart:math' as math;

part 'brn_strings_zh_cn.dart';

abstract class _StringsI18n {
  const _StringsI18n();

  /// Get the done widget text
  String getDoneText();

  /// Get the cancel widget text
  String getCancelText();

  /// Get the name of month
  List<String> getMonths();

  /// Get the full name of week
  List<String> getWeeksFull();

  /// Get the short name of week
  List<String> getWeeksShort();
}

enum DateTimePickerLocale {
  /// English (EN) United States
  en_us,

  /// Chinese (ZH) Simplified
  zh_cn,

  /// Portuguese (PT) Brazil
  pt_br,

  /// Spanish (ES)
  es,

  /// Romanian (RO)
  ro,

  /// Bengali (BN)
  bn,

  /// Arabic (ar)
  ar,

  /// Japanese (JP)
  jp,

  /// Russian (RU)
  ru,

  /// German (DE)
  de,

  /// Korea (KO)
  ko,

  /// Italian (IT)
  it,

  /// Hungarian (HU)
  hu,
}

/// Default value of date locale
const DateTimePickerLocale datetimePickerLocaleDefault =
    DateTimePickerLocale.zh_cn;

const Map<DateTimePickerLocale, _StringsI18n> datePickerI18n = {
  DateTimePickerLocale.zh_cn: _StringsZhCn(),
};

class DatePickerI18n {
  const DatePickerI18n._();

  /// Get done button text
  static String getLocaleDone(DateTimePickerLocale locale) {
    final _StringsI18n? i18n =
        datePickerI18n[locale] ?? datePickerI18n[datetimePickerLocaleDefault];
    return i18n?.getDoneText() ??
        datePickerI18n[datetimePickerLocaleDefault]!.getDoneText();
  }

  /// Get cancel button text
  static String getLocaleCancel(DateTimePickerLocale locale) {
    final _StringsI18n? i18n =
        datePickerI18n[locale] ?? datePickerI18n[datetimePickerLocaleDefault];
    return i18n?.getCancelText() ??
        datePickerI18n[datetimePickerLocaleDefault]!.getCancelText();
  }

  /// Get locale month array
  static List<String> getLocaleMonths(DateTimePickerLocale locale) {
    final _StringsI18n? i18n =
        datePickerI18n[locale] ?? datePickerI18n[datetimePickerLocaleDefault];
    final List<String>? months = i18n?.getMonths();
    if (months != null && months.isNotEmpty) {
      return months;
    }
    return datePickerI18n[datetimePickerLocaleDefault]!.getMonths();
  }

  /// Get locale week array
  static List<String> getLocaleWeeks(
    DateTimePickerLocale locale, [
    bool isFull = true,
  ]) {
    final _StringsI18n? i18n =
        datePickerI18n[locale] ?? datePickerI18n[datetimePickerLocaleDefault];
    if (isFull) {
      final List<String>? weeks = i18n?.getWeeksFull();
      if (weeks != null && weeks.isNotEmpty) {
        return weeks;
      }
      return datePickerI18n[datetimePickerLocaleDefault]!.getWeeksFull();
    }

    final List<String>? weeks = i18n?.getWeeksShort();
    if (weeks != null && weeks.isNotEmpty) {
      return weeks;
    }

    final List<String>? fullWeeks = i18n?.getWeeksFull();
    if (fullWeeks != null && fullWeeks.isNotEmpty) {
      return fullWeeks
          .map((item) => item.substring(0, math.min(3, item.length)))
          .toList();
    }
    return datePickerI18n[datetimePickerLocaleDefault]!.getWeeksShort();
  }
}
