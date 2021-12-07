---
title: BrnBubbleText
group:
  title: Card
  order: 7
---

# BrnBubbleText

气泡背景文本展示，支持展开/收起操作。

## 一、效果总览

<img src="./img/bubbleTextExpaned.png" style="zoom:50%;" />
<br/>
<img src="./img/bubbleTextCollapsed.png" style="zoom:50%;" />

## 二、描述

### 适用场景

详情页中，显示大块文本，支持 “收起/展开” 操作。

## 三、构造函数及参数说明

### 构造函数

```dart
const BrnBubbleText({Key key, this.text, this.maxLines, this.expandable, this.radius = 4})
  : super(key: key);
```

### 参数说明

| **参数名** | **参数类型**                          | **描述**                                           | **是否必填** | **默认值** |
| ---------- | ------------------------------------- | -------------------------------------------------- | ------------ | ---------- |
| text       | String                                | 显示的文本                                         | 是           |            |
| maxLines   | int                                   | 最多显示的行数，如果实际的行数超标，就显示折叠状态 | 否           |            |
| onExpand   | TextExpandedCallback = Function(bool) | 展开收起回调                                       | 否           |            |
| radius     | double                                | 气泡的圆角大小                                     | 否           | 4          |

## 四、代码演示

### 效果 1

<img src="./img/bubbleTextExpaned.png" style="zoom:50%;" />
<br />
<img src="./img/bubbleTextCollapsed.png" style="zoom:50%;" />

```dart
BrnBubbleText(
  maxLines: 2,
  text: '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容',
  expandable: (isExpanded){
    String str = isExpanded?"展开了":"收起了";
    BrnToast.show("我$str", context);
  },
);
```
