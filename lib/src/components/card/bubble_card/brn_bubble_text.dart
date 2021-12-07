import 'package:bruno/src/components/text/brn_expandable_text.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';
import 'package:bruno/src/utils/brn_tools.dart';

/// 具备展开收起功能的气泡背景文字面板
/// 气泡：背景色为Color(0xFFF8F8F8)的灰色Container
///      右上角为不规则小三角
///
/// 布局规则：
///     组件的背景是气泡背景
///     包装了[BrnExpandableText]组件，具备了展开收起的能力
///
/// ```dart
///   BrnBubbleText(
///      text: '在文本的右下角有更多或者收起按钮',
///   )
///
///   BrnBubbleText(
///      text: '具备展开收起功能的文字面板，在文本的右下角有更多或者收起按钮',
///      maxLines: 2,
///   )
///
/// ```
///
/// 相关文本组件如下:
///  * [BrnExpandableText], 气泡背景的展开收起文本组件
///  * [BrnInsertInfo], 气泡背景的文本组件
///
class BrnBubbleText extends StatelessWidget {
  ///显示的文本
  final String text;

  ///最多显示的行数
  final int maxLines;

  ///展开收起回调
  final TextExpandedCallback onExpanded;

  ///气泡的圆角 默认是4
  final double radius;

  const BrnBubbleText({Key key, this.text, this.maxLines, this.onExpanded, this.radius = 4})
      : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    Image image = BrunoTools.getAssetImage('icons/icon_right_top_pointer.png');
    Widget bubbleText = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        image,
        _buildExpandedWidget(),
      ],
    );
    return bubbleText;
  }

  Widget _buildExpandedWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(radius ?? 4),
                    bottomLeft: Radius.circular(radius ?? 4),
                    bottomRight: Radius.circular(radius ?? 4))),
            padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
            child: BrnExpandableText(
              text: text ?? "",
              maxLines: maxLines,
              color: Color(0xFFF8F8F8),
              onExpanded: onExpanded,
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase,
              ),
            ),
          ),
        )
      ],
    );
  }
}
