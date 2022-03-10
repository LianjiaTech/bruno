import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/components/line/brn_line.dart';
import 'package:bruno/src/components/radio/brn_radio_button.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:flutter/material.dart';

/// 备选项点击时的回调。[oldStr] 旧的选项，如果初始没有选中项，该参数为null，[newStr] 新选中的选项。
typedef BrnPortraitRadioGroupOnChanged = void Function(
    BrnPortraitRadioGroupOption? oldStr, BrnPortraitRadioGroupOption newStr);

/// 纵向放置的单选 radio 视图。选项可为单行字符串，也可是标题+说明两部分。具体参见 [BrnPortraitRadioGroupOption]。
/// 选项的标题/子标题文字样式分别通过 [BrnFormItemConfig.optionTextStyle] 和 [BrnFormItemConfig.subTitleTextStyle] 控
/// 制，可通过主题配置进行修改。
// ignore: must_be_immutable
class BrnPortraitRadioGroup extends StatefulWidget {
  /// 录入项内容是否可编辑，false 时全部选项置灰，默认为 true。
  final bool isEdit;

  /// 初始化时默认选中的项，匹配逻辑是 [BrnPortraitRadioGroupOption.title] 和 [BrnPortraitRadioGroupOption.subTitle] 都相等。
  final BrnPortraitRadioGroupOption? selectedOption;

  /// 备选项数组，参数类型为 [BrnPortraitRadioGroupOption]
  final List<BrnPortraitRadioGroupOption>? options;

  /// 备选项可用状态数组
  final List<bool>? enableList;

  /// 选项变化回调
  final BrnPortraitRadioGroupOnChanged? onChanged;

  /// [options] 中 title subTitle 是否换行展示。
  /// false: 换行展示
  /// true: 只展示一行，一行展示不下末尾[...]省略展示
  /// 默认值为 false
  final bool isCollapseContent;

  /// 主题配置数据
  BrnFormItemConfig? themeData;

  /// 通过传入一个字符串数组 [options]，快捷构造出单行选项文案的纵向单选视图。
  BrnPortraitRadioGroup.withSimpleList({
    Key? key,
    this.isEdit = true,
    String selectedOption = "",
    required List<String> options,
    this.enableList,
    this.onChanged,
    this.themeData,
    this.isCollapseContent = false,
  })  : this.options = options
            .map((item) => BrnPortraitRadioGroupOption(title: item))
            .toList(),
        this.selectedOption = options.indexOf(selectedOption) > -1
            ? BrnPortraitRadioGroupOption(
                title: options[options.indexOf(selectedOption)])
            : BrnPortraitRadioGroupOption(),
        super(key: key) {
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
  }

  /// 通过 [BrnPortraitRadioGroupOption] 类型的数组 [options]，构造纵向单选视图。
  BrnPortraitRadioGroup.withOptions({
    Key? key,
    this.isEdit = true,
    this.selectedOption,
    this.options,
    this.enableList,
    this.onChanged,
    this.isCollapseContent = false,
    this.themeData,
  }) : super(key: key) {
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
  }

  @override
  BrnPortraitRadioGroupState createState() {
    return BrnPortraitRadioGroupState();
  }
}

class BrnPortraitRadioGroupState extends State<BrnPortraitRadioGroup> {
  late BrnPortraitRadioGroupOption? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: getRadioList(widget.options),
      ),
    );
  }

  List<Widget> getRadioList(List<BrnPortraitRadioGroupOption>? options) {
    List<Widget> result = [];
    BrnPortraitRadioGroupOption option;
    if (options == null || options.isEmpty) {
      result.add(Container());
      return result;
    }

    result.add(BrnLine(
      leftInset: 20,
    ));

    for (int index = 0; index < options.length; ++index) {
      option = options[index];
      result.add(
        Container(
          padding: EdgeInsets.only(top: 14, bottom: 14, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BrnRadioButton(
                child: Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    option.title ?? '',
                    overflow:
                        widget.isCollapseContent ? TextOverflow.ellipsis : null,
                    maxLines: widget.isCollapseContent ? 1 : null,
                    style: getOptionTextStyle(option, index),
                  ),
                ),
                childOnRight: false,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                disable: getRadioEnableState(index),
                radioIndex: index,
                isSelected: index == getGroupValue(),
                onValueChangedAtIndex: (int position, bool selected) {
                  if (getRadioEnableState(position)) {
                    return;
                  }
                  BrnPortraitRadioGroupOption? oldValue = _selectedOption;
                  _selectedOption = options[position];
                  if (widget.onChanged != null) {
                    widget.onChanged!(oldValue, options[position]);
                  }
                  setState(() {});
                },
              ),
              Visibility(
                visible: option.subTitle != null && option.subTitle!.length > 0,
                child: Padding(
                  padding: EdgeInsets.only(top: 4, right: 20),
                  child: Text(
                    option.subTitle ?? '',
                    overflow:
                        widget.isCollapseContent ? TextOverflow.ellipsis : null,
                    maxLines: widget.isCollapseContent ? 1 : null,
                    style: BrnFormUtil.getSubTitleTextStyle(widget.themeData!),
                  ),
                ),
              )
            ],
          ),
        ),
      );

      result.add(BrnLine(
        leftInset: 20,
        rightInset: 20,
      ));
    }

    return result;
  }

  int getGroupValue() {
    int selectedIndex = -1;
    for (int index = 0; index < widget.options!.length; index++) {
      if (isSameOption(widget.options![index], _selectedOption)) {
        selectedIndex = index;
        break;
      }
    }
    return selectedIndex;
  }

  bool isSameOption(
      BrnPortraitRadioGroupOption src, BrnPortraitRadioGroupOption? dst) {
    if (dst == null) return false;
    return src.title == dst.title && src.subTitle == dst.subTitle;
  }

  TextStyle getOptionTextStyle(BrnPortraitRadioGroupOption opt, int index) {
    TextStyle result = BrnFormUtil.getOptionTextStyle(widget.themeData!);

    if (isSameOption(opt, _selectedOption)) {
      result = BrnFormUtil.getOptionSelectedTextStyle(widget.themeData!);
    }

    if (!widget.isEdit) {
      result = BrnFormUtil.getIsEditTextStyle(widget.themeData!, widget.isEdit);
    }

    if (widget.enableList != null &&
        widget.enableList!.isNotEmpty &&
        widget.enableList!.length > index &&
        !widget.enableList![index]) {
      result = BrnFormUtil.getIsEditTextStyle(widget.themeData!, false);
    }

    return result;
  }

  bool getRadioEnableState(int index) {
    if (!widget.isEdit) {
      return true;
    }

    if (widget.enableList == null ||
        widget.enableList!.isEmpty ||
        widget.enableList!.length < index) {
      return false;
    }

    return !widget.enableList![index];
  }
}

/// 纵置单选视图的选项模型。文字样式见 [BrnPortraitRadioGroup] 说明。
class BrnPortraitRadioGroupOption {
  /// 标题
  String? title;

  /// 子标题说明文案
  String? subTitle;

  BrnPortraitRadioGroupOption({this.title, this.subTitle});
}
