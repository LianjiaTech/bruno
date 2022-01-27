import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Picker 顶端 圆角装饰类，参考系统 [ClipRRect]，
/// [borderRadius] 默认值为 BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
class BrnPickerClipRRect extends ClipRRect {
  const BrnPickerClipRRect({
    Key? key,
    BorderRadius borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(8.0),
    ),
    Widget? child,
  }) : super(key: key, borderRadius: borderRadius, child: child);
}
