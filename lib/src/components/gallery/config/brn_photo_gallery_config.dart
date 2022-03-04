import 'package:bruno/src/components/gallery/config/brn_basic_gallery_config.dart';
import 'package:bruno/src/components/gallery/config/brn_bottom_card.dart';
import 'package:bruno/src/components/loading/brn_loading.dart';
import 'package:bruno/src/constants/brn_strings_constants.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_gallery_detail_config.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class BrnPhotoGroupConfig extends BrnBasicGroupConfig {
  final List<String>? urls;
  final String? title;
  final BrnGalleryDetailConfig? themeData;

  /// 通过 [urls] 列表生成配置
  BrnPhotoGroupConfig.url(
      {this.title,
      required this.urls,
      this.themeData,
      List<BrnBasicItemConfig>? configList})
      : super(
            title: title,
            configList: urls
                ?.map((item) =>
                    BrnPhotoItemConfig(url: item, themeData: themeData))
                .toList());

  /// 自定义配置列表
  BrnPhotoGroupConfig(
      {this.urls,
      this.title,
      List<BrnBasicItemConfig>? configList,
      this.themeData})
      : super(title: title, configList: configList);
}

/// 图片类的配置
class BrnPhotoItemConfig extends BrnBasicItemConfig {
  /// 图片url
  final String url;

  /// 图片的展示模式
  final BoxFit fit;

  /// 占位图
  final String placeHolder;

  /// 图片名称 用于详情页展示
  final String? name;

  /// 图片描述公 用于详情页展示
  final String? des;

  /// 详情页图片点击回调
  final VoidCallback? onTap;

  /// 详情页双击回调
  final VoidCallback? onDoubleTap;

  /// 详情页长按回调
  final VoidCallback? onLongPress;

  /// 详情页是否展示底部卡片，需要提供name和des信息
  final bool showBottom;

  /// [PhotoBottomCardState] 底部展示卡片的模式
  final PhotoBottomCardState bottomCardModel;

  /// 指定展开不可收起下 content的高度
  final double bottomContentHeight;

  BrnGalleryDetailConfig? themeData;

  BrnPhotoItemConfig({
    required this.url,
    this.fit = BoxFit.cover,
    this.placeHolder =
        "packages/${BrnStrings.flutterPackageName}/assets/icons/grey_place_holder.png",
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.name,
    this.des,
    this.showBottom = false,
    this.bottomCardModel = PhotoBottomCardState.cantFold,
    this.bottomContentHeight = 150,
    this.themeData,
  }) {
    this.themeData ??= BrnGalleryDetailConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .galleryDetailConfig
        .merge(this.themeData);
  }

  @override
  Widget buildSummaryWidget(BuildContext context,
      List<BrnBasicGroupConfig> allConfig, int groupId, int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          border: Border.all(color: Color(0xFFF0F0F0), width: 0.5)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: FadeInImage.assetNetwork(
          image: url,
          fit: fit,
          placeholder: placeHolder,
        ),
      ),
    );
  }

  @override
  Widget buildDetailWidget(BuildContext context,
      List<BrnBasicGroupConfig> allConfig, int groupId, int index) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                onTap?.call();
              },
              onDoubleTap: () {
                onDoubleTap?.call();
              },
              onLongPress: () {
                onLongPress?.call();
              },
              child: Container(
                color: Colors.white,
                child: PhotoView(
                  backgroundDecoration:
                      BoxDecoration(color: themeData!.pageBackgroundColor),
                  loadingBuilder: (context, event) {
                    return Container(
                      child: BrnLoadingDialog(),
                      color: themeData!.pageBackgroundColor,
                    );
                  },
                  imageProvider: NetworkImage(url),
                ),
              ),
            ),
          ),
          showBottom
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SafeArea(
                    top: false,
                    child: BrnPhotoBottomCard(
                      name: name,
                      des: des,
                      model: bottomCardModel,
                      contentHeight: bottomContentHeight,
                      themeData: themeData,
                    ),
                  ),
                )
              : Row()
        ],
      ),
    );
  }
}
