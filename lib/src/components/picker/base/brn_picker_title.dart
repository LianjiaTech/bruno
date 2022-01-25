

import 'package:bruno/src/components/picker/time_picker/brn_date_picker_constants.dart';
import 'package:bruno/src/components/picker/base/brn_picker_title_config.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:bruno/src/utils/i18n/brn_date_picker_i18n.dart';
import 'package:flutter/material.dart';

/// DatePicker's title widget.

// ignore: must_be_immutable
class BrnPickerTitle extends StatelessWidget {
  final BrnPickerTitleConfig pickerTitleConfig;
  final DateTimePickerLocale? locale;
  final DateVoidCallback onCancel, onConfirm;
  BrnPickerConfig? themeData;

  BrnPickerTitle({
    Key? key,
    this.locale,
    required this.onCancel,
    required this.onConfirm,
    this.pickerTitleConfig = BrnPickerTitleConfig.Default,
    this.themeData,
  }) : super(key: key) {
    this.themeData ??= BrnPickerConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .pickerConfig
        .merge(this.themeData);
  }

  @override
  Widget build(BuildContext context) {
    if (pickerTitleConfig.title != null) {
      return pickerTitleConfig.title!;
    }
    return Container(
      height: themeData!.titleHeight,
      decoration: ShapeDecoration(
        color: themeData!.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(themeData!.cornerRadius),
            topRight: Radius.circular(themeData!.cornerRadius),
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: themeData!.titleHeight - 0.5,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: _renderCancelWidget(context),
                  onTap: () {
                    this.onCancel();
                  },
                ),
                Text(
                  pickerTitleConfig.titleContent,
                  style: themeData!.titleTextStyle.generateTextStyle(),
                ),
                GestureDetector(
                  child: _renderConfirmWidget(context),
                  onTap: () {
                    this.onConfirm();
                  },
                ),
              ],
            ),
          ),
          Divider(
            color: themeData!.dividerColor,
            indent: 0.0,
            height: 0.5,
          ),
        ],
      ),
    );
  }

  /// render cancel button widget
  Widget _renderCancelWidget(BuildContext context) {
    Widget? cancelWidget = pickerTitleConfig.cancel;
    if (cancelWidget == null) {
      TextStyle textStyle = themeData!.cancelTextStyle.generateTextStyle();
      cancelWidget = Text(
        '取消',
        style: textStyle,
        textAlign: TextAlign.left,
      );
    }
    return cancelWidget;
  }

  /// render confirm button widget
  Widget _renderConfirmWidget(BuildContext context) {
    Widget? confirmWidget = pickerTitleConfig.confirm;
    if (confirmWidget == null) {
      TextStyle textStyle = themeData!.confirmTextStyle.generateTextStyle();
      confirmWidget = Text(
        '完成',
        style: textStyle,
        textAlign: TextAlign.right,
      );
    }
    return confirmWidget;
  }
}
