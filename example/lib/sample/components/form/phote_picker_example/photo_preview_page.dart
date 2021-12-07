import 'dart:io';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// @des:图片预览页面
///

// ignore: must_be_immutable
class PhotoPreviewPage extends StatefulWidget {
  /// 图片地址
  List picUrl;

  /// 初始化角标
  int initialIndex;

  PhotoPreviewPage({@required this.picUrl, this.initialIndex: 0});

  @override
  _PhotoPreviewPageState createState() => _PhotoPreviewPageState();
}

class _PhotoPreviewPageState extends State<PhotoPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  ///
  /// 标题栏
  ///
  Widget _buildAppBar(BuildContext context) {
    return BrnAppBar(
      title: "图片详情",
      backLeadCallback: () {
        Navigator.pop(context);
      },
    );
  }

  ///
  /// 轮播图
  ///
  Widget _buildBody(BuildContext context) {
    return Swiper(
      itemCount: widget.picUrl.length,
      itemBuilder: (BuildContext context, int index) {
        String picUrl = widget.picUrl[index];
        if (picUrl.startsWith("http") || picUrl.startsWith("https")) {
          return FadeInImage.assetNetwork(
            placeholder: "packages/bruno/assets/" + "images/icon_alert",
            image: widget.picUrl[index],
            fit: BoxFit.fill,
          );
        } else {
          File file = File(picUrl);
          Image image = Image.file(file, fit: BoxFit.fill);
          return image;
        }
      },
      index: widget.initialIndex,
      control: new SwiperControl(),
      loop: false,
    );
  }
}
