---
title: BrnInsertInfo
group:
  title: Bubble 气泡
  order: 7
---

# BrnInsertInfo

该元件的背景是不规则的边框，常用于卡片的下方作为备注信息。

## 一、效果总览

<img src="./img/insert_info.png" style="zoom:50%;" />

## 二、描述

### 适用场景

该元件的背景是不规则的边框，常用于卡片的下方作为备注信息

## 三、构造函数及参数说明

### 构造函数

```dart
BrnInsertInfo({Key key, @required this.infoText, this.maxLines = 2}) : super(key: key);
```

### 参数说明

| **参数名** | **参数类型** | **描述**                                   | **是否必填** | **默认值** |
| ---------- | ------------ | ------------------------------------------ | ------------ | ---------- |
| text       | String       | 显示的文本                                 | 是           |            |
| maxLines   | int          | 最多显示的行数，如果实际的行数超标，就折断 | 否           | 2          |

## 四、代码演示

### 效果 1

<img src="./img/insert_info.png" style="zoom:50%;" />

```dart
BrnInsertInfo(
  maxLines: 2,
  infoText: '推荐理由：“满五唯一”“临近地铁”“首付低”，多出折行显示，最多两行。推荐理由：“满五唯一”“临近地铁”“首付低”，多出折行显示，最多两行。')
```
