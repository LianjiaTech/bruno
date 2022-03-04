import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 星星视图的自定义构造器
/// state，[RatingState] 星星状态
typedef BrnRatingStarBuilder = Widget Function(RatingState state);

enum RatingState {
  /// 半颗
  half,

  /// 未选
  unselect,

  /// 已选
  select,
}

/// 星级评分控件，支持：
///
/// * 可自定义图片、颜色、大小、间距
/// * 支持点击选中
/// * 支持是否限制评分最少一颗星，即第一颗星支持是否可反选
/// * 支持半颗星（仅支持展示，不支持选择）
class BrnRatingStar extends StatefulWidget {
  static const DEFAULT_COUNT = 5;
  static const DEFAULT_SPACE = 1.0;

  /// 星星的总数，默认为 5 颗
  final int count;

  /// 初始选中个数
  final double selectedCount;

  /// 星星间的水平间距，默认为 1.0
  final double space;

  /// 是否可评 0 颗星，即第一颗星是否支持反选，默认不可评 0 星
  final bool canRatingZero;

  /// 单颗星星视图的自定义构造器
  final BrnRatingStarBuilder? starBuilder;

  /// 如果设置了，就支持编辑
  final ValueChanged<int>? onSelected;

  const BrnRatingStar({
    Key? key,
    this.count = DEFAULT_COUNT,
    this.selectedCount = 0,
    this.space = DEFAULT_SPACE,
    this.starBuilder,
    this.onSelected,
    this.canRatingZero = false,
  }) : super(key: key);

  @override
  _BrnRatingStarState createState() => _BrnRatingStarState();
}

class _BrnRatingStarState extends State<BrnRatingStar> {
  late double currSelected;

  @override
  void initState() {
    super.initState();
    currSelected = widget.selectedCount;
  }

  @override
  void didUpdateWidget(BrnRatingStar oldWidget) {
    currSelected = widget.selectedCount;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getContent(),
    );
  }

  List<Widget> _getContent() {
    List<Widget> list = [];
    for (var i = 0; i < widget.count; i++) {
      RatingState state;
      if (i < currSelected.floor()) {
        state = RatingState.select;
      } else if (i == currSelected.floor() && i < currSelected.ceil()) {
        state = RatingState.half;
      } else {
        state = RatingState.unselect;
      }
      var rating = widget.starBuilder != null
          ? widget.starBuilder!(state)
          : _buildRating(state);

      if (widget.onSelected != null) {
        list.add(GestureDetector(
          child: rating,
          onTap: () {
            // 反选第一个
            if (i == 0 && currSelected == 1 && widget.canRatingZero) {
              currSelected = 0;
            } else {
              currSelected = (i + 1).toDouble();
            }
            widget.onSelected!(currSelected.toInt());
            setState(() {});
          },
          behavior: HitTestBehavior.opaque,
        ));
      } else {
        list.add(rating);
      }

      if (i != widget.count - 1) {
        list.add(SizedBox(
          width: widget.space,
          height: 1,
        ));
      }
    }
    return list;
  }

  Widget _buildRating(RatingState state) {
    switch (state) {
      case RatingState.select:
        return BrunoTools.getAssetSizeImage(BrnAsset.iconStar, 16, 16);
      case RatingState.half:
        return BrunoTools.getAssetSizeImage(BrnAsset.iconStarHalf, 16, 16);
      case RatingState.unselect:
      default:
        return BrunoTools.getAssetSizeImage(BrnAsset.iconStar, 16, 16,
            color: Color(0xFFF0F0F0));
    }
  }
}
