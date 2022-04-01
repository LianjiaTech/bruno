

import 'package:bruno/src/components/form/base/brn_form_item_type.dart';
import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/constants/brn_fonts_constants.dart';
import 'package:flutter/material.dart';

/// 添加组类型录入项所使用的Widget
// ignore: must_be_immutable
class BrnAddLabel extends StatefulWidget {
  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String? label;

  /// 录入项类型，主要用于录入类型页面框架中
  final String type = BrnInputItemType.labelAdd;

  /// 标题文案
  final String title;

  /// 是否可编辑
  final bool isEdit;

  /// 点击录入区回调
  final VoidCallback? onTap;

  BrnAddLabel({
    Key? key,
    this.label,
    this.title = "",
    this.isEdit = true,
    this.onTap,
  }) : super(key: key);

  @override
  BrnAddLabelState createState() {
    return BrnAddLabelState();
  }
}

class BrnAddLabelState extends State<BrnAddLabel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!BrnFormUtil.isEdit(widget.isEdit)) {
          return;
        }

        BrnFormUtil.notifyAddTap(context, widget.onTap);
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
        child: Text(
          widget.title,
          style: TextStyle(
            color: BrnThemeConfigurator.instance
                .getConfig()
                .commonConfig
                .brandPrimary,
            fontSize: BrnFonts.f18,
          ),
        ),
      ),
    );
  }
}
