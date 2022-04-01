---
title: BrnSwitchTitle
group:
  title: TabBar
  order: 32
---

# BrnSwitchTitle

多个标题切换控件。

## 一、效果总览

<img src="./img/BrnSwitchTitleDemo1.png" style="zoom:50%;" />

## 二、描述

### 适用场景

一级标题，支持多个标题，可以切换和滑动。

### 交互规则

1. 如果标题较短，会居左显示，较长可以左右滑动展示。
2. 标题选中时的颜色，默认是主题色，`BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary`。
3. 标题只有一个时，不展示底部的下划线，多于一个时自动展示。

## 三、构造函数及参数说明

### 构造函数

```dart
const BrnSwitchTitle(
    {Key? key,
    required this.nameList,
    this.defaultSelectIndex = 0,
    this.onSelect,
    this.indicatorWeight = 2.0,
    this.indicatorWidth = 24.0,
    this.padding = const EdgeInsets.fromLTRB(0, 14, 20, 14),
    this.controller,
    this.selectedTextStyle,
    this.unselectedTextStyle})
    : super(key: key);
```
### 参数说明

| **参数名** | **参数类型** | **描述** | **是否必填** | **默认值** |
| --- | --- | --- | --- | --- |
| nameList | `List<String>` | 标题的文案列表 | 是 | 无 |
| defaultSelectIndex | int | 默认选中的 index | 否 | 0 |
| onSelect | `void Function(int index)?` | 标题选中时的回调 | 否 | 无 |
| controller | TabController? | 控制tab切换，默认不需要传递 | 否 | 无 |
| padding | EdgeInsets | 标题的 padding | 否 | 默认 `EdgeInsets.fromLTRB(0, 14, 20, 14)` |
| indicatorWeight | double | 下划线的高度 | 否 | 默认是 2 |
| indicatorWidth | double | 下划线的宽度。indicatorWidth 要大于等于 indicatorWeight。 | 否 | 默认是 24 |
| selectedTextStyle | TextStyle? | 标题选中时的样式 | 否 | `TextStyle(fontWeight: FontWeight.w600,fontSize: 18)` |
| unselectedTextStyle | TextStyle? | 标题未选中时的样式 | 否 | `TextStyle(fontWeight: FontWeight.w600,fontSize: 18)` |

## 四、代码演示

### 效果1：基本样式

<img src="./img/BrnSwitchTitleDemo1.png" style="zoom:50%;" />

```dart
BrnSwitchTitle(  
  nameList: ['标题内容1', '标题内容2', '标题内容3'],  
  defaultSelectIndex: 0,  
  onSelect: (value) {  
    BrnToast.show(value.toString(), context);  
  },  
)
```

### 效果2：外部控制 tab

![](./img/BrnSwitchTitleDemo2.gif)
```dart
TabController _controller = TabController(
  initialIndex: 1,
  length: 3,
  vsync: this,
);

Column(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    BrnSwitchTitle(
      nameList: ['标题内容1', '标题内容2', '标题内容3'],
      defaultSelectIndex: 0,
      controller: _controller,
      onSelect: (value) {
        BrnToast.show(value.toString(), context);
      },
    ),
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: BrnSmallOutlineButton(
        title: '点击选中第二个',
        onTap: () {
          _controller.index = 1;
        },
      ),
    ),
  ]
)
```
