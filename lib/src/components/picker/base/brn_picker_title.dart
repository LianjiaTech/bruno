

import 'package:bruno/src/components/picker/time_picker/brn_date_picker_constants.dart';
import 'package:bruno/src/components/picker/base/brn_picker_title_config.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';

/// DatePicker's title widget.
// ignore: must_be_immutable
class BrnPickerTitle extends StatelessWidget {
  final BrnPickerTitleConfig pickerTitleConfig;
  final DateVoidCallback onCancel, onConfirm;
  BrnPickerConfig? themeData;

  BrnPickerTitle({
    Key? key,
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
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: themeData!.titleHeight,
                    alignment: Alignment.center,
                    child: _renderCancelWidget(context),
                  ),
                  onTap: () {
                    this.onCancel();
                  },
                ),
                Text(
                  pickerTitleConfig.titleContent ??
                      BrnIntl.of(context).localizedResource.pleaseChoose,
                  style: themeData!.titleTextStyle.generateTextStyle(),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: themeData!.titleHeight,
                    alignment: Alignment.center,
                    child: _renderConfirmWidget(context),
                  ),
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
        BrnIntl.of(context).localizedResource.cancel,
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
        BrnIntl.of(context).localizedResource.done,
        style: textStyle,
        textAlign: TextAlign.right,
      );
    }
    return confirmWidget;
  }
}
