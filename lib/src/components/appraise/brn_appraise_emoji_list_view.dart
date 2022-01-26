import 'package:bruno/src/components/appraise/brn_appraise_emoji_item.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:bruno/src/components/appraise/brn_appraise_interface.dart';

/// 描述: 表情评价列表
///       最多支持5个表情，默认也是5个，支持选择任意个数，
///       传入@indexes就可以选择想要的任意位置的表情了

class BrnAppraiseEmojiListView extends StatefulWidget {
  /// 所需表情包的index列表，index最大值为4
  final List<int> indexes;

  /// 自定义文案，list长度为5，不足5个时请在对应位置补空字符串
  final List<String> titles;

  /// 点击回调
  final BrnAppraiseIconClick? onTap;

  static const List<String> _defaultTitles = ['不好', '还行', '满意', '很棒', '超惊喜'];

  BrnAppraiseEmojiListView(
      {Key? key,
      this.indexes = const [0, 1, 2, 3, 4],
      this.titles = _defaultTitles,
      this.onTap})
      : assert(indexes.length > 0),
        assert(titles.length == 5),
        super(key: key);

  @override
  _BrnAppraiseEmojiListViewState createState() =>
      _BrnAppraiseEmojiListViewState();
}

class _BrnAppraiseEmojiListViewState extends State<BrnAppraiseEmojiListView> {
  /// 未选中表情，灰色
  List _unselectedIcons = [
    BrnAsset.iconAppraiseBadUnselected,
    BrnAsset.iconAppraiseNotGoodUnselected,
    BrnAsset.iconAppraiseOkUnselected,
    BrnAsset.iconAppraiseGoodUnselected,
    BrnAsset.iconAppraiseSurpriseUnselected,
  ];

  /// 默认表情，黄色
  List _defaultIcons = [
    BrnAsset.iconAppraiseBadDefault,
    BrnAsset.iconAppraiseNotGoodDefault,
    BrnAsset.iconAppraiseOkDefault,
    BrnAsset.iconAppraiseGoodDefault,
    BrnAsset.iconAppraiseSurpriseDefault,
  ];

  /// 选中表情，gif
  List _selectedIcons = [
    BrnAsset.iconAppraiseBadSelected,
    BrnAsset.iconAppraiseNotGoodSelected,
    BrnAsset.iconAppraiseOkSelected,
    BrnAsset.iconAppraiseGoodSelected,
    BrnAsset.iconAppraiseSurpriseSelected,
  ];

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.indexes.isEmpty) {
      return Container();
    }

    List<BrnAppraiseEmojiItem> list = [];
    for (int i = 0; i < widget.indexes.length; i++) {
      list.add(BrnAppraiseEmojiItem(
        selectedName: _selectedIcons[widget.indexes[i]],
        unselectedName: _unselectedIcons[widget.indexes[i]],
        defaultName: _defaultIcons[widget.indexes[i]],
        index: i,
        padding:
            EdgeInsets.symmetric(horizontal: 7.0 * (6 - widget.indexes.length)),
        selectedIndex: _selectedIndex,
        title: widget.titles[widget.indexes[i]],
        onTap: (index) {
          _selectedIndex = index;
          if (widget.onTap != null) {
            widget.onTap!(_selectedIndex);
          }
        },
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }
}
