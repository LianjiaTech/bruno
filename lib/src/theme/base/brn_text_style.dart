import 'package:flutter/material.dart';

///  TextStyle处理类  用来将内部属性重新赋值进行copyWith 和 merge操作
class BrnTextStyle {
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  TextDecoration? decoration;
  double? height;
  TextBaseline? textBaseline;

  BrnTextStyle({
    this.color,
    this.fontSize,
    this.fontWeight,
    this.decoration,
    this.textBaseline,
    this.height,
  });

  BrnTextStyle.withStyle(TextStyle? style) {
    if (style == null) {
      return;
    }
    if (style.color != null) {
      this.color = style.color;
    }
    if (style.fontSize != null) {
      this.fontSize = style.fontSize;
    }
    if (style.fontWeight != null) {
      this.fontWeight = style.fontWeight;
    }
    if (style.decoration != null) {
      this.decoration = style.decoration;
    }
    if (style.height != null) {
      this.height = style.height;
    }
    if (style.textBaseline != null) {
      this.textBaseline = style.textBaseline;
    }
  }

  TextStyle generateTextStyle() {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration ?? TextDecoration.none,
      height: height,
      textBaseline: textBaseline,
    );
  }

  void flatTextStyle(BrnTextStyle? defaultTextStyle) {
    if (defaultTextStyle == null) {
      return;
    }
    if (defaultTextStyle.color != null) {
      this.color ??= defaultTextStyle.color;
    }
    if (defaultTextStyle.fontSize != null) {
      this.fontSize ??= defaultTextStyle.fontSize;
    }
    if (defaultTextStyle.fontWeight != null) {
      this.fontWeight ??= defaultTextStyle.fontWeight;
    }
    if (defaultTextStyle.decoration != null) {
      this.decoration ??= defaultTextStyle.decoration;
    }
    if (defaultTextStyle.height != null) {
      this.height ??= defaultTextStyle.height;
    }
    if (defaultTextStyle.textBaseline != null) {
      this.textBaseline ??= defaultTextStyle.textBaseline;
    }
  }

  BrnTextStyle copyWith(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      TextDecoration? decoration,
      double? height,
      TextBaseline? textBaseline}) {
    return BrnTextStyle(
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      decoration: decoration ?? this.decoration,
      height: height ?? this.height,
      textBaseline: textBaseline ?? this.textBaseline,
    );
  }

  BrnTextStyle merge(BrnTextStyle? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      fontSize: other.fontSize,
      fontWeight: other.fontWeight,
      decoration: other.decoration,
      height: other.height,
      textBaseline: other.textBaseline,
    );
  }
}
