

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// 星级评分条
class RatingExample extends StatefulWidget {
  @override
  _RatingExampleState createState() => _RatingExampleState();
}

class _RatingExampleState extends State<RatingExample> {
  var num = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '星级评分控件Example',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            // 只接受整数，外界
            Text("支持半颗"),
            BrnRatingStar(),
            BrnRatingStar(
              selectedCount: 0.5,
            ),
            BrnRatingStar(
              selectedCount: 3.1,
            ),
            BrnRatingStar(
              selectedCount: 3.6,
              count: 10,
            ),
            SizedBox(height: 20),
            GestureDetector(
              child: Text("支持点击选中，第一个支持反选"),
              onTap: () {
                BrnToast.show("haha", context);
                setState(() {
                  num = 4;
                });
              },
            ),
            BrnRatingStar(
              selectedCount: num.toDouble(),
              space: 5,
              canRatingZero: true,
              onSelected: (count) {
                BrnToast.show("选中了$count个", context);
              },
            ),
            SizedBox(height: 20),
            Text("自定义图片，颜色，大小"),
            BrnRatingStar(
              selectedCount: 3,
              space: 1,
              canRatingZero: true,
              onSelected: (count) {
                BrnToast.show("选中了$count个", context);
              },
              starBuilder: _buildRating,
            )
          ],
        ),
      ),
    );
  }

  // 自定义图片，大小，颜色
  Widget _buildRating(RatingState state) {
    switch (state) {
      case RatingState.select:
        return BrunoTools.getAssetSizeImage(BrnAsset.iconStar, 16, 16,
            color: Color(0xFF3571DC));
      case RatingState.half:
        return BrunoTools.getAssetSizeImage(BrnAsset.iconStarHalf, 16, 16);
      case RatingState.unselect:
      default:
        return BrunoTools.getAssetSizeImage(BrnAsset.iconStar, 16, 16,
            color: Color(0xFFF0F0F0));
    }
  }
}
