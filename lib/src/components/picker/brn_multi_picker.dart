import 'package:bruno/src/components/picker/base/brn_picker.dart';
import 'package:bruno/src/components/picker/base/brn_picker_title.dart';
import 'package:bruno/src/components/picker/base/brn_picker_title_config.dart';
import 'package:bruno/src/components/picker/brn_picker_cliprrect.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';

import 'base/brn_picker_constants.dart';

/// 可以自定义实现 item Widget样式，更灵活
/// [isSelect] 是否被选中
/// [column] 第几列
/// [row] 第几行
/// [selectedItems] 当前被选中的数据列表
typedef BrnMultiDataPickerCreateWidgetCallback = Widget Function(
    bool isSelect, int column, int row, List selectedItems);

/// 创建一级数据widget列表
typedef CreateWidgetList = List<Widget> Function();

/// 确定筛选内容事件回调
typedef ConfirmButtonClick = void Function(List selectedIndexList);

/// 数据适配 Delegate
abstract class BrnMultiDataPickerDelegate {
  /// 定义显示几列内容
  int numberOfComponent();

  /// 定义每一列所显示的行数， component 代表列的索引，
  int numberOfRowsInComponent(int component);

  /// 定义某列某行所显示的内容，component 代表列的索引，index 代表 第component列中的第 index 个元素
  String titleForRowInComponent(int component, int index);

  /// 定义每列内容的高度
  double? rowHeightForComponent(int component);

  /// 定义选择更改后的操作
  void selectRowInComponent(int component, int row);

  /// 定义初始选中的行数
  int initSelectedRowForComponent(int component);
}

/// 多级数据选择弹窗
// ignore: must_be_immutable
class BrnMultiDataPicker extends StatefulWidget {
  /// 多级数据选择弹窗标题
  final String title;

  ///多级数据选择标题文案样式
  final TextStyle? titleTextStyle;

  /// 多级数据选择弹窗所要覆盖页面的context
  final BuildContext context;

  /// 多级数据选择弹窗的数据来源，自定义delegate继承该类，实现具体方法即可自定义每一列、每一行的具体内容
  final BrnMultiDataPickerDelegate delegate;

  ///多级数据选择确认文案样式
  final TextStyle? confirmTextStyle;

  ///多级数据选择取消文案样式
  final TextStyle? cancelTextStyle;

  /// 多级数据选择每一级的默认标题
  final List<String>? pickerTitles;

  /// 多级数据选择每一级默认标题的字体大小
  final double? pickerTitleFontSize;

  /// 多级数据选择每一级默认标题的文案颜色
  final Color? pickerTitleColor;

  /// 多级数据选择数据字体大小
  final double? textFontSize;

  /// 多级数据选择数据文案颜色
  final Color? textColor;

  /// 多级数据选择数据选中文案颜色
  final Color? textSelectedColor;

  /// 多级数据选择数据widget容器
  final List<FixedExtentScrollController> controllers = [];

  /// 多级数据选择确认点击回调
  final ConfirmButtonClick? confirmClick;

  /// 选择轮盘的滚动行为
  final ScrollBehavior? behavior;

  /// 返回自定义 itemWidget 的回调
  final BrnMultiDataPickerCreateWidgetCallback? createItemWidget;

  /// 是否复位数据位置。默认 true
  final bool sync;

  BrnPickerConfig? themeData;

  BrnMultiDataPicker(
      {Key? key,
      required this.context,
      required this.delegate,
      this.title = "",
      this.titleTextStyle,
      this.confirmTextStyle,
      this.cancelTextStyle,
      this.pickerTitles,
      this.pickerTitleFontSize,
      this.pickerTitleColor,
      this.textFontSize,
      this.textColor,
      this.textSelectedColor,
      this.behavior,
      this.confirmClick,
      this.createItemWidget,
      this.themeData,
      this.sync = true}) {
    this.themeData ??= BrnPickerConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .pickerConfig
        .merge(this.themeData);
    this.themeData = this.themeData!.merge(BrnPickerConfig(
      cancelTextStyle: BrnTextStyle.withStyle(cancelTextStyle),
      confirmTextStyle: BrnTextStyle.withStyle(confirmTextStyle),
      titleTextStyle: BrnTextStyle.withStyle(titleTextStyle),
      itemTextStyle: BrnTextStyle(color: textColor, fontSize: textFontSize),
      itemTextSelectedStyle:
      BrnTextStyle(color: textSelectedColor, fontSize: textFontSize),
    ));
  }

  @override
  _BrnMultiDataPickerState createState() => _BrnMultiDataPickerState();

  void show({bool isDismissible = true}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isDismissible: isDismissible,
        builder: (BuildContext context) {
          return GestureDetector(
            child: this,
            onVerticalDragUpdate: (v) => false,
          );
        }).then((value) {});
  }
}

class _BrnMultiDataPickerState extends State<BrnMultiDataPicker> {
  List _selectedIndexList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.delegate.numberOfComponent(); i++) {
      _selectedIndexList.add(widget.delegate.initSelectedRowForComponent(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.themeData!.pickerHeight + widget.themeData!.titleHeight,
      child: Material(
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BrnPickerClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.themeData!.cornerRadius),
                topRight: Radius.circular(widget.themeData!.cornerRadius),
              ),
              child: _configHeaderWidget(),
            ),
            _configMultiDataPickerWidget()
          ],
        ),
      ),
    );
  }

  //头部widget
  Widget _configHeaderWidget() {
    return BrnPickerTitle(
      themeData: widget.themeData,
      pickerTitleConfig: BrnPickerTitleConfig(
        titleContent: widget.title,
      ),
      onCancel: () {
        Navigator.of(context).pop();
      },
      onConfirm: () {
        Navigator.of(context).pop(_selectedIndexList);
        if (widget.confirmClick != null) {
          widget.confirmClick!(_selectedIndexList);
        }
      },
    );
  }

  //选择的内容widget
  Widget _configMultiDataPickerWidget() {
    return Container(
        height: widget.themeData?.pickerHeight ?? pickerHeight,
        color: widget.themeData?.backgroundColor,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            children: widget.pickerTitles != null ? _pickersWithTitle() : _pickers()));
  }

  List<Widget> _pickersWithTitle() {
    List<Widget> pickersWithTitle = [];
    for (int i = 0; i < widget.delegate.numberOfComponent(); i++) {
      int initRow = widget.delegate.initSelectedRowForComponent(i);
      FixedExtentScrollController controller = FixedExtentScrollController(initialItem: initRow);
      widget.controllers.add(controller);
      if (i >= _selectedIndexList.length) _selectedIndexList.add(0);
      Widget picker = _configSinglePicker(i);
      pickersWithTitle.add(Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    widget.pickerTitles == null ? '' : widget.pickerTitles![i],
                    style: TextStyle(
                        fontSize: widget.pickerTitleFontSize, color: widget.pickerTitleColor),
                  ),
                ),
              ),
              Expanded(flex: 4, child: picker)
            ],
          )));
    }
    return pickersWithTitle;
  }

  //picker数据
  List<Widget> _pickers() {
    List<Widget> pickers = [];
    for (int i = 0; i < widget.delegate.numberOfComponent(); i++) {
      int initRow = widget.delegate.initSelectedRowForComponent(i);
      FixedExtentScrollController controller = FixedExtentScrollController(initialItem: initRow);
      widget.controllers.add(controller);
      if (i >= _selectedIndexList.length) _selectedIndexList.add(0);
      Widget picker = _configSinglePicker(i);
      pickers.add(Expanded(flex: 1, child: picker));
    }
    return pickers;
  }

  //构建单列数据
  Widget _configSinglePicker(int component) {
    return MyPicker(
      backgroundColor: widget.themeData!.backgroundColor,
      lineColor: widget.themeData!.dividerColor,
      controller: widget.controllers[component],
      key: Key(component.toString()),
      createWidgetList: () {
        if (widget.createItemWidget != null) {
          List<Widget> widgetList = [];
          for (int i = 0; i < widget.delegate.numberOfRowsInComponent(component); i++) {
            bool isSelect = _selectedIndexList[component] == i;
            widgetList.add(widget.createItemWidget != null
                ? widget.createItemWidget!(isSelect, component, i, _selectedIndexList)
                : Container());
          }
          return widgetList;
        } else {
          List<Widget> list = [];
          for (int i = 0; i < widget.delegate.numberOfRowsInComponent(component); i++) {
            list.add(Center(
              child: Text(
                widget.delegate.titleForRowInComponent(component, i),
                style: _selectedIndexList[component] == i
                    ? widget.themeData!.itemTextSelectedStyle.generateTextStyle()
                    : widget.themeData!.itemTextStyle.generateTextStyle(),
              ),
            ));
          }
          return list;
        }
      },
      itemExtent: widget.delegate.rowHeightForComponent(component) ?? widget.themeData!.itemHeight,
      changed: (int index) {
        widget.delegate.selectRowInComponent(component, index);
        _selectedIndexList[component] = index;
        setState(() {
          for (int i = component + 1; i < widget.delegate.numberOfComponent(); i++) {
            List list = [];
            for (int j = 0; j < widget.delegate.numberOfRowsInComponent(component); j++) {
              list.add(widget.delegate.titleForRowInComponent(component, index));
            }
            FixedExtentScrollController controller = widget.controllers[i];
            if (widget.sync) {
              controller.jumpTo(0);
              _selectedIndexList[i] = 0;
            }
          }
        });
      },
      scrollBehavior: widget.behavior,
    );
  }
}

/// 一级数据选择widget
class MyPicker extends StatefulWidget {
  ///创建数据widget列表
  final CreateWidgetList? createWidgetList;

  ///数据选择改变回调
  final ValueChanged<int>? changed;

  /// 数据显示高度
  final double itemExtent;

  /// 滚动行为
  final ScrollBehavior? scrollBehavior;

  final FixedExtentScrollController? controller;
  final Color backgroundColor;
  final Color? lineColor;

  MyPicker({
    Key? key,
    this.createWidgetList,
    this.changed,
    this.scrollBehavior,
    this.itemExtent = 45,
    this.controller,
    this.backgroundColor = Colors.white,
    this.lineColor,
  }) : super(key: key);

  @override
  State createState() {
    return _MyPickerState();
  }
}

class _MyPickerState extends State<MyPicker> {
  @override
  Widget build(BuildContext context) {
    var children = widget.createWidgetList!();
    return Container(
      child: ScrollConfiguration(
        behavior: widget.scrollBehavior ?? _DefaultScrollBehavior(),
        child: BrnPicker(
          key: widget.key,
          scrollController: widget.controller,
          itemExtent: widget.itemExtent,
          backgroundColor: widget.backgroundColor,
          lineColor: widget.lineColor,
          onSelectedItemChanged: (index) {
            if (widget.changed != null) {
              widget.changed!(index);
            }
          },
          children: children.isNotEmpty
              ? children
              : [
                  Center(child: Text('')),
                ],
        ),
      ),
    );
  }
}

///默认的选择轮盘滚动行为，Android去除默认的水波纹动画效果
class _DefaultScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

/// 实现了部分默认逻辑的 Delegate
class BrnDefaultMultiDataPickerDelegate implements BrnMultiDataPickerDelegate {
  ///数据源
  List<BrnMultiDataPickerEntity> data;

  ///第一列选中角标，默认0
  int firstSelectedIndex;

  ///第二列选中角标，默认0
  int secondSelectedIndex;

  ///第三列选中角标，默认0
  int thirdSelectedIndex;

  int _numberOfComponent = 0;

  BrnDefaultMultiDataPickerDelegate(
      {required this.data,
      this.firstSelectedIndex = 0,
      this.secondSelectedIndex = 0,
      this.thirdSelectedIndex = 0}) {
    if (data.isNotEmpty) {
      _numberOfComponent = 1;
      for (BrnMultiDataPickerEntity brnPickerItem in data) {
        if (brnPickerItem.children.isNotEmpty) {
          _numberOfComponent = 2;

          for (BrnMultiDataPickerEntity brnPickerItem1 in brnPickerItem.children) {
            if (brnPickerItem1.children.isNotEmpty) {
              _numberOfComponent = 3;
            }
          }
        }
      }
    }
  }

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return firstSelectedIndex;
    } else if (1 == component) {
      return secondSelectedIndex;
    } else {
      return thirdSelectedIndex;
    }
  }

  ///显示几列内容
  @override
  int numberOfComponent() {
    return _numberOfComponent;
  }

  @override
  int numberOfRowsInComponent(int component) {
    if (data.isEmpty) {
      return 0;
    }

    if (0 == component) {
      return data.length;
    } else if (1 == component) {
      List fl = data[firstSelectedIndex].children;
      return fl.length;
    } else {
      List<BrnMultiDataPickerEntity> secondMap = data[firstSelectedIndex].children;
      List thirdMap = secondMap[secondSelectedIndex].children;
      return thirdMap.length;
    }
  }

  @override
  double rowHeightForComponent(int component) {
    return pickerItemHeight;
  }

  @override
  void selectRowInComponent(int component, int row) {
    if (0 == component) {
      firstSelectedIndex = row;
    } else if (1 == component) {
      secondSelectedIndex = row;
    } else {
      thirdSelectedIndex = row;
    }
  }

  @override
  String titleForRowInComponent(int component, int index) {
    if (0 == component) {
      return data[index].text;
    } else if (1 == component) {
      BrnMultiDataPickerEntity brnPickerItem = data[firstSelectedIndex];
      List<BrnMultiDataPickerEntity> secondList = brnPickerItem.children;
      return secondList[index].text;
    } else {
      BrnMultiDataPickerEntity brnPickerItem = data[firstSelectedIndex];
      List<BrnMultiDataPickerEntity> secondList = brnPickerItem.children;
      List<BrnMultiDataPickerEntity> threeList = secondList[secondSelectedIndex].children;
      return threeList[index].text;
    }
  }
}

/// 适用于 BrnDefaultMultiDataPickerDelegate 的数据类
class BrnMultiDataPickerEntity {
  /// 显示内容
  final String text;

  /// 数据值
  final dynamic value;

  /// 子项
  final List<BrnMultiDataPickerEntity> children;

  BrnMultiDataPickerEntity({
    required this.text,
    this.value,
    this.children = const [],
  });
}
