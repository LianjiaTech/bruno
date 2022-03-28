import 'package:flutter/material.dart';

/// 简述：[BrnBottomTabBar]中的单个选择按钮组件
/// 功能：为了每个Tab独立控制操作
/// 特别注意：Tab的右上角小红点可能不符合UI规范，可以使用BrnBadge小红点组件
class BrnBottomTabBarItem {
  const BrnBottomTabBarItem({
    this.title,
    required this.icon,
    Widget? activeIcon,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    this.backgroundColor,
    this.badge,
    this.badgeNo,
    this.maxBadgeNo = 99,
  }) : activeIcon = activeIcon ?? icon;

  /// Tab标题名
  final Widget? title;

  /// 未选中时的icon
  final Widget icon;

  /// 选中时的icon
  final Widget activeIcon;

  /// tab 选中文本样式
  final TextStyle? selectedTextStyle;

  /// tab 未选中文本样式
  final TextStyle? unSelectedTextStyle;

  /// 背景色
  final Color? backgroundColor;

  /// 未读信息
  final Widget? badge;

  /// 未读信息个数
  final String? badgeNo;

  /// 未读消息最大个数
  final int maxBadgeNo;
}
