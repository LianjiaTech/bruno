import 'package:bruno/src/components/noticebar/brn_marquee_text.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 描述: 通知，默认最小高度36
/// 1. 支持十种默认样式
/// 2. 支持设置或者隐藏左右图标
/// 3. 支持跑马灯

class BrnNoticeBar extends StatelessWidget {
  /// 自定义左边的图标
  final Widget? leftWidget;

  /// 是否显示左边的图标
  final bool showLeftIcon;

  /// 通知的内容
  final String content;

  /// 通知的文字颜色
  final Color? textColor;

  /// 背景颜色
  final Color? backgroundColor;

  /// 右边的图标
  final Widget? rightWidget;

  /// 是否显示右边的图标
  /// 默认值true
  final bool showRightIcon;

  /// 默认样式，取[NoticeStyles]里面的值
  final NoticeStyle? noticeStyle;

  /// 是否跑马灯
  /// 默认值false
  final bool marquee;

  /// 通知钮点击的回调
  final VoidCallback? onNoticeTap;

  /// 右侧图标点击的回调
  final VoidCallback? onRightIconTap;

  /// 最小高度。leftWidget、rightWidget 都为空时，限制的最小高度。
  /// 可以通过该属性控制组件高度，内容会自动垂直居中。
  /// 默认值 36。
  final double minHeight;

  /// 内容的内边距
  final EdgeInsets? padding;

  const BrnNoticeBar(
      {Key? key,
      this.leftWidget,
      this.showLeftIcon = true,
      required this.content,
      this.textColor,
      this.backgroundColor,
      this.rightWidget,
      this.showRightIcon = true,
      this.noticeStyle,
      this.onNoticeTap,
      this.onRightIconTap,
      this.marquee = false,
      this.padding,
      this.minHeight = 36})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoticeStyle defaultStyle = NoticeStyles.runningWithArrow;

    Widget tempRightWidget =
        rightWidget ?? (noticeStyle?.rightIcon ?? defaultStyle.leftIcon);
    if (onRightIconTap != null) {
      tempRightWidget = GestureDetector(
        child: tempRightWidget,
        onTap: () {
          onRightIconTap!();
        },
      );
    }

    Widget contentWidget;
    if (marquee) {
      contentWidget = BrnMarqueeText(
        height: 36,
        text: content,
        textStyle: TextStyle(
          color:
              textColor ?? (noticeStyle?.textColor ?? defaultStyle.textColor),
          fontSize: 14,
        ),
      );
    } else {
      contentWidget = Text(
        content,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color:
              textColor ?? (noticeStyle?.textColor ?? defaultStyle.textColor),
          fontSize: 14,
        ),
      );
    }

    return Container(
      color: backgroundColor ??
          (noticeStyle != null
              ? noticeStyle!.backgroundColor
              : defaultStyle.backgroundColor),
      padding: this.padding ?? EdgeInsets.symmetric(horizontal: 20),
      constraints: BoxConstraints(minHeight: this.minHeight),
      child: GestureDetector(
        onTap: () {
          if (onNoticeTap != null) {
            onNoticeTap!();
          }
        },
        child: Row(
          children: <Widget>[
            Offstage(
              offstage: !showLeftIcon,
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: leftWidget ??
                    (noticeStyle?.leftIcon ?? defaultStyle.leftIcon),
              ),
            ),
            Expanded(
              child: contentWidget,
            ),
            Offstage(
              offstage: !showRightIcon,
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: tempRightWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 默认通知样式集合，共十种
class NoticeStyles {
  ///红色+失败+箭头
  static NoticeStyle failWithArrow = NoticeStyle(
      BrunoTools.getAssetImage(BrnAsset.iconNoticeFail),
      Color(0xFFFA3F3F),
      Color(0xFFFEEDED),
      BrunoTools.getAssetImage(BrnAsset.iconNoticeArrowRed));

  ///红色+失败+关闭
  static NoticeStyle failWithClose = NoticeStyle(
      BrunoTools.getAssetImage(BrnAsset.iconNoticeFail),
      Color(0xFFFA3F3F),
      Color(0xFFFEEDED),
      BrunoTools.getAssetImage(BrnAsset.iconNoticeCloseRed));

  ///蓝色+进行中+箭头
  static NoticeStyle runningWithArrow = NoticeStyle(
      BrunoTools.getAssetImage(BrnAsset.iconNoticeRunning),
      Color(0xFF0984F9),
      Color(0xFFE0EDFF),
      BrunoTools.getAssetImage(BrnAsset.iconNoticeArrowBlue));

  ///蓝色+进行中+关闭
  static NoticeStyle runningWithClose = NoticeStyle(
      BrunoTools.getAssetImage(BrnAsset.iconNoticeRunning),
      Color(0xFF0984F9),
      Color(0xFFE0EDFF),
      BrunoTools.getAssetImage(BrnAsset.iconNoticeCloseBlue));

  ///绿色+完成+箭头
  static NoticeStyle succeedWithArrow = NoticeStyle(
      BrunoTools.getAssetImage(BrnAsset.iconNoticeSucceed),
      Color(0xFF00AE66),
      Color(0xFFEBFFF7),
      BrunoTools.getAssetImage(BrnAsset.iconNoticeArrowGreen));

  ///绿色+完成+关闭
  static NoticeStyle succeedWithClose = NoticeStyle(
      BrunoTools.getAssetImage(BrnAsset.iconNoticeSucceed),
      Color(0xFF00AE66),
      Color(0xFFEBFFF7),
      BrunoTools.getAssetImage(BrnAsset.iconNoticeCloseGreen));

  ///橘色+警告+箭头
  static NoticeStyle warningWithArrow = NoticeStyle(
      BrunoTools.getAssetImage(BrnAsset.iconNoticeWarning),
      Color(0xFFFAAD14),
      Color(0xFFFDFCEC),
      BrunoTools.getAssetImage(BrnAsset.iconNoticeArrowOrange));

  ///橘色+警告+关闭
  static NoticeStyle warningWithClose = NoticeStyle(
      BrunoTools.getAssetImage(BrnAsset.iconNoticeWarning),
      Color(0xFFFAAD14),
      Color(0xFFFDFCEC),
      BrunoTools.getAssetImage(BrnAsset.iconNoticeCloseOrange));

  ///橘色+通知+箭头
  static NoticeStyle normalNoticeWithArrow = NoticeStyle(
      BrunoTools.getAssetImage(BrnAsset.iconNotice),
      Color(0xFFFAAD14),
      Color(0xFFFDFCEC),
      BrunoTools.getAssetImage(BrnAsset.iconNoticeArrowOrange));

  ///橘色+通知+关闭
  static NoticeStyle normalNoticeWithClose = NoticeStyle(
      BrunoTools.getAssetImage(BrnAsset.iconNotice),
      Color(0xFFFAAD14),
      Color(0xFFFDFCEC),
      BrunoTools.getAssetImage(BrnAsset.iconNoticeCloseOrange));
}

/// 通知样式
class NoticeStyle {
  ///左边的图标
  final Widget leftIcon;

  ///通知的文字颜色
  final Color textColor;

  ///背景颜色
  final Color backgroundColor;

  ///右边的图标
  final Widget rightIcon;

  NoticeStyle(
      this.leftIcon, this.textColor, this.backgroundColor, this.rightIcon);
}
