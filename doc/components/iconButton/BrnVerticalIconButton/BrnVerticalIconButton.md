---
title: BrnVerticalIconButton
group:
  title: Button
  order: 5
---
# BrnVerticalIconButton

## 一、效果总览

![](./img/BrnVerticalIconButtonIntro.png)

## 二、描述

图片在上，文字在下的垂直排列按钮。


## 三、构造函数及参数说明

### 构造函数


```dart
const BrnVerticalIconButton({
    Key? key,
    required this.name,
    required this.iconWidget,
    this.onTap,
  }) : super(key: key);
```
### 参数说明

| 参数名 | 参数类型 | 描述 | 是否必填 | 默认值 |
| --- | --- | --- | --- | --- |
| key | Key | 视图绑定的 key | 否 | 无 |
| name | String | 需要显示的文案 | 是 | 无 |
| iconWidget | Widget | 需要显示的图标 widget | 是 | 无 |
| onTap | VoidCallback? | 按钮点击的回调处理 | 否 | 无 |

## 四、代码演示

![](./img/BrnVerticalIconButtonIntro.png)

```dart
BrnVerticalIconButton(  
  name: '更多',  
  iconWidget: Icon(Icons.more),  
  onTap: () {  
    BrnToast.show('更多按钮被点击', context);  
  }
)
```
