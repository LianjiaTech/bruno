---
title: BrnExpandableText
group:
  title: Text
  order: 34
---

# BrnExpandableText

## 一、效果总览

<img src="./img/BrnExpandableTextIntro1.png" style="zoom:67%;" />
<br />
<img src="./img/BrnExpandableTextIntro2.png" style="zoom:67%;" />

## 二、描述

### 适用场景

1.当文案过长时，可以设置展开和收起

## 三、构造函数及参数说明

### 构造函数

```dart
const BrnExpandableText(
    {Key? key,
    required this.text,
    this.maxLines = 1000000,
    this.textStyle,
    this.onExpanded,
    this.color})
    : super(key: key);
```

### 参数说明

| **参数名** | **参数类型**           | **描述**         | **是否必填** | **默认值**      |
| ---------- | ---------------------- | ---------------- | ------------ | --------------- |
| text       | String                 | 待显示的文案     | 是           |                 |
| maxLines   | int?                   | 最大可展示的行数 | 否           | 1000000         |
| textStyle  | TextStyle?             | 文本显示的样式   | 否           | 14 号的 F0 字体 |
| onExpanded | `void Function(bool)?` | 展开收起的回调   | 否           | 无              |
| color      | Colors?                | 背景色           | 否           | 白色            |

## 四、代码演示

### 效果 1

<img src="./img/BrnExpandableTextIntro1.png" style="zoom:67%;" />

```dart
BrnExpandableText(
  text: '冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在；门店位于昌平区390号，'
                  '距离昌平线生命科学冠寓是龙湖地产的第三大主航道业务，专注做中高端租赁市场，标语是我家我自在标语是我家我自在。',
  maxLines: 2,
  onExpanded:(bool isExpanded) {
    if (isExpanded) {
      debugPrint('已经展开');
    }
    else {
      debugPrint('已经收起');
    }
  }
);
```
