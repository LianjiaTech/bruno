import 'package:bindings_compatible/bindings_compatible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef OnWidgetSizeChange = void Function(Size size);

/// 监听 Widget 宽高的工具类。
class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = Size.zero;
    if (child != null) {
      newSize = child!.size;
    }
    if (oldSize == newSize) return;

    oldSize = newSize;

    useWidgetsBinding().addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

/// 监听 Widget 宽高变化的工具类
class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);
  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}
