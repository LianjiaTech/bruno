---
title: BrnBigGhostButton
group:
  title: Button
  order: 5
---

# BrnBigGhostButton

## 一、效果总览

![](./img/BrnBigGhostButtonDemo.png)

## 二、描述

### 适用场景

宽度为屏幕宽度的幽灵按钮


## 三、构造函数及参数说明

### 构造函数

```dart
const BrnBigGhostButton({
    Key? key,
    this.title,
    this.titleColor,
    this.bgColor,
    this.onTap,
    this.width,
    this.themeData,
  }) : super(key: key);
```
### 参数说明

| **参数名** | **参数类型** | 描述 | **是否必填** | **默认值** |
| --- | --- | --- | --- | --- |
| title | String? | 按钮显示文案 | 否 | 默认值为国际化配置文本，确认 |
| onTap | VoidCallback? | 点击的回调 | 否 | 无 |
| bgColor | Color? | 按钮的背景色 | 否 | 主题色为5透明度的颜色 |
| width | double? | 按钮的宽度 | 否 | double.infinity |
| titleColor | Color? | 按钮的文字颜色 | 否 | 主题色 |
| themeData | BrnButtonConfig? | button主题定制 | 否 | 无 |



## 四、代码演示

### 效果1

![](./img/BrnBigGhostButtonDemo.png)

```dart
BrnBigGhostButton(
  title: '次按钮',
  onTap: () {
    BrnToast.show('幽灵按钮', context);
  },
)
```