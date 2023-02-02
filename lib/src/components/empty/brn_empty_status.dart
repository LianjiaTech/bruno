import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_abnormal_state_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 页面状态
enum AbnormalState {
  /// 获取数据异常
  getDataFailed,

  /// 网络连接异常
  networkConnectError,

  /// 暂无数据
  noData
}

/// /// /// /// /// /// /// /// /// /
/// 描述: 异常页面展示
/// 注：这里仅提供几种常用异常页面，需要其他内容异常页面自行实现 EmptyStateWidget
/// /// /// /// /// /// /// /// /// /
class BrnAbnormalStateUtils {
  /// 通过状态获取对应空页面widget
  /// status: 页面状态类型为[EmptyState]
  static Widget getEmptyWidgetByState(
      BuildContext context, AbnormalState status,
      {Image? img, BrnEmptyStatusIndexedActionClickCallback? action}) {
    if (AbnormalState.getDataFailed == status) {
      return BrnAbnormalStateWidget(
        img: img ?? BrunoTools.getAssetImage(BrnAsset.noData),
        title: BrnIntl.of(context).localizedResource.fetchErrorAndRetry,
        operateTexts: <String>[
          BrnIntl.of(context).localizedResource.clickPageAndRetry
        ],
        action: action,
      );
    } else if (AbnormalState.networkConnectError == status) {
      return BrnAbnormalStateWidget(
        img: img ?? BrunoTools.getAssetImage(BrnAsset.networkError),
        title: BrnIntl.of(context).localizedResource.netErrorAndRetryLater,
        operateTexts: <String>[
          BrnIntl.of(context).localizedResource.clickPageAndRetry
        ],
        action: action,
      );
    } else if (AbnormalState.noData == status) {
      return BrnAbnormalStateWidget(
          img: img ?? BrunoTools.getAssetImage(BrnAsset.noData),
          title: BrnIntl.of(context).localizedResource.noDataTip);
    } else {
      return const SizedBox.shrink();
    }
  }
}

/// 操作区域按钮类型
enum OperateAreaType {
  /// 单按钮
  singleButton,

  /// 双按钮
  doubleButton,

  /// 文本按钮
  textButton
}

/// 空页面操作区域按钮的点击回调
/// index: 被点击按钮的索引
typedef BrnEmptyStatusIndexedActionClickCallback = void Function(int index);

/// 异常页面展示一般用于网络错误、数据为空的提示和引导
// ignore: must_be_immutable
class BrnAbnormalStateWidget extends StatelessWidget {
  /// 图片
  final Image? img;

  /// 标题
  final String? title;

  /// 内容
  final String? content;

  /// 操作区类型
  final OperateAreaType operateAreaType;

  /// 操作区文案
  final List<String>? operateTexts;

  /// 点击事件回调
  final BrnEmptyStatusIndexedActionClickCallback? action;

  /// 是否可点击页面回调配合[action]使用
  /// 当为true时调用[action]回调，当为false时不做处理
  /// 默认false
  final bool enablePageTap;

  /// 顶部距离走自动计算逻辑：父视图高度的8%，可自己指定高度
  /// 默认为null
  final double? topOffset;

  /// 背景色设置
  /// 默认Colors.white
  final Color bgColor;

  /// 距顶部高度百分比
  final double topPercent;

  /// 内容垂直居中
  /// 默认 false
  final bool isCenterVertical;

  BrnAbnormalStateConfig? themeData;

  BrnAbnormalStateWidget({
    this.img,
    this.title,
    this.content,
    this.operateAreaType = OperateAreaType.textButton,
    this.operateTexts,
    this.action,
    this.enablePageTap = false,
    this.topOffset,
    this.bgColor = Colors.white,
    this.isCenterVertical = false,
    this.topPercent = 0.08,
    this.themeData,
  }) {
    this.themeData ??= BrnAbnormalStateConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .abnormalStateConfig
        .merge(this.themeData);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (this.enablePageTap && action != null) {
            action!(0);
          }
        },
        child: Container(
          color: bgColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: isCenterVertical
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: <Widget>[
              _buildImageWidget(context),
              _buildTextWidget(),
              _buildContentWidget(),
              _buildOperateWidget(),
            ],
          ),
        ));
  }

  ///图片区域
  ///要求顶部距离是父布局的8%
  _buildImageWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return img != null
        ? Container(
            padding: isCenterVertical
                ? null
                : EdgeInsets.only(top: topOffset ?? height * topPercent),
            child: img,
          )
        : const SizedBox.shrink();
  }

  ///文案区域：标题
  _buildTextWidget() {
    return title != null
        ? Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(60, 24, 60, 0),
            child: Text(title!,
                textAlign: TextAlign.center,
                style: themeData!.titleTextStyle.generateTextStyle()),
          )
        : const SizedBox.shrink();
  }

  ///文案区域：内容
  _buildContentWidget() {
    return content != null
        ? Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(60, 12, 60, 0),
            child: Text(content!,
                textAlign: TextAlign.center,
                style: themeData!.contentTextStyle.generateTextStyle()),
          )
        : const SizedBox.shrink();
  }

  ///操作区域
  _buildOperateWidget() {
    return operateTexts != null
        ? Container(
            padding: EdgeInsets.only(top: 36),
            child: _buildOperateContentWidget(),
          )
        : const SizedBox.shrink();
  }

  ///操作区按钮
  _buildOperateContentWidget() {
    if (OperateAreaType.singleButton == operateAreaType) {
      return GestureDetector(
        onTap: () {
          if (action != null) action!(0);
        },
        child: Container(
          constraints: BoxConstraints(minWidth: themeData!.singleMinWidth),
          padding: EdgeInsets.fromLTRB(48, 16, 48, 16),
          decoration: BoxDecoration(
              color: themeData!.commonConfig.brandPrimary,
              borderRadius:
                  BorderRadius.all(Radius.circular(themeData!.btnRadius))),
          child: Text(operateTexts![0],
              textAlign: TextAlign.center,
              style: themeData!.singleTextStyle.generateTextStyle()),
        ),
      );
    } else if (OperateAreaType.doubleButton == operateAreaType) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (action != null) action!(0);
            },
            child: Container(
              constraints: BoxConstraints(minWidth: themeData!.doubleMinWidth),
              padding: EdgeInsets.fromLTRB(36, 16, 36, 16),
              decoration: BoxDecoration(
                  color: themeData!.commonConfig.brandPrimary.withAlpha(0x14),
                  borderRadius:
                      BorderRadius.all(Radius.circular(themeData!.btnRadius))),
              child: Text(operateTexts![0],
                  textAlign: TextAlign.center,
                  style: themeData!.doubleTextStyle.generateTextStyle()),
            ),
          ),
          Container(
            width: 12,
            color: Colors.transparent,
          ),
          GestureDetector(
            onTap: () {
              if (action != null) action!(1);
            },
            child: Container(
              constraints: BoxConstraints(minWidth: themeData!.doubleMinWidth),
              padding: EdgeInsets.fromLTRB(36, 16, 36, 16),
              decoration: BoxDecoration(
                  color: themeData!.commonConfig.brandPrimary.withAlpha(0x14),
                  borderRadius:
                      BorderRadius.all(Radius.circular(themeData!.btnRadius))),
              child: Text(operateTexts![1],
                  textAlign: TextAlign.center,
                  style: themeData!.doubleTextStyle.generateTextStyle()),
            ),
          ),
        ],
      );
    } else if (OperateAreaType.textButton == operateAreaType) {
      return GestureDetector(
          onTap: () {
            if (action != null) action!(0);
          },
          child: Text(operateTexts![0],
              style: themeData!.operateTextStyle.generateTextStyle()));
    }
    return const SizedBox.shrink();
  }
}
