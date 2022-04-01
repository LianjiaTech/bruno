

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/gallery/gallery_detail_page_theme_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GalleryExample extends StatelessWidget {
  List<BrnPhotoGroupConfig> allConfig = [
    BrnPhotoGroupConfig.url(title: '第一项', urls: <String>[
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
    ]),
    BrnPhotoGroupConfig(title: "信息", configList: [
      BrnPhotoItemConfig(
          url: 'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
          showBottom: true,
          bottomCardModel: PhotoBottomCardState.cantFold,
          name: "一只猫",
          des:
              "图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述"),
      BrnPhotoItemConfig(
          url: 'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
          showBottom: true,
          bottomCardModel: PhotoBottomCardState.fold,
          name: "两只猫",
          des: "图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述"),
      BrnPhotoItemConfig(
          url: 'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
          showBottom: true,
          bottomCardModel: PhotoBottomCardState.unFold,
          name: "三只猫",
          des:
              "图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述"),
      BrnPhotoItemConfig(
          url: 'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
          showBottom: false,
          name: "一张图片",
          des:
              "图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述")
    ]),
    BrnPhotoGroupConfig.url(title: '第二项', urls: <String>[
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
    ]),
    BrnPhotoGroupConfig.url(title: '第三项', urls: <String>[
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
    ]),
    BrnPhotoGroupConfig.url(title: '第四项', urls: <String>[
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
      'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
    ]),
    BrnPhotoGroupConfig(title: "带展示信息的模块", configList: [
      BrnPhotoItemConfig(
          url: 'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
          showBottom: true,
          bottomCardModel: PhotoBottomCardState.fold,
          name: "一张图片",
          des: "图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述")
    ]),
    BrnPhotoGroupConfig(title: "带展示信息的模块", configList: [
      BrnPhotoItemConfig(
          url: 'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
          showBottom: true,
          bottomCardModel: PhotoBottomCardState.fold,
          name: "一张图片",
          des:
              "图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述")
    ]),
    BrnPhotoGroupConfig(title: "带展示信息的模块", configList: [
      BrnPhotoItemConfig(
          url: 'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
          showBottom: true,
          bottomCardModel: PhotoBottomCardState.fold,
          name: "一张图片",
          des:
              "图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述")
    ])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: "Gallery 图片",
      ),
      body: ListView(
        children: [
          ListItem(
            title: "图片选择控件",
            isShowLine: false,
            describe: "查看图片列表页",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return BrnGallerySummaryPage(allConfig: allConfig);
                },
              ));
            },
          ),
          ListItem(
            title: "图片详情查看",
            describe: '跳转第一项的第五张图',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return GalleryDetailPageThemeExample();
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
