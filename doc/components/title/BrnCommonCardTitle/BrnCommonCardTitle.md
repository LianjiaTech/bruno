---
title: BrnCommonCardTitle
group:
  title: CardTitle
  order: 8
---

# BrnCommonCardTitle

普通卡片标题主要用于卡片标题或者在 ListView 中的一行

## 一、效果总览

<img src="./img/BrnCommonCardTitleIntro.png"  />

## 二、描述

### 适用场景

卡片标题或者在 ListView 中的一行

## 三、构造函数及参数说明

### 构造函数

```dart
BrnCommonCardTitle(
    {Key? key,
    required this.title,
    this.accessoryText,
    this.accessoryWidget,
    this.onTap,
    this.subTitleWidget,
    this.detailTextString,
    this.detailColor,
    this.alignment,
    this.padding,
    this.titleMaxLines,
    this.titleOverflow = TextOverflow.clip,
    this.themeData})
    : super(key: key);
```

### 参数说明

| **参数名**       | **参数类型**          | **描述**                                                     | **是否必填** | **默认值**        |
| ---------------- | --------------------- | ------------------------------------------------------------ | ------------ | ----------------- |
| title            | String                | 标题文本                                                     | 是           |                   |
| subTitleWidget   | Widget?               | 标题右侧的显示 widget                                        | 否           |                   |
| accessoryText    | String?               | 最右侧的文字                                                 | 否           |                   |
| accessoryWidget  | Widget?               | 最右侧的 widget                                              | 否           |                   |
| onTap            | VoidCallback?         | 整个标题点击的事件                                           | 否           |                   |
| detailTextString | String?               | 标题下面的文字                                               | 否           |                   |
| detailColor      | Color?                | 标题下方文字颜色                                             | 否           | Color(0xFF222222) |
| alignment        | PlaceholderAlignment? | title 的流式文本的对齐方式                                   | 否           |                   |
| padding          | EdgeInsetsGeometry?   | 内容的间距                                                   | 否           |                   |
| titleMaxLines    | int?                  | 标题最大行数                                                 | 否           | 无                |
| titleOverflow    | TextOverflow          | 标题 Overflow 展示方式，<br>注意，由于 subTitleWidget 与 title 是流式布局，所以 subTitleWidget 会折叠 | 否           | TextOverflow.clip |
| themeData        | BrnCardTitleConfig?   | 标题配置，详情见 BrnCardTitleConfig                          | 否           |                   |

## 四、代码演示

### 效果 1：带评分和标签

<img src="./img/BrnCommonCardTitleDemo1.png" style="zoom:50%;" />

```dart
BrnCommonCardTitle(
  title: '标题',
  accessoryText: '辅助文本',
  onTap: () {
    BrnToast.show('BrnCommonCardTitle is clicked', context);
  },
)
```

### 效果 2：带评分、标签和副标题

<img src="./img/BrnCommonCardTitleDemo2.png" style="zoom:50%;" />

```dart
BrnCommonCardTitle(
  title: '非箭头Title',
  accessoryWidget: BrnStateTag(tagText: '状态标签'),
  subTitleWidget: BrnRatingStar(
    count: 2,
    selectedCount: 2,
  ),
  onTap: () {
    BrnToast.show('BrnCommonCardTitle is clicked', context);
  },
),
```

### 效果 3：标题和副文本

<img src="./img/BrnCommonCardTitleDemo3.png" style="zoom:50%;" />

```dart
BrnCommonCardTitle(
  title: '非箭头Title',
  subTitleWidget: BrnRatingStar(
    count: 2,
    selectedCount: 2,
  ),
  accessoryWidget: BrnStateTag(tagText: '状态标签'),
  detailTextString: '副标题副标题副标题',
  onTap: () {
    BrnToast.show('BrnCommonCardTitle is clicked', context);
  },
)
```
