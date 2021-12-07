import 'package:bruno/src/components/appraise/brn_appraise_emoji_list_view.dart';
import 'package:bruno/src/components/appraise/brn_appraise_header.dart';
import 'package:bruno/src/components/appraise/brn_appraise_star_list_view.dart';
import 'package:bruno/src/components/appraise/brn_mulit_select_tags.dart';
import 'package:bruno/src/components/button/brn_big_main_button.dart';
import 'package:bruno/src/components/input/brn_input_text.dart';
import 'package:bruno/src/components/picker/brn_tags_picker_config.dart';
import 'package:flutter/material.dart';

/// 点击表情或者星星时的回调
/// index 点击的表情或者星星的index
typedef BrnAppraiseIconClick = void Function(int index);

/// 点击tag的回调
/// selectedTags 所有选中标签的集合
typedef BrnAppraiseTagClick = void Function(List<String> selectedTags);

/// 提交按钮点击事件回调
/// index 选中的表情或者星星的index
/// selectedTags 所有选中标签的集合
/// input 自定义输入的内容
typedef BrnAppraiseConfirmClick = void Function(int index, List<String> selectedTags, String input);

/// 点击关闭的回掉
typedef BrnAppraiseCloseClickCallBack = void Function(BuildContext context);

/// /// /// /// /// /// /// /// /// /
/// 描述: 评价组件
/// 1. 支持表情包和星星两种
/// 2. 最多支持5个表情和5颗星
/// 3. 支持自定义title，标签等，在BrnAppraiseConfig里配置
/// 4. 可以用在页面里面也可以使用在弹窗里面，使用在底部弹窗的参考[BrnAppraiseBottomPicker]
/// /// /// /// /// /// /// /// /// /

const BrnAppraiseConfig cConfig = BrnAppraiseConfig();

class BrnAppraise extends StatefulWidget {
  /// 标题
  final String title;

  /// 标题类型，取值[BrnAppraiseHeaderType]
  /// center 标题居中
  /// spaceBetween 标题和关闭居于两侧
  /// 默认值BrnAppraiseHeaderType.spaceBetween
  final BrnAppraiseHeaderType headerType;

  /// 评分组件类型，取值[BrnAppraiseType]
  /// Emoji 表示使用表情包评价
  /// star 使用星星打分
  /// 默认值 BrnAppraiseType.Star
  final BrnAppraiseType type;

  /// 自定义文案
  /// 若评分组件为表情，则list长度为5，不足5个时请在对应位置补空字符串
  /// 若评分组件为星星，则list长度不能比count小
  final List<String> iconDescriptions;

  /// 标签
  final List<String> tags;

  ///输入框允许提示文案
  final String inputHintText;

  /// 提交按钮的点击回调
  final BrnAppraiseConfirmClick onConfirm;

  /// 评价组件的配置项
  final BrnAppraiseConfig config;

  /// 评价组建每个评分对应的默认文案
  static const List<String> _defaultIconDescriptions = ['不好', '还行', '满意', '很棒', '超惊喜'];

  BrnAppraise({
    this.title,
    this.headerType = BrnAppraiseHeaderType.spaceBetween,
    this.type = BrnAppraiseType.Star,
    this.iconDescriptions = _defaultIconDescriptions,
    this.tags,
    this.inputHintText,
    this.onConfirm,
    this.config = cConfig,
  });

  @override
  _BrnAppraiseState createState() => _BrnAppraiseState();
}

class _BrnAppraiseState extends State<BrnAppraise> {
  int _appraiseIndex = -1;
  bool _enable;
  String _inputText;
  List<String> _selectedTag;

  @override
  void initState() {
    _enable = widget.config?.isConfirmButtonEnabled;
    super.initState();
  }

  @override
  void didUpdateWidget(BrnAppraise oldWidget) {
    _enable = widget.config?.isConfirmButtonEnabled;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _headerArea(context),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: _getIconWidget(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: _getTags(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: _inputArea(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: _confirmButton(),
          ),
        ],
      ),
    );
  }

  /// header
  Widget _headerArea(BuildContext context) {
    EdgeInsets defaultPadding = (widget.headerType == BrnAppraiseHeaderType.center)
        ? EdgeInsets.only(top: 20, bottom: 20)
        : EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 20);
    return BrnAppraiseHeader(
      showHeader: widget.config?.showHeader ?? true,
      headerType: widget.headerType ?? BrnAppraiseHeaderType.spaceBetween,
      title: widget.title ?? '',
      maxLines: widget.config?.titleMaxLines ?? 1,
      headPadding: widget.config?.headerPadding ?? defaultPadding,
      cancelCallBack: widget.config?.onCancel,
    );
  }

  /// 获取评分组件
  Widget _getIconWidget() {
    if (widget.type == BrnAppraiseType.Emoji) {
      return BrnAppraiseEmojiListView(
        indexes: widget.config?.indexes,
        titles: widget.iconDescriptions,
        onTap: (index) {
          setState(() {
            _appraiseIndex = index;
          });
          if (widget.config?.iconClickCallback != null) {
            widget.config.iconClickCallback(index);
          }
        },
      );
    } else {
      return BrnAppraiseStarListView(
        count: widget.config?.count ?? 5,
        titles: widget.iconDescriptions,
        hint: widget.config?.starAppraiseHint,
        onTap: (index) {
          setState(() {
            _appraiseIndex = index;
          });
          if (widget.config?.iconClickCallback != null) {
            widget.config.iconClickCallback(index);
          }
        },
      );
    }
  }

  /// 标签
  Widget _getTags() {
    if (widget.tags?.isEmpty ?? true) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: BrnMultiSelectTags(
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        tagPickerBean: BrnTagsPickerConfig(
          tagItemSource: string2Tag(widget.tags),
        ),
        tagText: (choice) {
          return choice.name;
        },
        // tagStyle: BrnMultiSelectStyle.auto,
        multiSelect: widget.config?.multiSelect ?? true,
        brnCrossAxisCount: widget.config?.tagCountEachRow ?? 2,
        selectedTagsCallback: (list) {
          _selectedTag = tag2String(list);
          if (widget.config?.tagSelectCallback != null) {
            widget.config.tagSelectCallback(_selectedTag);
          }
        },
      ),
    );
  }

  /// 输入框
  Widget _inputArea() {
    if (widget.config?.showTextInput ?? true) {
      return Padding(
        padding: EdgeInsets.only(top: 24),
        child: BrnInputText(
          maxLength: widget.config?.maxLength ?? 100,
          bgColor: Color(0xfff8f8f8),
          hint: widget.inputHintText ?? '',
          textString: _inputText ?? '',
          maxHeight: widget.config?.inputMaxHeight ?? 120,
          minHeight: 40,
          maxHintLines: widget.config?.maxHintLines ?? 1,
          padding: EdgeInsets.all(12),
          onTextChange: (input) {
            _inputText = input;
            if (widget.config?.inputTextChangeCallback != null) {
              widget.config.inputTextChangeCallback(input);
            }
          },
        ),
      );
    }
    return Container();
  }

  /// 提交按钮
  Widget _confirmButton() {
    if (widget.config?.showConfirmButton ?? true) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: BrnBigMainButton(
          title: widget.config?.confirmButtonText ?? '提交',
          isEnable: _enable ?? _appraiseIndex != -1,
          onTap: () {
            if (_enable ?? _appraiseIndex != -1) {
              if (widget.onConfirm != null) {
                widget.onConfirm(_appraiseIndex, _selectedTag, _inputText);
              }
            }
          },
        ),
      );
    }

    return Container();
  }

  List<BrnTagItemBean> string2Tag(List<String> tags) {
    List<BrnTagItemBean> items = List();
    if (tags?.isNotEmpty ?? false) {
      for (int i = 0; i < tags.length; i++) {
        items.add(BrnTagItemBean(name: tags[i], code: tags[i], index: i));
      }
    }
    return items;
  }

  List<String> tag2String(List<BrnTagItemBean> tags) {
    List<String> result = List();
    tags?.forEach((item) {
      result.add(item.name);
    });
    return result;
  }
}

class BrnAppraiseConfig {
  /// 是否显示标题和关闭
  final bool showHeader;

  /// 标题的padding
  final EdgeInsets headerPadding;

  /// 标题的最大行数
  final int titleMaxLines;

  /// 取消的回调
  final BrnAppraiseCloseClickCallBack onCancel;

  /// 所需表情包的index列表，index最大值为4
  final List<int> indexes;

  /// 展示的星星的数目
  final int count;

  /// 展示星星时的默认提示
  final String starAppraiseHint;

  /// 标签是否支持多选，默认为 true
  final bool multiSelect;

  /// 每行能显示的tag数目，默认为 2
  final int tagCountEachRow;

  ///是否显示输入框，默认为 true
  final bool showTextInput;

  ///输入框允许输入的最大长度，默认为 100
  final int maxLength;

  ///提示文案的最大行数，默认为1
  final int maxHintLines;

  /// 输入框默认输入文案
  final String inputDefaultText;

  /// 输入框的最大高度，默认为 120
  final double inputMaxHeight;

  /// 是否显示确认按钮
  final bool showConfirmButton;

  /// 确认按钮的文案
  final String confirmButtonText;

  /// 外部控制提交button的enable状态,null有效，不设置默认值
  final bool isConfirmButtonEnabled;

  /// 点击icon的回调
  final BrnAppraiseIconClick iconClickCallback;

  /// 输入框改变的回调
  final BrnInputTextChangeCallback inputTextChangeCallback;

  /// 选择标签的回调
  final BrnAppraiseTagClick tagSelectCallback;

  const BrnAppraiseConfig({
    this.showHeader = true,
    this.headerPadding,
    this.titleMaxLines = 1,
    this.onCancel,
    this.indexes = const [0, 1, 2, 3, 4],
    this.count = 5,
    this.starAppraiseHint = '',
    this.multiSelect = true,
    this.tagCountEachRow = 2,
    this.showTextInput = true,
    this.maxLength = 100,
    this.maxHintLines = 1,
    this.inputDefaultText,
    this.inputMaxHeight = 120,
    this.showConfirmButton = true,
    this.confirmButtonText = '提交',
    this.isConfirmButtonEnabled,
    this.iconClickCallback,
    this.inputTextChangeCallback,
    this.tagSelectCallback,
  });
}

/// 评价组件类型
enum BrnAppraiseType {
  /// 表情包评价组件
  Emoji,

  /// 星星评价组件
  Star,
}
