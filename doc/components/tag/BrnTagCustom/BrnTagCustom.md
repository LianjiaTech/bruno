---
title: BrnTagCustom
group:
  title: Tag
  order: 33
---

# BrnTagCustom

## 一、效果总览

![](./img/BrnTagCustomDemo2.png)&nbsp;&nbsp;
<img src="./img/BrnTagCustomDemo1.png" style="zoom:67%;" />&nbsp;&nbsp;
<img src="./img/BrnTagCustomDemo3.png" style="zoom:50%;" />

## 二、描述

### 适用场景

1、自定义标签，业务方可以自定义字体大小，颜色，背景色等属性

## 三、构造函数及参数说明

### 构造函数

```dart
BrnTagCustom({
  Key? key,
  required this.tagText,
  this.textColor,
  this.backgroundColor,
  this.tagBorderRadius = const BorderRadius.all(Radius.circular(2)),
  this.textPadding =
      const EdgeInsets.only(bottom: 0.5, left: 3, right: 3, top: 0),
  this.border,
  this.fontSize = 11,
  this.fontWeight = FontWeight.normal,
  this.maxWidth = double.infinity,
}) : super(key: key);
```

### 参数说明

| **参数名**      | **参数类型** | **描述**           | **是否必填** | **默认值**                         |
| --------------- | ------------ | ------------------ | ------------ | ---------------------------------- |
| tagText         | String       | 标签显示文本       | 是           |                                    |
| backgroundColor | Color?       | 标签背景色         | 否           | 主题色                             |
| textColor       | Color?       | 文本颜色           | 否           | F4Color                            |
| tagBorderRadius | BorderRadius | 标签圆角           | 否           | 圆角为 2                           |
| textPadding     | EdgetInsets  | 标签文字的 padding | 否           | EdgeInsets.symmetric(horizontal:2) |
| fontSize        | double       | 标签文字的大小     | 否           | 11                                 |
| fontWeight      | FontWeight   | 文字的粗细         | 否           | FontWeight.normal                  |
| maxWidth        | Double       | 标签高度           | 否           | double.infinity                    |
| border          | Border?      | 标签边框           | 否           | 无                                 |

## 四、代码演示

### 效果 1

![](./img/BrnTagCustomDemo1.png)

```dart
BrnTagCustom(
    tagText: "自定义",
)
```

### 效果 2

![](./img/BrnTagCustomDemo2.png)

```dart
BrnTagCustom(
  tagText: '自定义标签',
  backgroundColor: Colors.green,
  tagBorderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
)
```

### 效果 3

<img src="./img/BrnTagCustomDemo3.png" style="zoom:67%;" />

```dart
BrnTagCustom.buildBorderTag(
  tagText: '认证通过',
  textColor: Colors.red,
  borderColor: Colors.red,
  borderWidth: 2,
  fontSize: 24,
  textPadding: EdgeInsets.all(6),
)
```
