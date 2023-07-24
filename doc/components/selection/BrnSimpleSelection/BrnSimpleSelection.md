---
title: BrnSimpleSelection
group:
  title: Selection
  order: 28
---

# BrnSimpleSelection

区间+输入混合一级筛选

## 一、效果总览

![](./img/simple_selection_radio.png)
![](./img/simple_selection_checkbox.png)



## 二、描述

### 适用场景

简单筛选列表，包含单选和多选两种示例，适合简单的业务场景。

## 三、构造函数及参数说明

### 构造函数

#### 单选


```dart
BrnSimpleSelection.radio({
  Key? key,
  required this.menuName,
  this.menuKey = _defaultMenuKey,
  this.defaultValue,
  required this.items,
  required this.onSimpleSelectionChanged,
  this.onMenuItemClick,
  this.themeData,
})  : this.isRadio = true,
      this.maxSelectedCount = BrnSelectionConstant.maxSelectCount,
      super(key: key);
```

#### 多选

```dart
BrnSimpleSelection.checkbox({
  Key? key,
  required this.menuName,
  this.menuKey = _defaultMenuKey,
  this.defaultValue,
  this.maxSelectedCount = BrnSelectionConstant.maxSelectCount,
  required this.items,
  required this.onSimpleSelectionChanged,
  this.onMenuItemClick,
  this.themeData,
})  : this.isRadio = false,
      super(key: key);
```



### 参数说明

| **参数名** | **参数类型** | **描述** | **是否必填** | **默认值** |
| --- | --- | --- | --- | --- |
| menuName | String | 标题文案 | 是 | 无 |
| menuKey | String | 回传给服务端Key | 是 | `'defaultMenuKey'` |
| defaultValue | String? | 默认选中项值 | 否 | 无 |
| maxSelectedCount | int | 最大选中个数 | 否 | radio模式 默认65535  checkbox模式不设置 |
| items | `List<ItemEntity>` | 选项列表 | 是 |  |
| onSimpleSelectionChanged | BrnSimpleSelectionOnSelectionChanged | 选择回调 | 是 |  |
| onMenuItemClick | VoidCallback? | 菜单点击事件 | 否 | |
| isRadio | bool | 是否单选  默认 radio模式 is true ， checkbox模式 is false | 否 | radio模式默认true checkbox模式默认false |
| themeData | BrnSelectionConfig |筛选项配置类|否||

## 四、代码演示

### 效果1

![](./img/simple_selection_radio.png)
```dart
BrnSimpleSelection.radio(
  menuName: widget._filterData.name,
  menuKey: widget._filterData.key ?? defaultMenuKey,
  items: widget._filterData.children,
  defaultValue: widget._filterData.defaultValue,
  onSimpleSelectionChanged: (
      List<ItemEntity> filterParams) {
    BrnToast.show(filterParams.map((e) => e.value).toList().join(','), context);
  },
)
```
```dart
"list": [
  {
    "title": "单列",
    "key": "one_list_key",
    "type": "radio",
    "defaultValue": "",
    "value": "",
    "children": [
      {
        "title": "不限",
        "key": "",
        "type": "unlimit",
        "defaultValue": "",
        "value": ""
      },
      {
        "title": "选项一",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "1"
      },
      {
        "title": "选项二",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "2"
      },
      {
        "title": "选项三",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "3"
      },
      {
        "title": "选项四",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "4"
      },
      {
        "title": "选项五",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "5"
      },
      {
        "title": "选项六",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "6"
      },
      {
        "title": "选项七",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "7"
      },
      {
        "title": "选项八",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "8"
      }
    ]
  }
]
```



### 效果2

![](./img/simple_selection_checkbox.png)
```dart
BrnSimpleSelection.checkbox(
  menuName: widget._filterData.name,
  menuKey: widget._filterData.key ?? defaultMenuKey,
  items: widget._filterData.children,
  maxSelectedCount: 4,
  defaultValue: widget._filterData.defaultValue,
  onSimpleSelectionChanged: (
      List<ItemEntity> filterParams) {
    BrnToast.show(filterParams.map((e) => e.value).toList().join(','), context);
  },
)
```

```dart
"list": [
  {
    "title": "单列",
    "key": "one_list_key",
    "type": "radio",
    "defaultValue": "",
    "value": "",
    "children": [
      {
        "title": "不限",
        "key": "",
        "type": "unlimit",
        "defaultValue": "",
        "value": ""
      },
      {
        "title": "选项一",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "1"
      },
      {
        "title": "选项二",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "2"
      },
      {
        "title": "选项三",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "3"
      },
      {
        "title": "选项四",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "4"
      },
      {
        "title": "选项五",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "5"
      },
      {
        "title": "选项六",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "6"
      },
      {
        "title": "选项七",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "7"
      },
      {
        "title": "选项八",
        "key": "",
        "type": "radio",
        "defaultValue": "",
        "value": "8"
      }
    ]
  }
]
```

