---
title: BrnSmallMainButton
group:
  title: Button
  order: 5
---

# BrnSmallMainButton

## 一、效果总览

<img src="./img/BrnSmallMainButton.png" style="zoom: 50%;" />&nbsp;&nbsp;
<img src="./img/BrnSmallMainButtonDisabled.png" style="zoom:50%;" />

## 二、描述

### 适用场景

主题色的小按钮，按钮宽度自适应文字的多少，但是具有最小的宽度 84。

## 三、构造函数及参数说明

### 构造函数

```dart
const BrnSmallMainButton({
    Key? key,
    this.title,
    this.onTap,
    this.isEnable = true,
    this.bgColor,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w600,
    this.fontSize,
    this.radius,
    this.maxWidth,
    this.width,
    this.themeData,
  }): super(key: key);
```

### 参数说明

| 参数名     | 参数类型        | 描述           | 是否必填 | 默认值          |
| ---------- | --------------- | -------------- | -------- | --------------- |
| title      | String?          | 按钮显示文案   | 否       | 默认值为国际化配置文本 '确认'        |
| onTap      | VoidCallback?   | 点击的回调     | 否       | 无              |
| isEnable   | bool            | 按钮是否可用   | 否       | True            |
| bgColor    | Color?          | 按钮的背景色   | 否       | 主题色          |
| width      | double?         | 按钮的宽度     | 否       | double.infinity |
| textColor  | Color           | 文本的颜色     | 否       | 白色            |
| fontWeight | FontWeight      | 文本的粗细     | 否       | bold            |
| fontSize   | double?         | 文字的大小     | 否       | 14              |
| radius     | double?         | 按钮的圆角     | 否       | 4               |
| maxWidth   | double?         | 按钮的最大宽度 | 否       | null            |
| themeData  | BrnButtonConfig? | 按钮主题配置   | 否       | 无              |

## 四、代码演示

### 效果 1

<img src="./img/BrnSmallMainButton.png" style="zoom:50%;" />

```dart
BrnSmallMainButton(
  title: '主按钮',
  onTap: () {
    BrnToast.show('录需求信息', context);
  },
)
```

### 效果 2

<img src="./img/BrnSmallMainButtonDisabled.png" style="zoom:50%;" />

```dart
BrnSmallMainButton(
  title: '提交',
  isEnable: false,
  onTap: () {
    BrnToast.show('点击了主按钮', context);
  },
)
```
