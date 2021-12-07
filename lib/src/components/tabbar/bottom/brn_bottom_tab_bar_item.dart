import 'dart:ui' show Color;

import 'package:flutter/material.dart';

/// 简述：[BrnBottomTabBar]中的单个选择按钮组件
/// 功能：为了每个Tab独立控制操作
/// 特别注意：Tab的右上角小红点可能不符合UI规范，可以使用BrnBadge小红点组件
class BrnBottomTabBarItem {
  const BrnBottomTabBarItem({
    @required this.icon,
    this.title,
    Widget activeIcon,
    this.backgroundColor,
    this.badge,
    this.badgeNo,
    this.maxBadgeNo = 99,
  })  : activeIcon = activeIcon ?? icon,
        assert(icon != null);

  /// 未选中时的icon
  final Widget icon;

  /// 选中时的icon
  final Widget activeIcon;

  /// Tab标题名
  final Widget title;

  /// 背景色
  final Color backgroundColor;

  /// 未读信息
  final Widget badge;

  /// 未读信息个数
  final String badgeNo;

  /// 未读消息最大个数
  final int maxBadgeNo;
}
