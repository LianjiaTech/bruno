// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Used with [TabBar.indicator] to draw a horizontal line below the
/// selected tab.
///
/// The selected tab underline is inset from the tab's boundary by [insets].
/// The [borderSide] defines the line's color and weight.
///
/// The [TabBar.indicatorSize] property can be used to define the indicator's
/// bounds in terms of its (centered) widget with [TabIndicatorSize.label],
/// or the entire tab with [TabIndicatorSize.tab].
///
///
/// 建议将TabBar indicatorSize 指定为 TabBarIndicatorSize.tab,
class BrnFixedUnderlineIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const BrnFixedUnderlineIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
    this.width = 1.0,
    this.thickness = 1.0,
    this.color = Colors.white,
  }) : assert(width >= 1.0);

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the
  /// tab indicator's bounds in terms of its (centered) tab widget with
  /// [TabIndicatorSize.label], or the entire tab with [TabIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  final double width;
  final double thickness;
  final Color color;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is BrnFixedUnderlineIndicator) {
      return BrnFixedUnderlineIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is BrnFixedUnderlineIndicator) {
      return BrnFixedUnderlineIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _FixedUnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return _FixedUnderlinePainter(this, onChanged);
  }
}

class _FixedUnderlinePainter extends BoxPainter {
  _FixedUnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final BrnFixedUnderlineIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;

  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return Rect.fromLTWH(
      indicator.left,
      indicator.bottom - borderSide.width,
      indicator.width,
      borderSide.width,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator =
        _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.square;
    paint.color = decoration.color;
    paint.strokeWidth = decoration.thickness;
    double padding = (indicator.width - decoration.width) / 2;
    Offset left = Offset(indicator.left + padding, indicator.top);
    Offset right = Offset(indicator.right - padding, indicator.top);
    canvas.drawLine(left, right, paint);
  }
}
