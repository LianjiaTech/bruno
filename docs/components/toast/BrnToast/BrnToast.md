---
title: BrnToast
group:
  title: Toast
  order: 35
---

# BrnToast

通用Toast

## 一、效果总览

<img src="./img/brn_toast_intro.png" style="zoom:50%;" />

## 二、描述

### 适用场景

1. 简短的文本提示。

2. Toast支持文字前面添加Icon

## 三、构造函数及参数说明

### 构造函数


```dart
static void show(
    String text,
    BuildContext context, {
    Duration? duration,
    Color? background,
    TextStyle? textStyle,
    double? radius,
    Image? preIcon,
    double? verticalOffset,
    VoidCallback? onDismiss,
    BrnToastGravity? gravity,
  }) 
```


```dart
/// 显示在中间。如不设置duration则会自动根据内容长度来计算（更友好，最长5秒）  
static void showInCenter(
      {required String text,
      required BuildContext context,
      Duration? duration}) {
    show(
      text,
      context,
      duration: duration,
      gravity: BrnToastGravity.center,
    );
  }
```

### 参数说明

| **参数名** | **参数类型** | **描述** | **是否必填** | **默认值** |
| --- | --- | --- | --- | --- |
| text | String | 显示的文本 | 是 | 无 |
| context | BuildContext | 创建OverlayState需要context | 是 | 无 |
| duration | Duration? | Toast显示时间的长短 | 否 | BrnToast.LENGTH\_SHORT |
| gravity | BrnToastGravity? | Toast显示在顶部还是底部 | 否 | 0：显示在底部 |
| backgroundColor | Color? | Toast的背景颜色 | 否 | Color(0xFF222222) |
| textStyle | TextStyle? | Toast显示文本的样式 | 否 | TextStyle(fontSize: 16, color: Colors.white) |
| radius | double? | Toast的圆角大小 | 否 | 5 |
| preIcon | Image? | 文字前面的图标 | 否 | 无 |
| onDismiss | VoidCallback? | 是否可关闭 | 否 | 无 |
| verticalOffset | double? | 据中心偏移量 | 否 | 无 |

## 四、代码演示

###  效果1：Toast/文字

<img src="./img/brn_toast_normal.png" style="zoom:50%;" />

```dart
BrnToast.show("共找到10932个结果", context, duration: BrnToast.LENGTH_LONG);  
```
###  效果2：Toast/失败

<img src="./img/brn_toast_fail.png" style="zoom:50%;" />



```dart
BrnToast.show(
    "失败图标Toast",
    context,
    preIcon: Image.asset(
      "assets/image/icon_toast_fail.png",
      width: 24,
      height: 24,
    ),
    duration: BrnDuration.short,
  );

```
### 效果3：Toast/成功

<img src="./img/brn_toast_success.png" style="zoom:50%;" />



```dart
BrnToast.show(
  "成功图标Toast",
  context,
  preIcon: Image.asset(
    "assets/image/icon_toast_success.png",
    width: 24,
    height: 24,
  ),
  duration: BrnDuration.short,
);
```
