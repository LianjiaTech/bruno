import 'package:bruno/src/components/line/brn_line.dart';
import 'package:bruno/src/constants/brn_constants.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// section为所在行数（0或1），index是在第几位（从0开始记）, shareItem为渠道相关信息
typedef void BrnShareActionSheetItemClickCallBack(
    int section, int index, BrnShareItem shareItem);

/// 点击事件拦截回调（如果配置了此项，返回值为是否拦截，如果为true，则进行拦截，不进行默认回调）
/// section为所在行数（0或1），index是在第几位（从0开始记）,shareItem为渠道相关信息
typedef bool BrnShareActionSheetOnItemClickInterceptor(
    int section, int index, BrnShareItem shareItem);

/// 分享元素
class BrnShareItem extends Object {
  /// 分享类型（参考BrnShareItemConstants中的枚举，如果此项不为自定义，则自定义名称和图标不生效）
  int shareType;

  /// 自定义标题
  String? customTitle;

  /// 自定义图标
  Widget? customImage;

  /// 是否可点击（如果为预设类型，设置为不可点击后会变为相应的置灰图标）默认为true
  bool canClick;

  BrnShareItem(
    this.shareType, {
    this.customTitle,
    this.customImage,
    this.canClick = true,
  });
}

// ignore: must_be_immutable
class BrnShareActionSheet extends StatelessWidget {
  /// 第一行渠道列表
  final List<BrnShareItem>? firstShareChannels;

  /// 第二行渠道列表
  final List<BrnShareItem>? secondShareChannels;

  /// 列表标题
  final String? mainTitle;

  /// 取消按钮名称
  final String? cancelTitle;

  /// 取消按钮的文本颜色，默认值为 Color(0xff222222)
  final Color textColor;

  /// 分享文本颜色，默认值为 Color(0xff999999)
  final Color shareTextColor;

  /// 点击事件回调
  final BrnShareActionSheetItemClickCallBack? clickCallBack;

  /// 点击事件拦截回调（如果配置了此项，返回值为是否拦截，如果为true，则进行拦截，不进行默认回调）
  final BrnShareActionSheetOnItemClickInterceptor? clickInterceptor;

  BrnShareActionSheet({
    this.firstShareChannels,
    this.secondShareChannels,
    this.mainTitle,
    this.clickCallBack,
    this.clickInterceptor,
    this.cancelTitle,
    this.shareTextColor = const Color(0xff999999),
    this.textColor = const Color(0xff222222),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ShapeDecoration(
          color: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
        ),
        child: SafeArea(child: _configActionWidgets(context)));
  }

  show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return this;
        }).then((value) {});
  }

  /// 构建单个分享渠道
  Widget? _configChannelWidget(BuildContext context, int section, int index) {
    // 分享类型
    BrnShareItem channel;
    // 渠道名称
    String? title;
    // 图片
    Widget? image;
    // 元素宽度(图片边长也是48)
    double itemsWidth = 48;
    // 元素间隔为20写死
    double space = 20;
    title = null;
    image = null;
    // 判断区域
    if (section == 0) {
      channel = firstShareChannels![index];
    } else {
      channel = secondShareChannels![index];
    }
    // 判断是否为自定义标题
    title = (channel.shareType == BrnShareItemConstants.shareCustom)
        ? (channel.customTitle ?? "")
        : BrnShareItemConstants.shareItemTitleList[channel.shareType];
    // 判断是否为自定义，如果不是自定义图标，则判断是否可点击（决定是否使用置灰图标）
    image = (channel.shareType == BrnShareItemConstants.shareCustom)
        ? channel.customImage
        : (channel.canClick
            ? BrunoTools.getAssetImage(
                BrnShareItemConstants.shareItemImagePathList[channel.shareType])
            : BrunoTools.getAssetImage(BrnShareItemConstants
                .disableShareItemImagePathList[channel.shareType]));
    //如果没图或没文字则不显示
    if (image == null) {
      return null;
    }

    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: itemsWidth + space,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: image,
              width: itemsWidth,
              height: itemsWidth,
            ),
            Divider(
              height: 8,
              color: Colors.transparent,
            ),
            Text(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: shareTextColor),
            )
          ],
        ),
      ),
      onTap: () {
        if (clickInterceptor == null ||
            !clickInterceptor!(section, index, channel)) {
          // 推荐使用回调方法处理点击事件!!!!!!!!!!
          if (clickCallBack != null && channel.canClick) {
            clickCallBack!(section, index, channel);
            // 如果未拦截并且可点击，则pop掉当前页面
            Navigator.of(context).pop();
          }
        }
      },
    );
  }

  /// 构建actionSheet的按钮
  Widget _configActionWidgets(BuildContext context) {
    List<Widget> tiles = [];
    // 预设分享渠道
    List<Widget> firstSectionItems = [];
    // 自定义分享渠道
    List<Widget> secondSectionItems = [];
    // 容器左侧留白
    double leftGap = 10;
    // 容器上方留白
    double topGap = 20;
    // 容器下方留白
    double bottomGap = 20;
    // 构建第一行
    if (firstShareChannels != null) {
      for (int index = 0; index < firstShareChannels!.length; index++) {
        Widget? item = _configChannelWidget(context, 0, index);
        if (item != null) {
          firstSectionItems.add(item);
        }
      }
    }
    // 构建第二行
    if (secondShareChannels != null) {
      for (int index = 0; index < secondShareChannels!.length; index++) {
        Widget? item = _configChannelWidget(context, 1, index);
        if (item != null) {
          secondSectionItems.add(item);
        }
      }
    }
    // 添加title
    tiles.add(Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 16, left: 20),
      child: Text(
        mainTitle ?? "分享至",
        maxLines: 1,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: BrnThemeConfigurator.instance
                .getConfig()
                .commonConfig
                .colorTextBase),
      ),
    ));

    // 添加“预设分享”容器
    if (firstSectionItems.length > 0) {
      tiles.add(Container(
        padding: EdgeInsets.only(left: leftGap, top: topGap, bottom: bottomGap),
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: firstSectionItems,
          ),
        ),
      ));
    }

    // 添加分割线
    tiles.add(Container(
      // 分割线左右填充20
      padding: EdgeInsets.only(left: 20, right: 20),
      child: BrnLine(),
    ));

    // 添加“自定义分享”容器
    if (secondSectionItems.length > 0) {
      tiles.add(Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: leftGap, top: topGap, bottom: bottomGap),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: secondSectionItems,
          ),
        ),
      ));
    }

    // 添加分割线
    tiles.add(
      BrnLine(),
    );

    // 添加"取消"按钮
    tiles.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.only(left: 61, right: 61, top: 12, bottom: 12),
          child: Center(
            child: Text(
              cancelTitle ?? "取消",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        }));

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: tiles,
    );
  }
}
