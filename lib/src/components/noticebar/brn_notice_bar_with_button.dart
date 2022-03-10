import 'package:bruno/src/components/noticebar/brn_marquee_text.dart';
import 'package:flutter/material.dart';

/// 描述: 左边标签，右边按钮的通知
/// 1. 支持十种默认样式
/// 2. 支持设置或者隐藏左右图标
/// 3. 支持跑马灯

class BrnNoticeBarWithButton extends StatelessWidget {
  /// 通知的内容
  final String content;

  /// 通知的背景色
  final Color? backgroundColor;

  /// 通知的文字颜色
  final Color? contentTextColor;

  /// 左边标签的文字
  final String? leftTagText;

  /// 左边标签的文字颜色
  final Color? leftTagTextColor;

  /// 左边标签的背景颜色
  final Color? leftTagBackgroundColor;

  /// 自定义左边的控件
  final Widget? leftWidget;

  ///右边按钮的文字
  final String? rightButtonText;

  ///右边按钮的文字颜色
  final Color? rightButtonTextColor;

  ///右边按钮的边框颜色
  final Color? rightButtonBorderColor;

  /// 自定义右边的控件
  final Widget? rightWidget;

  /// 是否跑马灯
  /// 默认值false
  final bool marquee;

  /// 右边按钮点击回调
  final VoidCallback? onRightButtonTap;

  /// 最小高度。leftWidget、rightWidget 都为空时，限制的最小高度。
  /// 可以通过该属性控制组件高度，内容会自动垂直居中。默认值 54。
  final double minHeight;

  /// 内容的内边距
  final EdgeInsets? padding;

  const BrnNoticeBarWithButton(
      {Key? key,
      required this.content,
      this.backgroundColor,
      this.contentTextColor,
      this.leftTagText,
      this.leftTagBackgroundColor,
      this.leftTagTextColor,
      this.rightButtonBorderColor,
      this.rightButtonText,
      this.rightButtonTextColor,
      this.onRightButtonTap,
      this.marquee = false,
      this.leftWidget,
      this.rightWidget,
      this.padding,
      this.minHeight = 54})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 如果没有自定义视图，设置最小高度
    return Container(
      constraints: BoxConstraints(minHeight: this.minHeight),
      color: backgroundColor ?? Color(0x14FA5741),
      padding: this.padding ?? EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildLeftTag(),
          Expanded(
            child: _buildContent(),
          ),
          _buildRightBtn(),
        ],
      ),
    );
  }

  /// 左边的标签
  Widget _buildLeftTag() {
    if (leftWidget != null) {
      return leftWidget!;
    }

    if (leftTagText?.isEmpty ?? true) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(right: 8, top: 2),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: leftTagBackgroundColor ?? Color(0xFFFA5741),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          leftTagText!,
          style: TextStyle(
              color: leftTagTextColor ?? Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (content.isEmpty) {
      return Container();
    }

    if (marquee) {
      return BrnMarqueeText(
        height: 20,
        text: content,
        textStyle: TextStyle(
          color: contentTextColor ?? Color(0xFF333333),
          fontSize: 14,
        ),
      );
    } else {
      return Text(
        content,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: contentTextColor ?? Color(0xFF333333),
          fontSize: 14,
        ),
      );
    }
  }

  /// 右边的按钮
  Widget _buildRightBtn() {
    if (rightWidget != null) {
      return rightWidget!;
    }

    if (rightButtonText?.isEmpty ?? true) {
      return Container();
    }
    return GestureDetector(
      onTap: () {
        if (onRightButtonTap != null) {
          onRightButtonTap!();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 8),
        child: Container(
          height: 30,
          alignment: Alignment.center,
          constraints: BoxConstraints(
            minWidth: 56,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: rightButtonBorderColor ?? Color(0xFFFA5741),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            rightButtonText!,
            style: TextStyle(
              color: rightButtonTextColor ?? Color(0xFFFA5741),
              fontSize: 12,
              height: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
