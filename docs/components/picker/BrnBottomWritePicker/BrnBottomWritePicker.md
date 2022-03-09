---
title: BrnBottomWritePicker
group:
  title: Picker
  order: 23
---


## BrnBottomWritePicker

从底部弹出带输入框的 Picker。

## 一、效果总览

<img src="./img/BrnBottomWritePicker.png" style="zoom:50%;" />


## 二、描述

### 交互规则

1. maxLength 可配置最大输入长度，默认 200

2. 推荐使用 BrnBottomWritePicker.show() 弹出 Picker

## 三、构造函数及参数说明

### 构造函数

```dart
const BrnBottomWritePicker(
      {this.maxLength = 200,
      this.hintText = "请输入",
      this.leftTag = "取消",
      this.title = "",
      this.rightTag = "确认",
      this.onCancel,
      this.onConfirm,
      this.rightTextColor,
      this.cursorColor,
      this.defaultText,
      this.textEditingController});
```

### 参数说明

| 参数名                | 参数类型                                                     | 作用                                                         | 是否必填 | 默认值 |
| --------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------- | ------ |
| maxLength             | int                                                          | 最大输入长度                                                 | 否       | 200    |
| hintText              | String                                                       | 提示语                                                       | 否       | 请输入 |
| leftTag               | String                                                       | 左侧按钮文案                                                 | 否       | 取消   |
| title                 | String                                                       | 标题文案                                                     | 否       |        |
| rightTag              | String                                                       | 右侧按钮文案                                                 | 否       | 确认   |
| cancel                | BrnBottomWritePickerClickCallback = Future<void> Function(String content)？ | 取消输入事件回调                                             | 否       |        |
| confirm               | BrnBottomWritePickerConfirmClickCallback = Future<void> Function(     BuildContext dialogContext, String content)？ | 确认输入事件回调                                             | 否       |        |
| rightTextColor        | Color？                                                      | 右侧文案 Color                                               | 否       | 主题色 |
| cursorColor           | Color？                                                      | 光标颜色                                                     | 否       | 主题色 |
| defaultText           | String？                                                     | 输入框默认文字                                               | 否       |        |
| textEditingController | TextEditingController？                                      | 用于对 TextField 更精细的控制，若传入该字段，[defaultText] 参数将失效，可使用 TextEditingController.text 进行赋值 | 否       |        |

## 四、效果及代码展示

###   效果1：标题+输入框

<img src="./img/BrnBottomWritePicker.png" style="zoom:50%;" />



```dart
///底部有输入框弹框
void _showBottomWriteDialog(BuildContext context) {
  BrnBottomWritePicker.show(context,  title: '写跟进',
    hintText: '请输入',
    confirmDismiss: true,
    confirm: (context, string) {
      return;
    },
    cancel: (_){
      BrnToast.show(_, context);
    },
    defaultText: '',);
}
```
