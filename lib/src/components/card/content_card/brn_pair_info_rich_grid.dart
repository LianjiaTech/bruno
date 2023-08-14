import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_pair_info_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 两列key-value 展示信息的集合,需要配合[BrnRichGridInfo]使用
///
/// 组件内部是通过GridView来实现的，GridView是通过宽高比来实现子节点的布局
/// 并且组件内部处理了字体大小，高度变化的情况。
///
/// 和[BrnPairInfoTable]组件不同，该组件的每个组件都是单行展示
///
/// 除了基本的信息展示外，使用BrnRichGridInfo还可以实现富文本、复杂Widget的功能。
/// 样式：
///    支持文本、富文本和自定义的widget
///    常用的情况可以通过类中的静态函数构造
///    富文本和Icon的情况推荐使用 [BrnRichTextGenerator] 构造
///
/// BrnRichInfoGridWidget(
///     pairInfoList: <BrnRichGridInfo>[
///       BrnRichGridInfo.valueLastClickInfo('名称名称名称名称名称名称名称', '内容内容',
///           keyQuestionCallback: (value) {
///         BrnToast.show(value, context);
///       }),
///       BrnRichGridInfo("名称：", '内容内容内容'),
///       BrnRichGridInfo("名称：", '内容内容'),
///       BrnRichGridInfo("名称：", '内容'),
///      ],
/// ),
///
/// 其他信息展示组件
///  * [BrnEnhanceNumberCard], 强化数字信息展示组件
///  * [BrnPairInfoTable], 单列key-value信息集合组件
///
class BrnRichInfoGrid extends StatelessWidget {

  /// 待展示的文本信息
  final List<BrnRichGridInfo>? pairInfoList;

  ///行间距 纵向
  final double? rowSpace;

  ///gridView 为children包裹的padding，默认是从media中获取，支持修改
  ///同gridView的padding
  final EdgeInsetsGeometry? padding;

  ///元素间距 横向
  final double? space;

  /// item 的高度
  final double? itemHeight;

  /// 一共多少列 默认2列
  final int crossAxisCount;

  /// the theme config of BrnRichInfoGrid
  final BrnPairRichInfoGridConfig? themeData;

  /// create BrnRichInfoGrid
  BrnRichInfoGrid({
    Key? key,
    this.pairInfoList,
    this.padding,
    this.rowSpace,
    this.space,
    this.itemHeight,
    this.crossAxisCount = 2,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pairInfoList == null || pairInfoList!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildGridView(context);
  }

  Widget _buildGridView(context) {
    BrnPairRichInfoGridConfig defaultConfig =
        themeData ?? BrnPairRichInfoGridConfig();

    defaultConfig = defaultConfig.merge(BrnPairRichInfoGridConfig(
        itemSpacing: space, rowSpacing: rowSpace, itemHeight: itemHeight));
    defaultConfig = BrnThemeConfigurator.instance
        .getConfig(configId: defaultConfig.configId)
        .pairRichInfoGridConfig
        .merge(defaultConfig);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double gridWidth = constraints.maxWidth;
        if (gridWidth == double.infinity) {
          gridWidth = MediaQuery.of(context).size.width;
        }
        double itemHeight =
            defaultConfig.itemHeight * (MediaQuery.textScaleFactorOf(context));
        double itemWidth = (gridWidth - defaultConfig.itemSpacing) / 2;

        var gridView = GridView.builder(
          shrinkWrap: true,
          padding: padding,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: defaultConfig.rowSpacing,
            crossAxisCount: this.crossAxisCount,
            crossAxisSpacing: defaultConfig.itemSpacing,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemBuilder: (context, index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _getKeyWidget(
                  pairInfoList![index],
                  gridWidth,
                  context,
                  defaultConfig,
                ),
                _getValueWidget(pairInfoList![index], defaultConfig)
              ],
            );
          },
          itemCount:
              (null != this.pairInfoList) ? this.pairInfoList!.length : 0,
        );
        return gridView;
      },
    );
  }

  Widget _getKeyWidget(BrnRichGridInfo info, double width, BuildContext context,
      BrnPairRichInfoGridConfig config) {
    if (info.keyPart == null) {
      return const SizedBox.shrink();
    }

    if (info.keyPart is String) {
      return Container(
        constraints: BoxConstraints(maxWidth: width / 4),
        child: Text(info.keyPart,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _getKeyStyle(themeData: config)),
      );
    }
    if (info.keyPart is Widget) {
      return info.keyPart;
    }

    return const SizedBox.shrink();
  }

  Widget _getValueWidget(
      BrnRichGridInfo info, BrnPairRichInfoGridConfig config) {
    if (info.valuePart == null) {
      return Text('--', style: _getValueStyle('--', themeData: config));
    }
    if (info.valuePart is String) {
      String value = info.valuePart.isEmpty ? '--' : info.valuePart;
      return Expanded(
        child: Text(value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _getValueStyle(info.valuePart, themeData: config)),
      );
    }
    if (info.valuePart is Widget) {
      return info.valuePart;
    }

    return const SizedBox.shrink();
  }
}

/// 用于构建文本信息
class BrnRichGridInfo {

  ///
  final dynamic keyPart;
  final dynamic valuePart;

  BrnRichGridInfo(this.keyPart, this.valuePart);

  ///-----------以下静态方法为常见显示的快捷构造-----------
  /// value的最后一部分带有可点击的超链接
  ///
  /// keyTitle 显示的key文案
  /// valueTitle 显示的value文案
  /// clickValue 显示的可点击文案
  /// fontSize 文案的大小
  /// clickCallback 可点击文案点击的回调
  /// isArrow 是否最右侧存在箭头
  static BrnRichGridInfo valueLastClickInfo(
    BuildContext context,
    String keyTitle,
    String valueTitle, {
    Function(String key)? keyQuestionCallback,
    Function(String value)? valueQuestionCallback,
    String clickTitle = '',
    Color? clickColor,
    Function(String clickValue)? clickCallback,
    BrnPairRichInfoGridConfig? themeData,
  }) {
    themeData ??= BrnPairRichInfoGridConfig();
    themeData = BrnThemeConfigurator.instance
        .getConfig(configId: themeData.configId)
        .pairRichInfoGridConfig
        .merge(themeData);
    themeData = themeData.merge(BrnPairRichInfoGridConfig(
        linkTextStyle: BrnTextStyle(color: clickColor)));

    Widget _getQuestionImage(bool isKey) {
      return GestureDetector(
          onTap: () {
            if (isKey) {
              keyQuestionCallback!(keyTitle);
            } else {
              valueQuestionCallback!(valueTitle);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: isKey ? 0 : 4),
            child: BrunoTools.getAssetSizeImage(
                BrnAsset.iconPairInfoQuestion, 14, 14),
          ));
    }

    Widget _getClickValue({required BrnPairRichInfoGridConfig themeData}) {
      return GestureDetector(
        onTap: () {
          if (clickCallback != null) {
            clickCallback(clickTitle);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Container(
            constraints: BoxConstraints(maxWidth: 56),
            child: Text(clickTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: _getClickStyle(clickTitle, clickColor,
                    themeData: themeData)),
          ),
        ),
      );
    }

    bool isShowKeyQuestion = keyQuestionCallback != null;
    bool isShowValueQuestion = valueQuestionCallback != null;
    bool isShowValueClick = clickTitle.isNotEmpty;

    MediaQueryData mediaQuery = MediaQueryData.fromView(View.of(context));
    double screen = mediaQuery.size.width;

    Widget key = Container(
      constraints: BoxConstraints(
        maxWidth: screen / 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              keyTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _getKeyStyle(themeData: themeData),
            ),
          ),
          isShowKeyQuestion ? _getQuestionImage(true) : const SizedBox.shrink(),
          Text(
            '：',
            style: _getKeyStyle(themeData: themeData),
          ),
        ],
      ),
    );

    Widget value = Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              valueTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _getValueStyle(valueTitle, themeData: themeData),
            ),
          ),
          isShowValueClick
              ? _getClickValue(themeData: themeData)
              : const SizedBox.shrink(),
          isShowValueQuestion
              ? _getQuestionImage(false)
              : const SizedBox.shrink(),
        ],
      ),
    );

    return BrnRichGridInfo(key, value);
  }
}

TextStyle? _getKeyStyle({BrnPairRichInfoGridConfig? themeData}) =>
    themeData?.keyTextStyle.generateTextStyle();

TextStyle? _getClickStyle(String? content, Color? clickColor,
        {BrnPairRichInfoGridConfig? themeData}) =>
    themeData?.linkTextStyle.generateTextStyle();

TextStyle? _getValueStyle(String content,
        {BrnPairRichInfoGridConfig? themeData}) =>
    themeData?.valueTextStyle.generateTextStyle();
