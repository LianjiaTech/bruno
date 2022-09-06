---
title: BrnSwitchFormItem
group:
  title: Form
  order: 12
---

# BrnSwitchFormItem

## 一、效果总览

<img src="./img/BrnSwitchItem1.png" style="zoom:50%;" />
<img src="./img/BrnSwitchItem2.png" style="zoom:50%;" />


## 二、描述

### 适用场景

1. 带开关表单项组件
1. 包括"标题"、"副标题"、"错误信息提示"、"必填项提示"、"添加/删除按钮"、"消息提示"、"多选项"等元素。

### 交互规则

1. 设置是否为"必填项"（"\*"）

2. 设置“添加/删除”图标（"+"、"-"）：用于接收回调函数处理新增/删除录入项操作

3. 设置“提示”图标&文案（"?"）：用于接收回调函数为用户展示提示信息

4. 设置此录入项是否可编辑（禁用）

5. 设置展示错误信息（error）

### 使用规范

一般用于控制表单内容开关。

## 三、构造函数及参数说明

### 构造函数

```dart
BrnSwitchFormItem({
    Key? key,
    this.label,
    this.title = "",
    this.subTitle,
    this.tipLabel,
    this.prefixIconType = BrnPrefixIconType.normal,
    this.error= "",
    this.isEdit = true,
    this.isRequire = true,
    this.onAddTap,
    this.onRemoveTap,
    this.onTip,
    required this.value,
    this.onChanged,
    this.backgroundColor,
    this.themeData,
  }) : super() {
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

| **参数名**     | 参数类型                 | **描述**                                                     | **是否必填** | **默认值**                                        | **备注**                                                     |
| --- | --- | --- | --- | --- | --- |
| backgroundColor | Color? | 表单项背景色 | 否 | 走主题配置默认色值 Colors.white |  |
| label          | String?                          | 录入项的唯一标识，主要用于录入类型页面框架中                 | 否           | 无                                                |                                                              |
| title          | String                           | 录入项标题                                                   | 否           | ''                                                |                                                              |
| subTitle       | String?                          | 录入项子标题                                                 | 否           | 无                                                |                                                              |
| tipLabel       | String?                          | 录入项提示（问号图标&文案） 用户点击时触发 onTip 回调。      | 否           | 备注中类型 3                                      | 1. 设置"空字符串"时展示问号图标 2. 设置"非空字符串"时展示问号图标&文案 3. 若不赋值或赋值为 null 时，不显示提示项 |
| prefixIconType | String                           | 录入项前缀图标样式 "添加项" "删除项" 详见 BrnPrefixIconType 类 | 否           | BrnPrefixIconType.normal                     | 1. 不展示图标：BrnPrefixIconType.normal 2. 展示加号图标：BrnPrefixIconType.add 3. 展示减号图标：BrnPrefixIconType.remove |
| error          | String                           | 录入项错误提示                                               | 否           | ''                                                |                                                              |
| isRequire      | bool                             | 录入项是否为必填项（展示\*图标） 默认为 false 不必填         | 否           | false                                             |                                                              |
| isEdit         | bool                             | 录入项 是否可编辑                                            | 否           | true                                              | true：可编辑 false：禁用                                     |
| onAddTap       | VoidCallback?                    | 点击"+"图标回调                                              | 否           | 无                                                | 见**prefixIconType**字段                                     |
| onRemoveTap    | VoidCallback?                    | 点击"-"图标回调                                              | 否           | 无                                                | 见**prefixIconType**字段                                     |
| value | bool | 初始值 | 是 | 无 |  |
| onTip          | VoidCallback?                    | 点击"？"图标回调                                             | 否           | 无                                                | 见**tipLabel**字段                                           |
| themeData      | BrnFormItemConfig?               | form 配置                                                    | 否           | 无                                                |                                                              |

### 其他数据说明:

#### BrnPrefixIconType:

```dart
class BrnPrefixIconType {
  static const String normal = "type_normal";
  static const String add = "type_add";
  static const String remove = "type_remove";
}
```

## 四、代码演示

### 效果 1：基本样式

<img src="./img/BrnSwitchItem1.png" style="zoom:50%;" />

```dart
BrnSwitchFormItem(
  title: "自然到访保护期",
  value: _isFirstSwitchOn,
  onChanged: (oldValue, newValue) {
    setState(() {
      _isFirstSwitchOn = newValue;
    });
    BrnToast.show(
        "点击触发回调${oldValue}_${newValue}_onChanged", context);
  },
)
```

### 效果 2：全功能样式

<img src="./img/BrnSwitchItem2.png" style="zoom:50%;" />

```dart
BrnSwitchFormItem(
  prefixIconType: BrnPrefixIconType.add,
  isRequire: true,
  isEdit: true,
  error: "必填项不能为空",
  title: "自然到访保护期",
  subTitle: "这里是副标题",
  tipLabel: "标签",
  value: _isSecondSwitchOn,
  onChanged: (oldValue, newValue) {
    setState(() {
      _isSecondSwitchOn = newValue;
    });
    BrnToast.show(
        "点击触发回调${oldValue}_${newValue}_onChanged", context);
  },
)
```

