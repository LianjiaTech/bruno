

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/gallery/gallery_detail_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

class GalleryDetailPageThemeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: "图片详情查看",
        ),
        body: CustomScrollView(slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            ListItem(
              title: "图片详情-白色主题",
              describe: "图片详情带白色主题",
              isShowLine: false,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return GalleryDetailExamplePage(
                      title: "图片详情-白色主题",
                      photoGalleryTheme: PhotoGalleryTheme.light,
                    );
                  },
                ));
              },
            ),
            ListItem(
              title: "图片详情-黑色主题",
              describe: "图片详情带黑色主题，默认黑色",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return GalleryDetailExamplePage(
                      title: "图片详情-黑色主题",
                      photoGalleryTheme: PhotoGalleryTheme.dark,
                    );
                  },
                ));
              },
            ),
          ]))
        ]));
  }
}
