

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

enum PhotoGalleryTheme { dark, light }

class GalleryDetailExamplePage extends StatefulWidget {
  final String? title;
  final PhotoGalleryTheme photoGalleryTheme;

  GalleryDetailExamplePage(
      {this.title, this.photoGalleryTheme = PhotoGalleryTheme.dark});

  @override
  State<StatefulWidget> createState() {
    return GalleryDetailExamplePageState();
  }
}

class GalleryDetailExamplePageState extends State<GalleryDetailExamplePage> {
  late List<BrnPhotoGroupConfig> allConfig;
  late BrnGalleryController controller;

  @override
  void initState() {
    super.initState();
    controller = BrnGalleryController();
    allConfig = [
      BrnPhotoGroupConfig.url(
          themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
              ? BrnGalleryDetailConfig.dark()
              : BrnGalleryDetailConfig.light(),
          title: '第一项',
          urls: <String>[
            "https://img1.baidu.com/it/u=1035835481,2764635772&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
            "https://img2.baidu.com/it/u=987135572,1298604833&fm=253&fmt=auto&app=138&f=JPEG?w=587&h=445",
            "https://img1.baidu.com/it/u=2029510411,2926361415&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
            "https://img2.baidu.com/it/u=3489452515,1789465937&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=333",
            "https://img2.baidu.com/it/u=2011041083,1329194196&fm=253&fmt=auto&app=138&f=JPEG?w=333&h=500",
            "https://img2.baidu.com/it/u=3412982025,1011812299&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
          ]),
      BrnPhotoGroupConfig(title: "信息", configList: [
        BrnPhotoItemConfig(
            themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
                ? BrnGalleryDetailConfig.dark()
                : BrnGalleryDetailConfig.light(),
            url:
            "https://img2.baidu.com/it/u=3489452515,1789465937&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=333",
            showBottom: true,
            bottomCardModel: PhotoBottomCardState.cantFold,
            name: "一只猫",
            des:
            "冠寓是龙湖地产的第三大主航道业务，adsadasd专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务adsadasdasdas，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；"),
        BrnPhotoItemConfig(
            themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
                ? BrnGalleryDetailConfig.dark()
                : BrnGalleryDetailConfig.light(),
            url:
            "https://img2.baidu.com/it/u=2011041083,1329194196&fm=253&fmt=auto&app=138&f=JPEG?w=333&h=500",
            showBottom: true,
            bottomCardModel: PhotoBottomCardState.fold,
            name: "两只猫",
            des:
            "adaada，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注adasdasdasdasd做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；"),
        BrnPhotoItemConfig(
            themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
                ? BrnGalleryDetailConfig.dark()
                : BrnGalleryDetailConfig.light(),
            url:
            "https://img0.baidu.com/it/u=3926156041,1190073021&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
            showBottom: true,
            bottomCardModel: PhotoBottomCardState.unFold,
            name: "三只猫",
            des:
            "冠寓是龙湖地产的第三大主航adaada道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注大大大 asdadasdadasda做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；"),
        BrnPhotoItemConfig(
            themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
                ? BrnGalleryDetailConfig.dark()
                : BrnGalleryDetailConfig.light(),
            url:
            "https://img1.baidu.com/it/u=456300708,413059805&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
            showBottom: false,
            name: "一张图片",
            des:
            "冠寓是龙湖地产的第三大主航道业务，adaada专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；")
      ]),
      BrnPhotoGroupConfig.url(
          title: '第二项',
          themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
              ? BrnGalleryDetailConfig.dark()
              : BrnGalleryDetailConfig.light(),
          urls: <String>[
            "https://img1.baidu.com/it/u=2029510411,2926361415&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
            "https://img2.baidu.com/it/u=3412982025,1011812299&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
          ]),
      BrnPhotoGroupConfig.url(
          themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
              ? BrnGalleryDetailConfig.dark()
              : BrnGalleryDetailConfig.light(),
          title: '第三项',
          urls: <String>[
            "https://img2.baidu.com/it/u=987135572,1298604833&fm=253&fmt=auto&app=138&f=JPEG?w=587&h=445",
            "https://img2.baidu.com/it/u=3412982025,1011812299&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
          ]),
      BrnPhotoGroupConfig.url(
          themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
              ? BrnGalleryDetailConfig.dark()
              : BrnGalleryDetailConfig.light(),
          title: '第四项',
          urls: <String>[
            "https://img2.baidu.com/it/u=3489452515,1789465937&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=333",
            "https://img2.baidu.com/it/u=3412982025,1011812299&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
          ]),
      BrnPhotoGroupConfig(
          themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
              ? BrnGalleryDetailConfig.dark()
              : BrnGalleryDetailConfig.light(),
          title: "带展示信息的模块",
          configList: [
            BrnPhotoItemConfig(
                themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
                    ? BrnGalleryDetailConfig.dark()
                    : BrnGalleryDetailConfig.light(),
                url:
                "https://img2.baidu.com/it/u=3489452515,1789465937&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=333",
                showBottom: true,
                bottomCardModel: PhotoBottomCardState.fold,
                name: "一张图片",
                des:
                "冠寓是龙湖地产的第三adasda大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；")
          ]),
      BrnPhotoGroupConfig(title: "带展示信息的模块", configList: [
        BrnPhotoItemConfig(
            themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
                ? BrnGalleryDetailConfig.dark()
                : BrnGalleryDetailConfig.light(),
            url:
            "https://img2.baidu.com/it/u=987135572,1298604833&fm=253&fmt=auto&app=138&f=JPEG?w=587&h=445",
            showBottom: true,
            bottomCardModel: PhotoBottomCardState.fold,
            name: "一张图片",
            des:
            "冠寓是龙湖地产的第三adasda大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；")
      ]),
      BrnPhotoGroupConfig(title: "带展示信息的模块", configList: [
        BrnPhotoItemConfig(
            themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
                ? BrnGalleryDetailConfig.dark()
                : BrnGalleryDetailConfig.light(),
            url:
            "https://img2.baidu.com/it/u=3489452515,1789465937&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=333",
            showBottom: true,
            bottomCardModel: PhotoBottomCardState.fold,
            name: "一张图片",
            des:
            "冠寓是龙湖地产的第三adasda大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；")
      ])
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BrnGalleryDetailPage(
      themeData: PhotoGalleryTheme.dark == widget.photoGalleryTheme
          ? BrnGalleryDetailConfig.dark()
          : BrnGalleryDetailConfig.light(),
      allConfig: allConfig,
      initGroupId: 0,
      initIndexId: 4,
      controller: controller,
      detailRightAction: (i, j) => BrnTextAction(
        '编辑',
        iconPressed: () {
          BrnToast.show("点击了$i $j", context);
          // 移除第二组的最后一个配置，跳转到 第二组的第一张图
          if (allConfig.length > 1) {
            if (allConfig[1].configList!.length > 0) {
              allConfig[1].configList!.removeLast();
              controller.refresh(1, 0);
            } else {
              allConfig.removeAt(1);
            }
          }
        },
      ),
    );
  }
}

