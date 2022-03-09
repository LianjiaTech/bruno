import 'package:bruno/src/utils/css/brn_core_funtion.dart';
import 'package:flutter/material.dart';

/// 将CSS格式的标签转为文本
class BrnCSS2Text {
  const BrnCSS2Text._();

  static TextSpan toTextSpan(
    String htmlContent, {
    BrnHyperLinkCallback? linksCallback,
    TextStyle? defaultStyle,
  }) {
    return TextSpan(
      children: BrnConvert(
        htmlContent,
        linkCallBack: linksCallback,
        defaultStyle: defaultStyle,
      ).convert(),
    );
  }

  static Text toTextView(
    String htmlContent, {
    BrnHyperLinkCallback? linksCallback,
    TextStyle? defaultStyle,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
  }) {
    return Text.rich(
      toTextSpan(
        htmlContent,
        linksCallback: linksCallback,
        defaultStyle: defaultStyle,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow ?? TextOverflow.clip,
    );
  }
}
