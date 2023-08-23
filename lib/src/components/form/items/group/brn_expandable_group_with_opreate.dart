import 'package:bruno/src/components/form/items/group/element_expand_widget.dart';
import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/components/line/brn_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///
/// 可展开收起组类型录入项
/// 内部可包含其他类型Widget
///
/// 包括"标题"、"副标题"、"错误信息提示"、"必填项提示"、"添加/删除按钮"、"消息提示"
///
// ignore: must_be_immutable
class BrnExpandFormGroup extends StatefulWidget {
  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String? label;

  /// 录入项标题
  final String title;

  /// 录入项子标题
  final String? subTitle;

  /// 录入项错误提示
  final String error;

  /// 录入项是否为必填项（展示*图标） 默认为 false 不必填
  final bool isRequire;

  /// 录入项 是否可编辑
  final bool isEdit;

  /// 点击"-"图标回调
  final VoidCallback? onRemoveTap;

  /// 点击"？"图标回调
  final VoidCallback? onTip;

  /// 初始是否为展开状态
  final bool isExpand;

  /// 右侧文案
  final String? deleteLabel;

  /// 内部子项
  final List<Widget> children;

  /// The color to display behind the sublist when expanded.
  final Color? backgroundColor;



  BrnExpandFormGroup({
    Key? key,
    this.label,
    this.title = "",
    this.subTitle,
    this.error = "",
    this.isEdit = true,
    this.isRequire = false,
    this.onRemoveTap,
    this.onTip,
    this.isExpand = true,
    this.deleteLabel,
    this.backgroundColor,
    required this.children,
  }) : super(key: key);

  @override
  BrnExpandFormGroupState createState() {
    return BrnExpandFormGroupState();
  }
}

class BrnExpandFormGroupState extends State<BrnExpandFormGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionElementWidget(
        title: widget.title,
        subtitle: widget.subTitle,
        deleteText: widget.deleteLabel,
        initiallyExpanded: widget.isExpand,
        backgroundColor: widget.backgroundColor,
        children: getSubItem(),
        callback: () {
          if (!BrnFormUtil.isEdit(widget.isEdit)) {
            return;
          }

          BrnFormUtil.notifyRemoveTap(context, widget.onRemoveTap);
        },
      ),
    );
  }

  List<Widget> getSubItem() {
    List<Widget> result = [];

    if (widget.children.isEmpty) {
      return result;
    }

    for (Widget w in widget.children) {
      result.add(BrnLine());
      result.add(w);
    }

    return result;
  }
}
