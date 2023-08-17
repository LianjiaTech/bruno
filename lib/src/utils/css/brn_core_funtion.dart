import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/utils/css/brn_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml_events.dart' as xml;

/// 超链接的点击回调
typedef BrnHyperLinkCallback = void Function(String text, String? url);

/// 用于将 HTML 标签转为 style
class BrnConvert {

  /// [cssContent] 带有html 标签文本
  /// [linkCallBack] 超链接的点击回调
  /// [defaultStyle] 外部传入的默认文本样式
  BrnConvert(
    String cssContent, {
    BrnHyperLinkCallback? linkCallBack,
    TextStyle? defaultStyle,
  }) {
    _eventList = xml.parseEvents(cssContent);
    _linkCallBack = linkCallBack ?? null;
    _defaultStyle = defaultStyle;
  }

  /// 超链接的点击回调
  BrnHyperLinkCallback? _linkCallBack;

  /// 外部传入的默认文本样式
  TextStyle? _defaultStyle;

  /// 标签的集合
  Iterable<xml.XmlEvent> _eventList = [];

  /// 标签对应的style
  List<_Tag> stack = [];

  /// 转换的思路：将 开始标签 的属性转为 合适的style, 并将其存入集合中
  ///             a开始标签支持的属性：href
  ///           文本标签 去获取style集合的最后一个元素 并应用style样式
  ///           结束标签 则将集合的最后一个元素删除
  List<TextSpan> convert() {
    // 优先使用外部提供的样式
    final TextStyle style = _defaultStyle ??
        TextStyle(
          fontSize: 14,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.normal,
          color: BrnThemeConfigurator.instance
              .getConfig()
              .commonConfig
              .colorTextImportant,
        );

    final List<TextSpan> spans = [];
    _eventList.forEach((xmlEvent) {
      if (xmlEvent is xml.XmlStartElementEvent) {
        if (!xmlEvent.isSelfClosing) {
          final _Tag tag = _Tag();
          TextStyle textStyle = style.copyWith();
          if (xmlEvent.name == 'font') {
            xmlEvent.attributes.forEach((attr) {
              switch (attr.name) {
                case 'color':
                  textStyle = textStyle.apply(
                    color: BrnConvertUtil.generateColorByString(attr.value),
                  );
                  break;
                case 'weight':
                  FontWeight fontWeight =
                      BrnConvertUtil.generateFontWidgetByString(attr.value);
                  textStyle = textStyle.apply(
                    fontWeightDelta: fontWeight.index - FontWeight.normal.index,
                  );
                  break;
                case 'size':
                  textStyle = textStyle.apply(
                    fontSizeDelta:
                        BrnConvertUtil.generateFontSize(attr.value) - 13,
                  );
                  break;
              }
            });
            tag.isLink = false;
          }

          if (xmlEvent.name == 'strong') {
            tag.isLink = false;
            textStyle = textStyle.apply(fontWeightDelta: 2);
          }

          if (xmlEvent.name == 'a') {
            tag.isLink = true;
            xmlEvent.attributes.forEach((attr) {
              switch (attr.name) {
                case 'href':
                  textStyle = textStyle.apply(
                    color: BrnThemeConfigurator.instance
                        .getConfig()
                        .commonConfig
                        .brandPrimary,
                  );
                  tag.linkUrl = attr.value;
                  break;
              }
            });
          }
          tag.name = xmlEvent.name;
          tag.style = textStyle;
          stack.add(tag);
        } else {
          if (xmlEvent.name == 'br') {
            spans.add(TextSpan(text: '\n'));
          }
        }
      }

      if (xmlEvent is xml.XmlTextEvent) {
        _Tag tag = _Tag();
        tag.style = style.copyWith();
        if (stack.isNotEmpty) {
          tag = stack.last;
        }
        TextSpan textSpan = _createTextSpan(xmlEvent.value, tag);
        spans.add(textSpan);
      }

      if (xmlEvent is xml.XmlEndElementEvent) {
        _Tag top = stack.removeLast();
        if (top.name != xmlEvent.name) {
          debugPrint('Error format HTML');
          return;
        }
      }
    });

    return spans;
  }

  TextSpan _createTextSpan(String text, _Tag tag) {
    if (text.isEmpty) return TextSpan(text: '');
    final TapGestureRecognizer recognizer = TapGestureRecognizer()
      ..onTap = () {
        _linkCallBack?.call(text, tag.linkUrl);
      };
    return TextSpan(
      style: tag.style,
      text: text,
      recognizer: tag.isLink ? recognizer : null,
    );
  }
}

class _Tag {
  String? name;
  TextStyle? style;
  String? linkUrl;
  bool isLink = false;
}
