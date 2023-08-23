import 'package:bruno/src/components/form/base/brn_form_item_type.dart';
import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:bruno/src/constants/brn_fonts_constants.dart';
import 'package:flutter/material.dart';

///
/// 快速选择类型录入项
///
/// 包括"标题"、"副标题"、"错误信息提示"、"必填项提示"、"添加/删除按钮"、"消息提示"、
/// "点击选择区"、"快捷选择按钮"等元素
///
/// 点击右侧文本显示区域后触发 onTap 回调函数，用户可在此回调函数中执行启动弹框，跳转页面等操作
///
// ignore: must_be_immutable
class BrnTextQuickSelectFormItem extends StatefulWidget {
  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String? label;

  /// 录入项标题
  final String title;

  /// 录入项子标题
  final String? subTitle;

  /// 录入项提示（问号图标&文案） 用户点击时触发onTip回调。
  ///   1. 若赋值为 空字符串（""）时仅展示"问号"图标，
  ///   2. 若赋值为非空字符串时 展示"问号图标&文案"，
  ///   3. 若不赋值或赋值为null时 不显示提示项
  /// 默认值为 3
  final String? tipLabel;

  /// 录入项前缀图标样式 "添加项" "删除项" 详见 PrefixIconType类
  final String prefixIconType;

  /// 录入项错误提示
  final String error;

  /// 录入项是否为必填项（展示*图标） 默认为 false 不必填
  final bool isRequire;

  /// 录入项 是否可编辑
  final bool isEdit;

  /// 点击"+"图标回调
  final VoidCallback? onAddTap;

  /// 点击"-"图标回调
  final VoidCallback? onRemoveTap;

  /// 点击"?"图标回调
  final VoidCallback? onTip;

  /// 点击录入区回调
  final VoidCallback? onTap;

  /// 按钮点击
  final ValueChanged<int>? onBtnSelectChanged;

  /// 录入项 hint 提示
  final String? hint;

  /// 录入项 值
  String? value;

  /// 快捷操作按钮选项文案列表
  List<String>? btnsTxt;

  /// 快捷按钮区的初始选中状态，可不传，则内部自动生成并维护
  List<bool>? selectBtnList;

  /// 快捷按钮区的是否可用状态，可不传，内部生成并维护
  List<bool>? enableBtnList;

  /// 用户自定义快捷按钮视图
  Widget? btns;

  /// 快捷按钮较多时是否可滑动，默认为 fasle，不可滑动
  final bool isBtnsScroll;

  BrnFormItemConfig? themeData;

  /// 背景色
  final Color? backgroundColor;

  BrnTextQuickSelectFormItem(
      {Key? key,
      this.label,
      this.title = "",
      this.subTitle,
      this.tipLabel,
      this.prefixIconType = BrnPrefixIconType.normal,
      this.error = "",
      this.isEdit = true,
      this.isRequire = false,
      this.onAddTap,
      this.onRemoveTap,
      this.onTip,
      this.hint,
      this.value,
      this.btnsTxt,
      this.selectBtnList,
      this.enableBtnList,
      this.btns,
      this.isBtnsScroll = false,
      this.onTap,
      this.onBtnSelectChanged,
      this.backgroundColor,
      this.themeData})
      : super(key: key) {
    themeData ??= BrnFormItemConfig();
    themeData = BrnThemeConfigurator.instance
        .getConfig(configId: themeData!.configId)
        .formItemConfig
        .merge(themeData);
    this.themeData = this
        .themeData!
        .merge(BrnFormItemConfig(backgroundColor: backgroundColor));
  }

  @override
  BrnTextQuickSelectFormItemState createState() {
    return BrnTextQuickSelectFormItemState();
  }
}

class BrnTextQuickSelectFormItemState
    extends State<BrnTextQuickSelectFormItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.themeData!.backgroundColor,
      padding: BrnFormUtil.itemEdgeInsets(widget.themeData!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 25,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: BrnFormUtil.titleEdgeInsets(widget.prefixIconType,
                      widget.isRequire, widget.themeData!),
                  child: Row(
                    children: <Widget>[
                      BrnFormUtil.buildPrefixIcon(
                          widget.prefixIconType,
                          widget.isEdit,
                          context,
                          widget.onAddTap,
                          widget.onRemoveTap),

                      // 必填项
                      BrnFormUtil.buildRequireWidget(widget.isRequire),

                      // 主标题
                      BrnFormUtil.buildTitleWidget(
                          widget.title, widget.themeData!),

                      // 问号提示
                      BrnFormUtil.buildTipLabelWidget(
                          widget.tipLabel, widget.onTip, widget.themeData!),
                    ],
                  ),
                ),

                /// 文案选择区
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!widget.isEdit) {
                        return;
                      }

                      if (widget.onTap != null) {
                        widget.onTap!();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: buildText()),
                        Container(
                          child: BrnFormUtil.getRightArrowIcon(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 副标题
          BrnFormUtil.buildSubTitleWidget(widget.subTitle, widget.themeData!),

          /// 快捷按钮区
          Container(
              height: 40,
              padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: QuickButtonsWidget(
                btnsTxt: widget.btnsTxt,
                selectBtnList: widget.selectBtnList,
                enableBtnList: widget.enableBtnList,
                btns: widget.btns,
                isBtnsScroll: widget.isBtnsScroll,
                isEdit: widget.isEdit,
                onBtnSelectChanged: widget.onBtnSelectChanged,
              )),

          /// 错误提示
          BrnFormUtil.buildErrorWidget(widget.error, widget.themeData!)
        ],
      ),
    );
  }

  Widget buildText() {
    if (widget.value != null && widget.value!.isNotEmpty) {
      return Text(
        widget.value!,
        textAlign: TextAlign.end,
        style: BrnFormUtil.getIsEditTextStyle(widget.themeData!, widget.isEdit),
      );
    } else {
      return Text(
        widget.hint ?? BrnIntl.of(context).localizedResource.pleaseChoose,
        textAlign: TextAlign.end,
        style: BrnFormUtil.getHintTextStyle(widget.themeData!),
      );
    }
  }
}

// ignore: must_be_immutable
class QuickButtonsWidget extends StatefulWidget {
  List<String>? btnsTxt;
  List<bool>? selectBtnList;
  List<bool>? enableBtnList;
  Widget? btns;
  bool? isBtnsScroll;
  bool isEdit;

  ValueChanged<int>? onBtnSelectChanged;

  QuickButtonsWidget({
    Key? key,
    this.btnsTxt,
    this.selectBtnList,
    this.enableBtnList,
    this.btns,
    this.isBtnsScroll,
    this.isEdit = true,
    this.onBtnSelectChanged,
  });

  @override
  State<StatefulWidget> createState() {
    return QuickButtonsState();
  }
}

class QuickButtonsState extends State<QuickButtonsWidget> {
  // 按钮状态是否使用内部维护
  bool _useInnerStatus = false;

  @override
  void initState() {
    initButtonParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getQuickButtons();
  }

  @override
  void didUpdateWidget(QuickButtonsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.selectBtnList = oldWidget.selectBtnList;
  }

  void initButtonParams() {
    /// 优先使用用户自定义按钮
    if (widget.btns != null) {
      return;
    }

    if (widget.btnsTxt == null) {
      widget.btnsTxt = <String>[];
    }

    if (widget.selectBtnList == null) {
      _useInnerStatus = true;
      widget.selectBtnList = List<bool>.filled(widget.btnsTxt!.length, false);
    }

    if (widget.enableBtnList == null) {
      widget.enableBtnList = List<bool>.filled(widget.btnsTxt!.length, true);
    }
  }

  Widget getQuickButtons() {
    if (!widget.isEdit) {
      return const SizedBox.shrink();
    }

    if (widget.btns != null) {
      return widget.btns!;
    } else if (widget.btnsTxt != null) {
      if (widget.isBtnsScroll!) {
        return ListView(
          scrollDirection: Axis.horizontal,
          children: getBtnsByText(),
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: getBtnsByText(),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  List<Widget> getBtnsByText() {
    List<Widget> result = <Widget>[];

    for (int index = 0; index < widget.btnsTxt!.length; ++index) {
      String? str = widget.btnsTxt![index];
      result.add(Container(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(getButtonColor(index)),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            padding: MaterialStateProperty.all(EdgeInsets.all(10)),
          ),
          child: Text(
            str,
            style: TextStyle(
              color: getBtnTextColor(index),
              fontSize: BrnFonts.f12,
            ),
          ),
          onPressed: () {
            if (!widget.isEdit ||
                (widget.enableBtnList != null &&
                    !widget.enableBtnList![index])) {
              return;
            }
            if (widget.onBtnSelectChanged != null) {
              widget.onBtnSelectChanged!(index);
            }
            if (_useInnerStatus) {
              // 如果是内部维护的状态，需要改变按钮的状态
              widget.selectBtnList![index] =
                  widget.selectBtnList![index] ? false : true;
            }
            setState(() {});
            /*
            List<bool> previewSelectedBtnIndex = List<bool>();
            for (int pos = 0; pos < widget.selectBtnList.length; ++pos) {
              previewSelectedBtnIndex.add(widget.selectBtnList[pos]);
            }

            widget.selectBtnList[index] = widget.selectBtnList[index] ? false : true;
            setState(() {});

            if (widget.onBtnSelectChanged != null) {
              widget.onBtnSelectChanged(previewSelectedBtnIndex, widget.selectBtnList);
            }
            */
          },
        ),
      ));
    }

    return result;
  }

  Color getButtonColor(int index) {
    if (widget.btnsTxt != null && widget.btnsTxt!.isEmpty) {
      return Color(0xFFF8F8F8);
    }

    /// 这个按钮不可点击
    if (widget.enableBtnList != null &&
        index < widget.enableBtnList!.length &&
        !widget.enableBtnList![index]) {
      return Color(0xFFF8F8F8);
    }

    if (widget.selectBtnList != null &&
        index < widget.selectBtnList!.length &&
        widget.selectBtnList![index]) {
      return Color(0x1F0984F9);
    } else {
      return Color(0xFFF8F8F8);
    }
  }

  Color getBtnTextColor(int index) {
    if (widget.btnsTxt != null && widget.btnsTxt!.isEmpty) {
      return Color(0xFF222222);
    }

    /// 这个按钮不可点击
    if (widget.enableBtnList != null &&
        index < widget.enableBtnList!.length &&
        !widget.enableBtnList![index]) {
      return Color(0xFF999999);
    }

    if (widget.selectBtnList == null ||
        widget.selectBtnList!.length != widget.btnsTxt!.length) {
      return Color(0xFF222222);
    }

    if (widget.selectBtnList != null &&
        index < widget.selectBtnList!.length &&
        widget.selectBtnList![index]) {
      return Color(0xFF0984F9);
    } else {
      return Color(0xFF222222);
    }
  }
}
