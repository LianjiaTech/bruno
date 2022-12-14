import 'package:bruno/src/components/button/brn_big_main_button.dart';
import 'package:bruno/src/components/dialog/brn_dialog.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_dialog_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

class BrnDialogConstants {
  /// 提示图标
  static const int iconAlert = 0;

  /// 警示图标
  static const int iconWarning = 1;

  /// 成功图标
  static const int iconSuccess = 2;

  /// 自定义图标
  static const int iconCustom = 100;

  /// icon地址列表
  static const List shareItemImagePathList = [
    BrnAsset.iconAlert,
    BrnAsset.iconWarning,
    BrnAsset.iconSuccess,
  ];
}

/// 用于显示在屏幕中间展示重要信息，具有强操作的提示dialog
/// 含有纵向单按钮和双按钮
// ignore: must_be_immutable
class BrnEnhanceOperationDialog extends StatelessWidget {
  /// 构建环境上下文
  final BuildContext context;

  /// 图片类型，默认 0，[BrnDialogConstants.iconAlert]
  final int iconType;

  /// 自定义图标
  final Widget? customIconWidget;

  /// 弹框标题文案，为空则不显示标题
  final String? titleText;

  /// 弹框辅助信息文案，为空则不显示辅助信息
  final String? descText;

  /// 主要按钮文本
  final String? mainButtonText;

  /// 次要按钮文案，为空则不显示次要按钮
  final String? secondaryButtonText;

  /// 主要按钮回调
  final VoidCallback? onMainButtonClick;

  /// 次要按钮回调
  final VoidCallback? onSecondaryButtonClick;

  /// 主题配置
  BrnDialogConfig? themeData;

  BrnEnhanceOperationDialog({
    this.iconType = BrnDialogConstants.iconAlert,
    this.customIconWidget,
    required this.context,
    this.titleText,
    this.descText,
    this.mainButtonText,
    this.secondaryButtonText,
    this.onMainButtonClick,
    this.onSecondaryButtonClick,
    this.themeData,
  }) {
    this.themeData ??= BrnDialogConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .dialogConfig
        .merge(this.themeData);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: BrnDialog(
        themeData: themeData,
        iconImage: (iconType == BrnDialogConstants.iconCustom)
            ? customIconWidget as Image
            : BrunoTools.getAssetImage(
                BrnDialogConstants.shareItemImagePathList[iconType]),
        titleText: titleText,
        messageText: descText,
        warningWidget: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _configDialogWidgets(context),
          ),
        ),
      ),
    );
  }

  /// 弹出dialog
  show() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return this;
        }).then((value) {
      if (value == mainButtonText) {
        if (onMainButtonClick != null) {
          onMainButtonClick!();
        }
      } else {
        if (onSecondaryButtonClick != null) {
          onSecondaryButtonClick!();
        }
      }
    });
  }

  /// 构建widgets框架
  List<Widget> _configDialogWidgets(BuildContext context) {
    List<Widget> widgets = [];
    //分割
    widgets.add(Container(
      height: 16,
      color: Colors.transparent,
    ));
    // 主要按钮
    widgets.add(_configMainButton(context));
    // 次要按钮相关
    if (secondaryButtonText != null) {
      //分割
      widgets.add(Container(
        height: 16,
        color: Colors.transparent,
      ));
      //次要按钮
      widgets.add(_configSecondaryButton(context));
    }
    return widgets;
  }

  /// 构建主按钮widget
  Widget _configMainButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: BrnBigMainButton(
        title: mainButtonText ?? BrnIntl.of(context).localizedResource.confirm,
        onTap: () {
          Navigator.of(context).pop(mainButtonText ?? BrnIntl.of(context).localizedResource.confirm);
        },
      ),
    );
  }

  /// 构建次按钮widget
  Widget _configSecondaryButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          child: Text(
            secondaryButtonText!,
            style: TextStyle(
              color: themeData!.commonConfig.brandPrimary,
              fontSize: 16,
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop(onSecondaryButtonClick);
        },
      ),
    );
  }
}
