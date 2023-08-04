import 'package:bindings_compatible/bindings_compatible.dart';
import 'package:bruno/bruno.dart';
import 'package:bruno/src/components/navbar/brn_appbar_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 左侧leading的点击回调，
/// textEditingController 是搜索框的控制器，暴漏给使用者去处理 是否情况等操作
/// updateTextEdit 是暴漏给使用者的更新方法，该方法在组件的实现setState。
/// 比如想要刷新搜索框 就可以直接调用updateTextEdit()
typedef BrnSearchBarLeadClickCallback = Function(
    TextEditingController textEditingController, VoidCallback updateTextEdit);

/// 右侧取消的点击回调，
/// textEditingController 是搜索框的控制器，暴漏给使用者去处理 是否情况等操作
/// updateTextEdit 是暴漏给使用者的更新方法，该方法在组件的实现setState。
/// 比如想要刷新搜索框 就可以直接调用updateTextEdit()
typedef BrnSearchBarDismissClickCallback = Function(
    TextEditingController textEditingController, VoidCallback updateTextEdit);

/// 输入框输入变化的监听
typedef BrnSearchBarInputChangeCallback = Function(String input);

/// 输入框提交的监听
typedef BrnSearchBarInputSubmitCallback = Function(String input);

/// 用于搜索的AppBar
/// 该组件是[BrnAppBar]的特例包装，
/// 实现的思路是：将[BrnAppBar.title]设置为textField
/// 更多信息 请查看[BrnAppBar]
//ignore: must_be_immutable
class BrnSearchAppbar extends PreferredSize {
  /// 搜索框的文本输入控制器
  final TextEditingController? controller;

  /// 搜索框的焦点控制器
  final FocusNode? focusNode;

  /// 搜索框的左侧leading
  final BrnSearchBarLeadClickCallback? leadClickCallback;

  /// 可以是字符串也可以是widget
  final dynamic leading;

  /// 取消点击的回调
  final BrnSearchBarDismissClickCallback? dismissClickCallback;

  /// 输入变化的监听
  final BrnSearchBarInputChangeCallback? searchBarInputChangeCallback;

  /// 输入框提交的监听
  final BrnSearchBarInputSubmitCallback? searchBarInputSubmitCallback;

  /// 输入框的hint文字
  final String? hint;

  /// 输入框的hint的Style
  final TextStyle? hintStyle;

  /// 输入框的文本Style
  final TextStyle? inputTextStyle;

  /// 右侧取消的文本Style
  final TextStyle? dismissStyle;

  /// 左侧的leading和搜索的分割线
  final bool showDivider;

  /// 是否默认获取焦点
  final bool autoFocus;

  /// 清空回调
  final VoidCallback? onClearTap;

  final SystemUiOverlayStyle? systemOverlayStyle;

  BrnAppBarConfig? themeData;

  BrnSearchAppbar(
      {this.controller,
      this.focusNode,
      this.leading,
      this.leadClickCallback,
      this.dismissClickCallback,
      this.searchBarInputChangeCallback,
      this.searchBarInputSubmitCallback,
      this.hint,
      this.hintStyle,
      this.dismissStyle,
      this.showDivider = true,
      this.autoFocus = true,
      this.onClearTap,
      this.systemOverlayStyle,
      this.inputTextStyle,
      this.themeData})
      : super(child: const Center(), preferredSize: const Size(0, 0)){
    this.themeData ??= BrnAppBarConfig.dark();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .appBarConfig
        .merge(this.themeData)
        .merge(BrnAppBarConfig(systemUiOverlayStyle: systemOverlayStyle));
  }

  @override
  Widget get child => BrnAppBar(
        systemOverlayStyle: systemOverlayStyle,
        automaticallyImplyLeading: false,
        themeData: themeData,
        title: _createSearchChild(themeData!),
      );

  @override
  Size get preferredSize => Size.fromHeight(BrnAppBarTheme.appBarHeight);

  Widget build(BuildContext context) {
    useWidgetsBinding().addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });
    return super.build(context);
  }

  Widget _createSearchChild(BrnAppBarConfig themeData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: _SearchInputWidget(
          autoFocus: autoFocus,
          textEditingController: controller,
          leading: leading,
          focusNode: focusNode,
          leadClickCallback: leadClickCallback,
          dismissClickCallback: dismissClickCallback,
          searchBarInputSubmitCallback: searchBarInputSubmitCallback,
          searchBarInputChangeCallback: searchBarInputChangeCallback,
          hint: hint,
          hintStyle: hintStyle,
          inputTextStyle: inputTextStyle,
          dismissStyle: dismissStyle,
          showDivider: showDivider,
          clearTapCallback: onClearTap,
              themeData: themeData,
        )),
      ],
    );
  }
}
//ignore: must_be_immutable
class _SearchInputWidget extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final BrnSearchBarLeadClickCallback? leadClickCallback;
  final BrnSearchBarDismissClickCallback? dismissClickCallback;
  final dynamic leading;
  final BrnSearchBarInputChangeCallback? searchBarInputChangeCallback;
  final BrnSearchBarInputSubmitCallback? searchBarInputSubmitCallback;
  final String? hint;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;
  final TextStyle? dismissStyle;
  final bool showDivider;
  final bool autoFocus;
  final VoidCallback? clearTapCallback;

  BrnAppBarConfig? themeData;

  _SearchInputWidget(
      {this.focusNode,
      this.leading,
      this.leadClickCallback,
      this.dismissClickCallback,
      this.textEditingController,
      this.searchBarInputChangeCallback,
      this.searchBarInputSubmitCallback,
      this.hint,
      this.hintStyle,
      this.inputTextStyle,
      this.showDivider = true,
      this.autoFocus = true,
      this.dismissStyle,
      this.clearTapCallback,
      this.themeData});

  @override
  __SearchInputWidgetState createState() => __SearchInputWidgetState();
}

class __SearchInputWidgetState extends State<_SearchInputWidget> {
  late FocusNode _focusNode;
  late ValueNotifier<bool> valueNotifier;
  late TextEditingController _controller;
  late Color _defaultInputTextColor;
  late Color _defaultCancelTextColor;
  late Color _defaultDividerColor;
  late Color _defaultHintTextColor;
  late Color _defaultClearIconColor;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.textEditingController ?? TextEditingController();

    valueNotifier = ValueNotifier(false);
    _focusNode.addListener(_handleFocusChangeListenerTick);
    if (widget.themeData?.systemOverlayStyle.statusBarBrightness == Brightness.dark) {
      _defaultDividerColor = Colors.white.withOpacity(0.2);
      _defaultHintTextColor = Colors.white.withOpacity(0.4);
      _defaultInputTextColor = Colors.white;
      _defaultCancelTextColor = Colors.white;
      _defaultClearIconColor = Colors.white.withOpacity(0.4);
    } else {
      _defaultDividerColor = BrnThemeConfigurator.instance
          .getConfig()
          .commonConfig
          .dividerColorBase;
      _defaultHintTextColor =
          BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextHint;
      _defaultInputTextColor = BrnThemeConfigurator.instance
          .getConfig()
          .commonConfig
          .colorTextSecondary;
      _defaultCancelTextColor =
          BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase;
      _defaultClearIconColor =
          BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextHint;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_handleFocusChangeListenerTick);
  }

  void _handleFocusChangeListenerTick() {
    if (_focusNode.hasFocus) {
      valueNotifier.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (widget.leadClickCallback != null) {
              widget.leadClickCallback!(_controller, () {
                setState(() {});
              });
            }
          },
          child: _createLeading(),
        ),
        Visibility(
          visible: widget.showDivider,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              height: 16,
              width: 1,
              color: _defaultDividerColor,
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child:
                    BrunoTools.getAssetSizeImage(BrnAsset.iconSearch, 16, 16),
              ),
              Expanded(
                child: TextField(
                    autofocus: widget.autoFocus,
                    focusNode: _focusNode,
                    // 控制器属性，控制正在编辑的文本。
                    controller: _controller,
                    // 光标颜色属性，绘制光标时使用的颜色。
                    cursorColor: BrnThemeConfigurator.instance
                        .getConfig()
                        .commonConfig
                        .brandPrimary,
                    // 光标宽度属性，光标的厚度，默认是2.0。
                    cursorWidth: 2.0,
                    // 样式属性，用于正在编辑的文本的样式。
                    style: widget.inputTextStyle ??
                        TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            color: _defaultInputTextColor,
                            fontSize: 16),
                    // 装饰（`decoration`）属性，在文本字段周围显示的装饰。
                    decoration: InputDecoration(
                      // 边框属性，装饰的容器周围绘制的形状。
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(right: 6),
                      // 填充颜色属性，填充装饰容器的颜色。
                      fillColor: Colors.transparent,
                      // 是密集属性，输入子项是否是密集形式的一部分（即使用较少的垂直空间）。
                      isDense: true,
                      // 填充属性，如果为`true`，则装饰的容器将填充fillColor颜色。
                      filled: true,
                      // 提示样式属性，用于提示文本（`hintText`）的样式。
                      hintStyle: widget.hintStyle ??
                          TextStyle(
                            fontSize: 16,
                            height: 1,
                            textBaseline: TextBaseline.alphabetic,
                            color: _defaultHintTextColor,
                          ),
                      // 提示文本属性，提示字段接受哪种输入的文本。
                      hintText: widget.hint ??
                          BrnIntl.of(context).localizedResource.inputSearchTip,
                    ),
                    // 在改变属性，当正在编辑的文本发生更改时调用。
                    onChanged: (content) {
                      valueNotifier.value = true;
                      if (widget.searchBarInputChangeCallback != null) {
                        widget.searchBarInputChangeCallback!(content);
                      }
                      setState(() {});
                    },
                    onSubmitted: (content) {
                      valueNotifier.value = false;
                      if (widget.searchBarInputSubmitCallback != null) {
                        widget.searchBarInputSubmitCallback!(content);
                      }
                    }),
              ),
              GestureDetector(
                onTap: () {
                  _controller.clear();
                  if (widget.clearTapCallback != null) {
                    widget.clearTapCallback!();
                  }
                  setState(() {});
                },
                child: Visibility(
                  visible: _controller.text.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: valueNotifier.value ? 24 : 20,
                        left: valueNotifier.value ? 24 : 20),
                    child: Image.asset(
                      'assets/${BrnAsset.iconDeleteText}',
                      color: _defaultClearIconColor,
                      scale: 3.0,
                      height: 16,
                      package: BrnStrings.flutterPackageName,
                      width: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, bool value, child) {
            return value
                ? GestureDetector(
                    onTap: () {
                      if (widget.dismissClickCallback != null) {
                        widget.dismissClickCallback!(_controller, () {
                          setState(() {});
                        });
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          BrnIntl.of(context).localizedResource.cancel,
                          style: widget.dismissStyle ??
                              TextStyle(
                                  color: _defaultCancelTextColor,
                                  fontSize: 16,
                                  height: 1,
                                  fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _createLeading() {
    if (widget.leading is String) {
      return Padding(
        padding: EdgeInsets.only(right: 16),
        child: Text(
          widget.leading,
          style: TextStyle(color: Colors.white, height: 1, fontSize: 16),
        ),
      );
    }

    if (widget.leading is Widget) {
      return widget.leading;
    }

    return const SizedBox.shrink();
  }
}
