import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 筛选菜单项
// ignore: must_be_immutable
class BrnSelectionMenuItemWidget extends StatelessWidget {

  /// 菜单项标题
  final String title;

  /// 是否高亮
  final bool isHighLight;

  /// 是否选中
  final bool active;

  /// 点击事件
  final VoidCallback? itemClickFunction;

  /// 主题配置
  BrnSelectionConfig themeData;

  BrnSelectionMenuItemWidget(
      {Key? key,
      required this.title,
      this.isHighLight = false,
      this.active = false,
      this.itemClickFunction,
      required this.themeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _menuItemTapped();
        },
        child: Container(
          color: Colors.transparent,
          constraints: BoxConstraints.expand(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Flexible(
                child: Text(
                  this.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                  style: isHighLight
                      ? themeData.menuSelectedTextStyle.generateTextStyle()
                      : themeData.menuNormalTextStyle.generateTextStyle(),
                ),
              )),
              Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: isHighLight
                      ? (active
                          ? BrunoTools.getAssetImageWithBandColor(
                              BrnAsset.iconArrowUpSelect,
                              configId: themeData.configId)
                          : BrunoTools.getAssetImageWithBandColor(
                              BrnAsset.iconArrowDownSelect))
                      : (active
                          ? BrunoTools.getAssetImageWithBandColor(
                              BrnAsset.iconArrowUpSelect,
                              configId: themeData.configId)
                          : BrunoTools.getAssetImage(
                              BrnAsset.iconArrowDownUnSelect)))
            ],
          ),
        ),
      ),
      flex: 1,
    );
  }

  void _menuItemTapped() {
    if (this.itemClickFunction != null) {
      this.itemClickFunction!();
    }
  }
}
