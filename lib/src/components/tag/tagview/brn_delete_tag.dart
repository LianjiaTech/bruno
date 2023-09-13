import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 删除模式的标签
/// 支持下下流式和横向滑动布局
/// 可以外部主动添加和删除标签
/// 宽高间距可设置
/// 支持标签数量的增删
// ignore: must_be_immutable
class BrnDeleteTag extends StatefulWidget {
  /// 初始传入的标签，当传入controller的时候，应把初始标签放入controller的构造中
  final List<String>? tags;

  /// 标签控制器，用于主动添加和删除标签，如果使用场景只需要删除标签并进行回调可以不传控制器
  final BrnDeleteTagController? controller;

  /// 点击删除某个标签后的回调，参数包含
  /// 剩余的标签集合
  /// 被删除的标签内容
  /// 被删除的标签索引
  final Function(List<String>, String?, int)? onTagDelete;

  /// 垂直方向的间距
  final double? verticalSpacing;

  /// 水平方向的间距
  final double? horizontalSpacing;

  /// 标签的字体颜色
  final TextStyle? tagTextStyle;

  /// 标签的圆角
  final OutlinedBorder? shape;

  /// 标签背景色
  final Color? backgroundColor;

  /// 删除图标的颜色
  final Color? deleteIconColor;

  /// true 流式展示，false 横向滑动展示，默认 true
  final bool softWrap;

  /// 内容边距，默认 EdgeInsets.fromLTRB(20, 0, 20, 0)
  final EdgeInsets padding;

  /// 主题配置信息，包含标签背景色、文本颜色等字段，非必传
  BrnTagConfig? themeData;

  /// delete Icon Size，不传默认使用 内置删除 icon 图片的的大小，
  final Size? deleteIconSize;

  BrnDeleteTag(
      {Key? key,
      this.tags,
      this.controller,
      this.onTagDelete,
      this.verticalSpacing,
      this.horizontalSpacing,
      this.tagTextStyle,
      this.shape,
      this.backgroundColor,
      this.deleteIconColor,
      this.deleteIconSize,
      this.softWrap = true,
      this.padding = const EdgeInsets.fromLTRB(20, 0, 20, 0),
      this.themeData})
      : super(key: key) {
    themeData ??= BrnTagConfig();
    themeData = BrnThemeConfigurator.instance
        .getConfig(configId: themeData!.configId)
        .tagConfig
        .merge(this.themeData);
    themeData = themeData!.merge(BrnTagConfig(
        tagBackgroundColor: this.backgroundColor,
        tagTextStyle: BrnTextStyle.withStyle(tagTextStyle)));
  }

  @override
  _BrnDeleteTagState createState() => _BrnDeleteTagState();
}

class _BrnDeleteTagState extends State<BrnDeleteTag> {
  late BrnDeleteTagController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? BrnDeleteTagController(initTags: widget.tags);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ValueListenableBuilder<List<String>>(
          valueListenable: _controller.notifier,
          builder: (context, value, _) {
            return _buildContent(value);
          },
        ));
  }

  /// 根据标签集合构建标签 UI
  Widget _buildContent(List<String> tags) {
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    List<Widget> itemList = [];
    for (int i = 0; i < tags.length; i++) {
      itemList.add(DeleteTagItemWidget(
        i,
        tags[i],
        _deleteTag,
        deleteIconSize: widget.deleteIconSize,
        style: widget.themeData!.tagTextStyle.generateTextStyle(),
        shape: widget.shape,
        backgroundColor: widget.themeData!.tagBackgroundColor,
        deleteIconColor: widget.deleteIconColor,
        themeData: widget.themeData,
      ));
    }
    Widget result;
    if (widget.softWrap) {
      result = Wrap(
        spacing: widget.horizontalSpacing ?? 10,
        runSpacing:
            widget.verticalSpacing != null ? widget.verticalSpacing! - 16 : -6,
        alignment: WrapAlignment.start,
        children: itemList,
      );
    } else {
      int tagIdx = 0;
      var finalTagList = itemList.map((tag) {
        double rightPadding = (tagIdx == itemList.length - 1)
            ? 0
            : widget.horizontalSpacing ?? 12;
        var padding = Padding(
          child: tag,
          padding: EdgeInsets.only(right: rightPadding),
        );
        tagIdx++;
        return padding;
      }).toList();
      result = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: finalTagList,
          ));
    }

    return Container(
      color: Colors.white,
      padding: widget.padding,
      alignment: Alignment.centerLeft,
      child: result,
    );
  }

  /// 删除指定 index 下标的标签，并且回调通知外部使用者
  void _deleteTag(int index) {
    String? result = _controller.deleteForIndex(index);
    if (widget.onTagDelete != null) {
      widget.onTagDelete!(_controller.tags, result, index);
    }
  }
}

/// 标签具体子项，配置属性可参考 [BrnDeleteTag]
// ignore: must_be_immutable
class DeleteTagItemWidget extends StatelessWidget {
  final int index;
  final String title;
  final Function(int) didDeleted;
  final Size? deleteIconSize;
  final TextStyle? style;
  final OutlinedBorder? shape;
  final Color? backgroundColor;
  final Color? deleteIconColor;
  final BrnTagConfig? themeData;

  DeleteTagItemWidget(this.index, this.title, this.didDeleted,
      {this.deleteIconSize,
      this.style,
      this.shape,
      this.backgroundColor,
      this.deleteIconColor,
      this.themeData});

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.fromLTRB(10, 0, -3, 0),
      labelPadding: EdgeInsets.fromLTRB(0, 0, -3, 0),
      backgroundColor: themeData!.tagBackgroundColor,
      label: Text(this.title,
          overflow: TextOverflow.ellipsis,
          style: themeData!.tagTextStyle.generateTextStyle()),
      shape: shape ??
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(themeData!.tagRadius)),
      //删除图标
      deleteIcon: deleteIconSize != null
          ? BrunoTools.getAssetSizeImage(
              BrnAsset.iconClose, deleteIconSize!.width, deleteIconSize!.height,
              color: deleteIconColor)
          : BrunoTools.getAssetImageWithColor(
              BrnAsset.iconClose, deleteIconColor),
      onDeleted: () {
        debugPrint('$index');
        didDeleted(index);
      },
    );
  }
}

/// 标签控制器，用于主动添加和删除标签
class BrnDeleteTagController {
  late ValueNotifier<List<String>> notifier;

  /// 控制器中存储的标签数据
  List<String> _tags = [];

  List<String> get tags => notifier.value;

  BrnDeleteTagController({List<String>? initTags}) {
    _tags = initTags ?? [];
    notifier = ValueNotifier(_tags);
  }

  /// 初始时设置全量的标签
  void setTags(List<String> tags) {
    this._tags = tags;
    _asyncData();
  }

  /// 添加标签集合
  void addTags(List<String> tags) {
    _tags.addAll(tags);
    _asyncData();
  }

  /// 添加单个标签到集合末尾
  void addTag(String tag) {
    _tags.add(tag);
    _asyncData();
  }

  /// 清空所有标签
  void clear() {
    _tags.clear();
    _asyncData();
  }

  /// 删除指定 index 的标签，并返回其内容
  String? deleteForIndex(int index) {
    if (_tags.length > index) {
      String result = _tags.removeAt(index);
      _asyncData();
      return result;
    } else {
      return null;
    }
  }

  /// 删除某个具体内容的标签，成功返回 true，失败返回 false
  bool deleteForTag(String tag) {
    bool result = _tags.remove(tag);
    _asyncData();
    return result;
  }

  void _asyncData() {
    // notifier 中的 value 引用是 _tags 所以直接赋值 _tags 不会触发回调
    List<String> values = [];
    _tags.forEach((e) => values.add(e));
    notifier.value = values;
  }
}
