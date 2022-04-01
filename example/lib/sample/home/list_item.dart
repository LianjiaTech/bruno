

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// 列表项
class ListItem extends StatefulWidget {
  /// 点击事件
  final VoidCallback? onPressed;

  /// 标题
  final String title;
  final double? titleFontSize;
  final Color? titleColor;
  final String? imgPath;

  /// 描述
  final String describe;
  final Color describeColor;

  /// 右侧控件
  final Widget? rightWidget;
  final bool isSupportTheme;
  final bool isShowLine;

  /// 构造函数
  ListItem({
    Key? key,
    this.onPressed,
    this.title = "",
    this.titleFontSize,
    this.titleColor,
    this.describe = "",
    this.describeColor = const Color(0xFF999999),
    this.rightWidget,
    this.imgPath,
    this.isSupportTheme = false,
    this.isShowLine = true,
  }) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isShowLine
                  ? BrnLine(
                      color: Color(0xFFEEEEEE),
                      height: 1,
                    )
                  : Container(),
              BrnLine(
                height: 14,
                color: Colors.transparent,
              ),
              Wrap(children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: widget.titleColor ?? Color(0xFF222222),
                      fontSize: widget.titleFontSize ?? 14),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4),
                ),
                widget.isSupportTheme
                    ? BrnTagCustom(
                        tagText: "可定制",
                        textPadding: EdgeInsets.only(
                            bottom: 0, left: 4, right: 4, top: 0),
                        textColor: Color(0xFFFF5722),
                        backgroundColor: Color(0x24FF5722),
                      )
                    : Container()
              ]),
              Padding(padding: EdgeInsets.all(2)),
              Text(
                widget.describe,
                style: TextStyle(color: widget.describeColor, fontSize: 12),
              ),
              BrnLine(
                height: 14,
                color: Colors.transparent,
              )
            ],
          )),
    );
  }
}
