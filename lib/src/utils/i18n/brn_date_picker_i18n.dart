import 'dart:math';

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
const DateTimePickerLocale DATETIME_PICKER_LOCALE_DEFAULT = DateTimePickerLocale.zh_cn;

const Map<DateTimePickerLocale, _StringsI18n> datePickerI18n = {
  DateTimePickerLocale.zh_cn: const _StringsZhCn(),
};

class DatePickerI18n {
  /// Get done button text
  static String getLocaleDone(DateTimePickerLocale locale) {
    _StringsI18n i18n = datePickerI18n[locale] ?? datePickerI18n[DATETIME_PICKER_LOCALE_DEFAULT];
    return i18n.getDoneText() ?? datePickerI18n[DATETIME_PICKER_LOCALE_DEFAULT].getDoneText();
  }

  /// Get cancel button text
  static String getLocaleCancel(DateTimePickerLocale locale) {
    _StringsI18n i18n = datePickerI18n[locale] ?? datePickerI18n[DATETIME_PICKER_LOCALE_DEFAULT];
    return i18n.getCancelText() ?? datePickerI18n[DATETIME_PICKER_LOCALE_DEFAULT].getCancelText();
  }

  /// Get locale month array
  static List<String> getLocaleMonths(DateTimePickerLocale locale) {
    _StringsI18n i18n = datePickerI18n[locale] ?? datePickerI18n[DATETIME_PICKER_LOCALE_DEFAULT];
    List<String> months = i18n.getMonths();
    if (months != null && months.isNotEmpty) {
      return months;
    }
    return datePickerI18n[DATETIME_PICKER_LOCALE_DEFAULT].getMonths();
  }

  /// Get locale week array
  static List<String> getLocaleWeeks(DateTimePickerLocale locale, [bool isFull = true]) {
    _StringsI18n i18n = datePickerI18n[locale] ?? datePickerI18n[DATETIME_PICKER_LOCALE_DEFAULT];
    if (isFull) {
      List<String> weeks = i18n.getWeeksFull();
      if (weeks != null && weeks.isNotEmpty) {
        return weeks;
      }
      return datePickerI18n[DATETIME_PICKER_LOCALE_DEFAULT].getWeeksFull();
    }

    List<String> weeks = i18n.getWeeksShort();
    if (weeks != null && weeks.isNotEmpty) {
      return weeks;
    }

    List<String> fullWeeks = i18n.getWeeksFull();
    if (fullWeeks != null && fullWeeks.isNotEmpty) {
      return fullWeeks.map((item) => item.substring(0, min(3, item.length))).toList();
    }
    return datePickerI18n[DATETIME_PICKER_LOCALE_DEFAULT].getWeeksShort();
  }
}
