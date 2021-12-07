import 'package:bruno/src/components/appraise/brn_appraise.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 描述: 评价组件title

class BrnAppraiseHeader extends StatelessWidget {
  /// 是否显示标题
  final bool showHeader;

  /// 标题文字
  final String title;

  /// 标题最大行数
  final int maxLines;

  /// 标题类型
  final BrnAppraiseHeaderType headerType;

  /// 标题的padding
  final EdgeInsets headPadding;

  /// 点击关闭的回掉
  final BrnAppraiseCloseClickCallBack cancelCallBack;

  BrnAppraiseHeader(
      {this.showHeader = true,
      this.title = '',
      this.maxLines = 1,
      this.headerType = BrnAppraiseHeaderType.spaceBetween,
      this.headPadding,
      this.cancelCallBack});

  @override
  Widget build(BuildContext context) {
    if (showHeader) {
      if (headerType == BrnAppraiseHeaderType.spaceBetween) {
        return _spaceHeader(context);
      } else if (headerType == BrnAppraiseHeaderType.center) {
        return _centerHeader();
      }
    }
    return Container();
  }

  Widget _centerHeader() {
    return Container(
      color: Colors.white,
      padding: headPadding ?? EdgeInsets.only(top: 20, bottom: 20),
      child: Text(
        title ?? '',
        maxLines: maxLines ?? 1,
        style: TextStyle(
          color: BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _spaceHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 38 + (maxLines ?? 1) * 22.0,
      child: Padding(
            padding: headPadding ?? EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4, right: 12),
                    child: Text(
                      title ?? '',
                      maxLines: maxLines ?? 1,
                      style: TextStyle(
                        color: BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase,
                        fontSize: 18.0,
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (cancelCallBack != null) {
                      cancelCallBack(context);
                    }
                    Navigator.of(context).pop();
                  },
                  child: BrunoTools.getAssetImage(BrnAsset.ICON_PICKER_CLOSE),
                ),
              ],
            ),
          ),
    );
  }
}

/// title类型
enum BrnAppraiseHeaderType {
  /// 居中
  center,

  /// 两边
  spaceBetween,
}
