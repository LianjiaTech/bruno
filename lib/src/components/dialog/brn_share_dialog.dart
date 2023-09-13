import 'package:bruno/src/components/dialog/brn_dialog.dart';
import 'package:bruno/src/components/dialog/brn_dialog_utils.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/constants/brn_constants.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_dialog_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 点击item回调
/// shareChannel 是分享渠道一般传入 [BrnShareItemConstants] 下的值
typedef BrnShareDialogItemClickCallBack = void Function(int shareChannel, int customIndex);

/// 获取自定义分享item标题
/// index为自定义分享item索引
typedef BrnShareDialogGetCustomShareItemTitle = String? Function(int index);

/// 获取自定义分享item图标
/// index为自定义分享item索引
typedef BrnShareDialogGetCustomShareItemIcon = Widget? Function(int index);

///
/// 屏幕中间 dialog 弹窗
/// 可指定最多五个需要展示的分享渠道图标（目前内设有：微信，朋友圈，qq，qq 空间，微博，链接，短信）
/// 如需展示内设渠道之外的分享渠道，支持自定义展示渠道图标
/// 可自定义分享弹框标题文案
/// 可自定义分享弹框辅助信息
/// 可自定义文案和分享渠道中间的分割线内文案
// ignore: must_be_immutable
class BrnShareDialog extends StatelessWidget {
  final BuildContext context;

  /// 标题文本
  final String titleText;

  /// 弹框辅助信息文案，为空则不显示辅助信息
  final String? descText;

  /// 文案与分享渠道图标间的分割线内嵌文案
  final String? separatorText;

  /// 分享渠道列表
  final List<int> shareChannels;

  /// 标题颜色，默认值 Color(0xff222222)
  final Color titleColor;

  /// 分享渠道文案颜色，默认值 Color(0xff666666)
  final Color descColor;

  /// 分享文本颜色，Color(0xff999999)
  final Color shareTextColor;

  /// 分割线颜色，默认值 Color(0xffEEEEEE)
  final Color separatorLineColor;

  /// 点击事件
  final BrnShareDialogItemClickCallBack? clickCallBack;

  /// 回调获取名称
  final BrnShareDialogGetCustomShareItemTitle? getCustomChannelTitle;

  /// 回调获取图片(Widget)
  final BrnShareDialogGetCustomShareItemIcon? getCustomChannelWidget;

  /// dialog配置
  BrnDialogConfig? themeData;

  BrnShareDialog({
    required this.context,
    required this.titleText,
    this.descText,
    this.separatorText,
    required this.shareChannels,
    this.clickCallBack,
    this.getCustomChannelTitle,
    this.getCustomChannelWidget,
    this.titleColor = const Color(0xff222222),
    this.descColor = const Color(0xff666666),
    this.shareTextColor = const Color(0xff999999),
    this.separatorLineColor = const Color(0xfff0f0f0),
    this.themeData,
  }) {
    this.themeData ??= BrnDialogConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: themeData!.configId)
        .dialogConfig
        .merge(themeData);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: BrnDialog(
        titleWidget: _configDialogTitle(),
        messageText: descText,
        divider: Divider(
          color: Colors.transparent,
          height: 0,
          thickness: 0,
        ),
        actionsWidget: <Widget>[
          Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _configDialogWidgets(),
            ),
          ),
        ],
      ),
    );
  }

  /// dialog弹出
  show() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return this;
        }).then((value) {
      if (value != null) {
        List info = value;
        if (info.length >= 2) {
          if (clickCallBack != null) {
            clickCallBack!(info[0], info[1]);
          }
        }
      }
    });
  }

  /// 构建widgets框架
  List<Widget> _configDialogWidgets() {
    List<Widget> widgets = [];
    widgets.add(_configDialogseparator());
    //分割
    widgets.add(Padding(
      padding: EdgeInsets.only(top: 12),
    ));
    widgets.add(_configDialogShareItems());
    return widgets;
  }

  /// 构建头部部分
  Widget _configDialogTitle() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 28),
            child: Text(
              titleText,
              style: BrnDialogUtils.getDialogTitleStyle(themeData!),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              child: Container(
                width: 30,
                height: 30,
                child: BrunoTools.getAssetImage(BrnAsset.iconPickerClose),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  /// 构建中间分割部分
  Widget _configDialogseparator() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: separatorLineColor,
            height: 1,
          ),
          Container(
            color: Color(0xffffffff),
            padding: EdgeInsets.only(left: 6, right: 6),
            child: Text(
              separatorText ?? BrnIntl.of(context).localizedResource.shareWayTip,
              style: TextStyle(fontSize: 12, color: shareTextColor),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建分享途径部分
  Widget _configDialogShareItems() {
    List<Widget> shareItems = [];
    String? title; // 标题
    Widget? image; // 图片路径
    for (int index = 0; index < shareChannels.length; index++) {
      title = null;
      image = null;
      if (shareChannels[index] == BrnShareItemConstants.shareCustom) {
        // 获取自定义channel信息
        if (getCustomChannelTitle != null) {
          title = getCustomChannelTitle!(index);
        }
        if (getCustomChannelTitle != null) {
          image = getCustomChannelWidget!(index);
        }
      } else {
        // 获取自预设channel信息
        title = BrnIntl.of(context).localizedResource.shareChannels[shareChannels[index]];
        image = BrunoTools.getAssetImage(
            BrnShareItemConstants.shareItemImagePathList[shareChannels[index]]);
      }
      //如果没图或没文字则不显示
      if (title == null || image == null) {
        continue;
      }
      // “分享”按钮容器
      shareItems.add(Container(
        width: 39,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              child: Container(
                child: image,
                width: 39,
                height: 39,
              ),
              onTap: () {
                Navigator.of(context).pop([shareChannels[index], index]);
              },
            ),
            Divider(
              height: 5,
              color: Colors.transparent,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: shareTextColor),
            )
          ],
        ),
      ));
    }
    double space = (shareItems.length >= 5)
        ? 14
        : (300 - 39 * shareItems.length) / (shareItems.length + 1);
    return Container(
      padding: EdgeInsets.only(bottom: 28),
      alignment: Alignment.center,
      child: Wrap(
        spacing: space,
        runSpacing: 31,
        children: shareItems,
      ),
    );
  }
}
