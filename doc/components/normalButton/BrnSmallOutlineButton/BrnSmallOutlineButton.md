---
title: BrnSmallOutlineButton
group:
  title: Button
  order: 5
---

# BrnSmallOutlineButton

## 一、效果总览

<img src="./img/BrnSmallOutlineButton.png" style="zoom:50%;" />&nbsp;&nbsp;
<img src="./img/BrnSmallOutlineButtonDisabled.png" style="zoom:50%;" />

## 二、描述

### 适用场景

小边框按钮，宽度随文字自适应，但是有最小宽度为 84。

## 三、构造函数及参数说明

### 构造函数

```dart
const BrnSmallOutlineButton({
    Key? key,
    this.title,
    this.onTap,
    this.isEnable = true,
    this.lineColor,
    this.textColor,
    this.radius,
    this.width,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.themeData,
  }): super(key: key);
```

### 参数说明

| 参数名     | 参数类型         | 描述         | 是否必填 | 默认值          |
| ---------- | ---------------- | ------------ | -------- | --------------- |
| title      | String?           | 按钮显示文案 | 否       | 默认值为国际化配置文本 '确认'          |
| onTap      | VoidCallback?    | 点击的回调   | 否       | 无              |
| isEnable   | bool             | 按钮是否可用 | 否       | true            |
| lineColor  | Color?           | 边框的背景色 | 否       | 主题色          |
| width      | double?          | 按钮的宽度   | 否       | 无              |
| textColor  | Color?           | 文本的颜色   | 否       | 白色            |
| fontWeight | FontWeight       | 文本的粗细   | 否       | FontWeight.w600 |
| fontSize   | double           | 文字的大小   | 否       | 14              |
| radius     | double?          | 按钮的圆角   | 否       | 无              |
| themeData  | BrnButtonConfig? | 主题定制属性 | 否       | 无              |

## 四、代码演示

### 效果 1

<img src="./img/BrnSmallOutlineButton.png" style="zoom:50%;" />&nbsp;


```dart
BrnSmallOutlineButton(
  title: '次按钮',
  onTap: () {
  BrnToast.show('次按钮', context);
  },
)
```

### 效果 2

<img src="./img/BrnSmallOutlineButtonDisabled.png" style="zoom: 50%;" />&nbsp;

```dart
BrnSmallOutlineButton(
  title: '提交',
  isEnable: false,
  onTap: () {
  // 置灰无点击效果
  BrnToast.show('点击了按钮', context);
  },
)
```
