---
title: BrnTitleFormItem
group:
  title: Form
  order: 12
---

# BrnTitleFormItem

## 一、效果总览

![](./img/BrnTitleFormItemIntro.png)

## 二、描述

### 适用场景

标题类型录入项

### 交互规则

右侧“操作”区文案可点击

## 三、构造函数及参数说明

### 构造函数

```dart
BrnTitleFormItem(
      {Key? key,
      this.label,
      this.title = "",
      this.subTitle,
      this.tipLabel,
      this.prefixIconType = BrnPrefixIconType.normal,
      this.error = "",
      this.isEdit = true,
      this.isRequire = false,
      this.onTip,
      this.operationLabel,
      this.onTap,
      this.backgroundColor,
      this.themeData})
      : super(key: key) {
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
    this.themeData = this.themeData!.merge(
        BrnFormItemConfig(backgroundColor: backgroundColor));
  }
```
### 参数说明：

| **参数名** | **参数类型** | **描述** | **是否必填** | **默认值** | **备注** |
| --- | --- | --- | --- | --- | --- |
| backgroundColor | Color? | 表单项背景色 | 否 | 走主题配置默认色值 Colors.white |  |
| label | String? | 录入项的唯一标识，主要用于录入类型页面框架中 | 否 | 无 |  |
| type | Stirng | 录入项类型，主要用于录入类型页面框架中 | 否 | BrnInputItemType.labelTitle | 外部可根据此字段判断表单项类型 |
| title | String | 录入项标题 | 否 | '' |  |
| subTitle | String? | 录入项子标题 | 否 | 无 |  |
| tipLabel | String? | 录入项提示（问号图标&文案） 用户点击时触发onTip回调。 | 否 | 备注中类型3 | 1. 设置"空字符串"时展示问号图标 2. 设置"非空字符串"时展示问号图标&文案 3. 若不赋值或赋值为null时，不显示提示项 |
| prefixIconType | String | 录入项前缀图标样式 "添加项" "删除项" 详见 **BrnPrefixIconType** 类 | 否 | BrnPrefixIconType.normal | 1. 不展示图标：BrnPrefixIconType.normal 2. 展示加号图标：BrnPrefixIconType.add 3. 展示减号图标：BrnPrefixIconType.remove |
| error | String | 录入项错误提示 | 否 | '' |  |
| isRequire | bool | 录入项是否为必填项（展示`*`图标）， 默认为 false 不必填 | 否 | false |  |
| isEdit | bool | 录入项 是否可编辑 | 否 | true | true：可编辑，false：禁用 |
| onTip | VoidCallback? | 点击"？"图标回调 | 否 | 无 | 见**tipLabel**字段 |
| operationLabel | String? | 可操作区文案 | 否 | 无 |  |
| onTap | VoidCallback? | 可操作区点击回调 | 否 | 无 |  |
| themeData | BrnFormItemConfig? | form配置 | 否 | 无 | |

## 四、代码演示

### 效果1：基本样式

![](./img/BrnTitleFormItemDemo1.png)
```dart
BrnTitleFormItem(
  title: "自然到访保护期",
  operationLabel: "点击操作",
  onTip: () {
    BrnToast.show("点击触发回调_onTip", context);
  },
  onTap: () {
    BrnToast.show("点击触发回调_onTap", context);
  },
),
```
### 效果2：全功能样式

![](./img/BrnTitleFormItemDemo2.png)
```dart
BrnTitleFormItem(
  error: "必填项不能为空",
  title: "自然到访保护期",
  subTitle: "这里是副标题",
  tipLabel: "提示",
  operationLabel: "点击操作",
  onTip: () {
    BrnToast.show("点击触发回调_onTip", context);
  },
  onTap: () {
    BrnToast.show("点击触发回调_onTap", context);
  },
),
```

### 效果3：不带错误提示

![](./img/BrnTitleFormItemDemo3.png)
```dart
BrnTitleFormItem(
  title: "自然到访保护期",
  subTitle: "这里是副标题",
  tipLabel: "提示",
  operationLabel: "点击操作",
  onTip: () {
    BrnToast.show("点击触发回调_onTip", context);
  },
  onTap: () {
    BrnToast.show("点击触发回调_onTap", context);
  },
),
```

