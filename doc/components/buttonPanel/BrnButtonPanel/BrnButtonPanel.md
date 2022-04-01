---
title: BrnButtonPanel
group:
  title: Button
  order: 5
---

# BrnButtonPanel

主次按钮组成的横向按钮交互面板。

## 一、效果总览

<img src="./img/BrnButtonPanelIntro.png" style="zoom:67%;" />

## 二、描述

### 适用场景

常用于卡片底部的组合按钮：主题色小按钮、边框小按钮。

### 交互规则

1. 一个主按钮和多个次级按钮。
2. 次按钮不多于2个时，优先显示主按钮，剩下的地方平分给次按钮。
3. 次按钮2个以上时，所有按钮等分，以更多弹窗显示，弹窗的方向可设置上/下。
4. 所有按钮均可设置是否可用。
5. 按钮之间的间距是 8。

## 三、构造函数及参数说明

### 构造函数

```dart
const BrnButtonPanel(
      {Key? key,
      required this.mainButtonName,
      required this.mainButtonOnTap,
      this.isMainBtnEnable = true,
      this.secondaryButtonNameList,
      this.secondaryButtonOnTap,
      this.secondaryButtonList,
      this.horizontalPadding = 20,
      this.popDirection = BrnPopupDirection.bottom})
      : super(key: key);
```
### 参数说明

| **参数名** | **参数类型** | **描述** | **是否必填** | **默认值** |
| --- | --- | --- | --- | --- |
| mainButtonName | String | 主按钮的显示文案 | 是 | 无 |
| mainButtonOnTap | VoidCallback | 主按钮的点击回调 | 是 | 无 |
| isMainBtnEnable | bool | 主按钮enable状态 | 否 | false |
| secondaryButtonNameList | `List<String>` | 默认状态下，次按钮的文案集合。如果需要修改按钮的可用状态，请使用 secondaryButtonList 初始化。 | 否 | 无 |
| secondaryButtonOnTap | void Function(int) | 边框按钮的点击回调，int是边框按钮索引值 | 否 | 无 |
| secondaryButtonList | `List<BrnButtonPanelConfig>` | 支持设置按钮可用状态的次按钮集合，优先级高于secondaryButtonNameList | 否 | 无 |
| horizontalPadding | double | 控件水平方向上的左右padding | 否 | 20 |
| popDirection | BrnPopupDirection | 点击更多按钮时弹窗的方向 | 否 | BrnPopupDirection.bottom |

### 其他数据说明

#### BrnButtonPanelConfig

| **参数名** | **参数类型** | **描述** | **是否必填** | **默认值** |
| --- | --- | --- | --- | --- |
| name | String | 按钮名称 | 否 | 无 |
| isEnable | bool | 按钮是否可用 | 否 | true |

## 四、代码演示

### 效果1：只有主按钮

 

<img src="./img/BrnButtonPanelDemo1.png" style="zoom: 33%;" />

```dart
BrnButtonPanel(
  mainButtonName: '主按钮',
  mainButtonOnTap: () {
    BrnToast.show('主按钮点击', context);
  },
  secondaryButtonOnTap: (index) {
    BrnToast.show('第$index个次按钮点击了', context);
  },
)
```
### 效果2：主按钮和一个次按钮

 

<img src="./img/BrnButtonPanelDemo2.png" style="zoom: 33%;" />

```dart
BrnButtonPanel(
  mainButtonName: '主按钮',
  mainButtonOnTap: () {
    BrnToast.show('主按钮点击', context);
  },
  secondaryButtonNameList: ['次按钮1'],
  secondaryButtonOnTap: (index) {
    BrnToast.show('第$index个次按钮点击了', context);
  },
),
```
### 效果3：主按钮和两个次按钮

 

<img src="./img/BrnButtonPanelDemo3.png" style="zoom:33%;" />

```dart
BrnButtonPanel(
  mainButtonName: '主按钮',
  mainButtonOnTap: () {
    BrnToast.show('主按钮点击', context);
  },
  secondaryButtonNameList: ['次按钮1', '次按钮2'],
  secondaryButtonOnTap: (index) {
    BrnToast.show('第$index个次按钮点击了', context);
  },
),
```
### 效果4：含有不可用的次按钮

<img src="./img/BrnButtonPanelDemo4.png" style="zoom:33%;" />

```dart
BrnButtonPanel(
  mainButtonName: '主按钮',
  mainButtonOnTap: () {
    BrnToast.show('主按钮点击', context);
  },
  secondaryButtonList: [
    BrnButtonPanelConfig(name: '次按钮1', isEnable: false),
    BrnButtonPanelConfig(name: '次按钮2', isEnable: true)
  ],
  secondaryButtonOnTap: (index) {
    BrnToast.show('第$index个次按钮点击了', context);
  },
),
```
### 效果5：主按钮不可用

<img src="./img/BrnButtonPanelDemo5.png"  />

```dart
BrnButtonPanel(
  mainButtonName: '主按钮',
  mainButtonOnTap: () {
    BrnToast.show('主按钮点击', context);
  },
  isMainBtnEnable: false,
  secondaryButtonNameList: ['次按钮1'],
  secondaryButtonOnTap: (index) {
    BrnToast.show('第$index个次按钮点击了', context);
  },
),
```

### 效果6：向下弹出更多按钮

<img src="./img/BrnButtonPanelDemo6.png" style="zoom:50%;" />

```dart
BrnButtonPanel(
  mainButtonName: '主按钮',
  mainButtonOnTap: () {
    BrnToast.show('主按钮点击', context);
  },
  secondaryButtonList: [
    BrnButtonPanelConfig(name: '次按钮1', isEnable: true),
    BrnButtonPanelConfig(name: '次按钮2', isEnable: true),
    BrnButtonPanelConfig(name: '次按钮3', isEnable: true),
    BrnButtonPanelConfig(name: '次按钮4', isEnable: true),
    BrnButtonPanelConfig(name: '次按钮5', isEnable: true),
  ],
  secondaryButtonOnTap: (index) {
    BrnToast.show('第$index个次按钮点击了', context);
  },
),
```

