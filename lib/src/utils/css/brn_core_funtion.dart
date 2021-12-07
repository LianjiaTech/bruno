import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/utils/css/brn_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml_events.dart' as xml;

typedef BrnHyperLinkCallback = Function(String text, String url);

//用于将标签转为 style
class BrnConvert {
  //超链接的点击回调
  BrnHyperLinkCallback _linkCallBack;

  //标签的集合
  Iterable<xml.XmlEvent> _eventList = [];

  //标签对应的style
  List<Tag> stack = [];

  //外部传入的默认文本样式
  TextStyle _defaultStyle;

  BrnConvert(String cssContent, {Function linkCallBack, TextStyle defaultStyle}) {
    _eventList = xml.parseEvents(cssContent);
    _linkCallBack = linkCallBack ?? null;
    _defaultStyle = defaultStyle;
  }

  //转换的思路：将 开始标签 的属性转为 合适的style, 并将其存入集合中
  //                    font开始标签目前支持的属性：color、weight、size
  //                    a开始标签支持的属性：href
  //            文本标签 去获取style集合的最后一个元素 并应用style样式
  //            结束标签 则将集合的最后一个元素删除

  List<TextSpan> convert() {
    //优先使用外部提供的样式
    TextStyle style = _defaultStyle ??
        TextStyle(
          fontSize: 14,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.normal,
          color: BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextImportant,
        );

    List<TextSpan> spans = [];
    _eventList.forEach((xmlEvent) {
      if (xmlEvent is xml.XmlStartElementEvent) {
        if (!xmlEvent.isSelfClosing) {
          Tag tag = Tag();
          TextStyle textStyle = style.copyWith();
          if (xmlEvent.name == "font") {
            xmlEvent.attributes.forEach((attr) {
              switch (attr.name) {
                case "color":
                  Color textColor = BrnConvertUtil.generateColorByString(attr.value);
                  textStyle = textStyle.apply(color: textColor);
                  break;
                case "weight":
                  FontWeight fontWeight = BrnConvertUtil.generateFontWidgetByString(attr.value);
                  textStyle =
                      textStyle.apply(fontWeightDelta: fontWeight.index - FontWeight.normal.index);
                  break;
                case "size":
                  double size = BrnConvertUtil.generateFontSize(attr.value);
                  textStyle = textStyle.apply(fontSizeDelta: size - 13);
                  break;
              }
            });
            tag.isLink = false;
          }

          if (xmlEvent.name == "strong") {
            tag.isLink = false;
            textStyle = textStyle.apply(fontWeightDelta: 2);
          }

          if (xmlEvent.name == "a") {
            tag.isLink = true;
            xmlEvent.attributes.forEach((attr) {
              switch (attr.name) {
                case "href":
                  textStyle = textStyle.apply(
                      color: BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary);
                  tag.linkUrl = attr.value;
                  break;
              }
            });
          }
          tag.name = xmlEvent.name;
          tag.style = textStyle;
          stack.add(tag);
        } else {
          if (xmlEvent.name == "br") {
            spans.add(TextSpan(text: "\n"));
          }
        }
      }

      if (xmlEvent is xml.XmlTextEvent) {
        Tag tag = Tag();
        tag.style = style.copyWith();
        if (stack.isNotEmpty) {
          tag = stack.last;
        }
        TextSpan textSpan = _createTextSpan(xmlEvent.text, tag);
        spans.add(textSpan);
      }

      if (xmlEvent is xml.XmlEndElementEvent) {
        Tag top = stack.removeLast();
        if (top.name != xmlEvent.name) {
          debugPrint("Error format  HTML");
          return;
        }
      }
    });

    return spans;
  }

  TextSpan _createTextSpan(String text, Tag tag) {
    if (text.isEmpty) return TextSpan(text: "");
    TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();
    tapGestureRecognizer.onTap = () {
      if (_linkCallBack != null) {
        _linkCallBack(text, tag.linkUrl);
      }
    };
    return TextSpan(
        style: tag.style, text: text, recognizer: tag.isLink ? tapGestureRecognizer : null);
  }
}

class Tag {
  String name;
  TextStyle style;
  String linkUrl;
  bool isLink = false;
}
