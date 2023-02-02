import 'package:flutter/material.dart';

import 'package:bruno/src/components/picker/base/brn_picker_constants.dart';

class BrnPickerTitleConfig {
  /// DateTimePicker theme.
  ///
  /// [cancel] Custom cancel widget.
  /// [confirm] Custom confirm widget.
  /// [title] Custom title widget. If specify a title widget, the cancel and confirm widgets will not display. Must set [titleHeight] value for custom title widget.
  /// [showTitle] Whether display title widget or not. If set false, the default cancel and confirm widgets will not display, but the custom title widget will display if had specified one custom title widget.
  /// [titleContent] Title content
  const BrnPickerTitleConfig({
    this.cancel,
    this.confirm,
    this.title,
    this.showTitle = pickerShowTitleDefault,
    this.titleContent,
  });

  static const BrnPickerTitleConfig Default = const BrnPickerTitleConfig();

  /// Custom cancel [Widget].
  final Widget? cancel;

  /// Custom confirm [Widget].
  final Widget? confirm;

  /// Custom title [Widget]. If specify a title widget, the cancel and confirm widgets will not display.
  final Widget? title;

  /// Whether display title widget or not. If set false, the default cancel and confirm widgets will not display, but the custom title widget will display if had specified one custom title widget.
  final bool showTitle;

  final String? titleContent;

  BrnPickerTitleConfig copyWith({
    Widget? cancel,
    Widget? confirm,
    Widget? title,
    bool? showTitle,
    String? titleContent,
  }) {
    return BrnPickerTitleConfig(
      cancel: cancel ?? this.cancel,
      confirm: confirm ?? this.confirm,
      title: title ?? this.title,
      showTitle: showTitle ?? this.showTitle,
      titleContent: titleContent ?? this.titleContent,
    );
  }
}
