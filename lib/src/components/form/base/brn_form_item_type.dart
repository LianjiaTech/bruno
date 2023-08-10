

import 'package:flutter/material.dart';

class BrnPrefixIconType {
  /// 普通类型 不加任何图标
  static const String normal = "type_normal";

  /// 添加表单类型
  static const String add = "type_add";

  /// 删除表单类型
  static const String remove = "type_remove";
}

///
/// 输入类型 对应 [TextField] TextInputType
///
class BrnInputType {

  /// [TextInputType.text]
  static const String text = "text";

  /// [TextInputType.multiline]
  static const String multiLine = "multiline";

  /// [TextInputType.number]
  static const String number = "number";

  /// [TextInputType.numberWithOptions]  attribute decimal is true
  static const String decimal = "decimal";

  /// [TextInputType.phone]
  static const String phone = "phone";

  /// [TextInputType.datetime]
  static const String date = "datetime";

  /// [TextInputType.emailAddress]
  static const String email = "emailAddress";

  /// [TextInputType.url]
  static const String url = "url";

  /// [TextInputType.visiblePassword]
  static const String pwd = "visiblePassword";
}
