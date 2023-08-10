import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_card_title_config.dart';
import 'package:flutter/material.dart';

/// 普通的卡片标题组件
///
/// 组件的展示规则：
///         1：标题可以折行展示
///         2：标题最右侧的widget 需要展示出来
///         3：标题底部的detail 信息展示的长度是 折行的长度，只显示1行
///         4：标题的文案和sub需要流式布局
///
/// 布局间距：
///     标题 和 最右侧的accessory的间距为 8dp
///     标题和subTitleWidget的间距为 8dp
///     标题和底部的间距为 4dp
///     默认自带上面16的间距
///
/// 布局规则：
///    为了保证标题[title]和最右侧的[accessoryWidget]居中对齐，accessoryWidget的高度就是25,如果传入的widget过大会显示不全
///    因为该部分的实现，是通过RichText实现的，并不会截断，会根据文本的多少流式布局
///
/// 整个组件是可以响应点击事件的[onTap]
///
/// 标题为文本、跟随标题为标签、最右侧为自定义Widget
/// BrnCommonCardTitle(
///    title: '非箭头非箭头',
///    accessoryWidget: BrnStateTag(tagText: '状态标签'),
///    subTitleWidget: BrnStartRatingIndicator(rating: 4),
///    onTap: () {
///        BrnToast.show('BrnCommonCardTitle is clicked', context);
///    },
/// )
///
/// 标题为文本、最右侧为自定义Widget、标题下方为长文本
/// BrnCommonCardTitle(
///    title: '非箭头Title',
///    detailTextString: '房产证地址与楼盘字房产证地址与楼盘字房产证地址与楼盘字房产证地址与楼盘字房产证地址与楼盘字',
///    subTitleWidget: BrnStartRatingIndicator(rating: 4),
///    onTap: () {
///        BrnToast.show('BrnCommonCardTitle is clicked', context);
///    },
/// )
/// 相关按钮如下:
///  * [BrnActionCardTitle], 右侧为箭头的卡片标题组件
///
class BrnCommonCardTitle extends StatelessWidget {
  /// 标题
  final String title;

  /// 最右侧的文字
  final String? accessoryText;

  /// 最右侧的widget 如果两者同时存在 则以widget为主
  final Widget? accessoryWidget;

  /// 整个区域点击的回调
  final VoidCallback? onTap;

  /// 标题右侧的显示widget
  final Widget? subTitleWidget;

  /// 标题下面的文字
  final String? detailTextString;

  /// title的流式文本的对齐方式
  final PlaceholderAlignment? alignment;

  /// 标题下方文字 默认是深色的222222
  final Color? detailColor;

  /// 内容的padding 默认上16下12 左右0
  final EdgeInsetsGeometry? padding;

  /// 标题最大行数
  final int? titleMaxLines;

  /// 标题 Overflow 展示方式，默认 TextOverflow.clip
  /// 注意，由于 subTitleWidget 与 title 是流式布局，所以 subTitleWidget 会折叠
  final TextOverflow titleOverflow;

  /// the theme config of BrnCommonCardTitle
  final BrnCardTitleConfig? themeData;

  /// create BrnCommonCardTitle
  const BrnCommonCardTitle(
      {Key? key,
      required this.title,
      this.accessoryText,
      this.accessoryWidget,
      this.onTap,
      this.subTitleWidget,
      this.detailTextString,
      this.detailColor,
      this.alignment,
      this.padding,
      this.titleMaxLines,
      this.titleOverflow = TextOverflow.clip,
      this.themeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BrnCardTitleConfig defaultConfig = themeData ?? BrnCardTitleConfig();

    BrnCardTitleConfig cardTitleConfig = BrnCardTitleConfig(
        alignment: alignment,
        cardTitlePadding: padding as EdgeInsets?,
        detailTextStyle: BrnTextStyle(color: detailColor));

    defaultConfig = BrnThemeConfigurator.instance
        .getConfig(configId: defaultConfig.configId)
        .cardTitleConfig
        .merge(themeData)
        .merge(cardTitleConfig);

    Widget titleContainer = Container(
      color: defaultConfig.cardBackgroundColor,
      child: _rowWidget(context, defaultConfig),
    );
    if (onTap == null) return titleContainer;
    return GestureDetector(
      onTap: onTap,
      child: titleContainer,
    );
  }

  Widget _rowWidget(BuildContext context, BrnCardTitleConfig defaultConfig) {
    List<Widget> children = [];
    children.add(Expanded(child: _titleWidget(context, defaultConfig)));

    Widget accessory = const SizedBox.shrink();
    // 左侧的文本的行高是25，那么右侧的widget最大为25
    if (this.accessoryWidget != null) {
      accessory = Container(
        height: 25,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 4),
        child: accessoryWidget,
      );
    } else if (this.accessoryText?.isNotEmpty ?? false) {
      accessory = _accessoryTextWidget(defaultConfig);
    }
    children.add(accessory);

    return Padding(
      padding: defaultConfig.cardTitlePadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  ///标题最右侧的widget
  Widget _accessoryTextWidget(BrnCardTitleConfig defaultConfig) {
    Text tx = Text(
      accessoryText ?? "",
      style: defaultConfig.accessoryTextStyle.generateTextStyle(),
    );

    return Container(
      child: tx,
      height: 25,
      padding: EdgeInsets.only(left: 4),
      alignment: Alignment.center,
    );
  }

  ///标题右侧的widget
  Widget _subTitleWidgetFromWidget() {
    return Padding(
      child: subTitleWidget,
      padding: EdgeInsets.only(left: 4),
    );
  }

  ///标题widget
  Widget _titleWidget(BuildContext context, BrnCardTitleConfig defaultConfig) {
    Widget subWidget = const SizedBox.shrink();

    if (subTitleWidget != null) {
      subWidget = _subTitleWidgetFromWidget();
    }
    var titleWidget = RichText(
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      maxLines: this.titleMaxLines,
      overflow: this.titleOverflow,
      text: TextSpan(
          text: title,
          style: defaultConfig.titleWithHeightTextStyle.generateTextStyle(),
          children: <InlineSpan>[
            WidgetSpan(child: subWidget, alignment: defaultConfig.alignment),
          ]),
    );

    List<Widget> colChildren = [];
    colChildren.add(titleWidget);

    if (null != detailTextString && detailTextString!.isNotEmpty) {
      Widget detailWidget = _detailTextWidget(defaultConfig);
      colChildren.add(detailWidget);
    }
    Column column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: colChildren,
    );

    return column;
  }

  ///标题下方的widget
  Widget _detailTextWidget(BrnCardTitleConfig defaultConfig) {
    Text tx = Text(
      detailTextString ?? "",
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: defaultConfig.detailTextStyle.generateTextStyle(),
    );
    return Container(
      child: tx,
      padding: EdgeInsets.only(top: 4),
    );
  }
}
