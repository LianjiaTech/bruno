---
title: Progress 进度图
group:
  title: 数据图表
  order: 2
---

# BrnProgressChart

展示一段进度或者数值。

## 一、效果总览

![](./img/BrnProgressChartIntro.png)

## 二、描述

### 适用场景

1. 需要展示百分比的情形

2. 需要展示任务完成度的情形

### **注意事项**

value属性值必须在0 到 1 之间。

## 三、构造函数及参数说明

### 构造函数


```dart
const BrnProgressChart(
      {Key? key,
      this.width = 0,
      this.height = 0,
      this.value = 0.2,
      this.indicatorLeftPadding = 10,
      this.textStyle = const TextStyle(color: Colors.white),
      this.brnProgressIndicatorBuilder,
      this.colors = const [Colors.blueAccent, Colors.blue],
      this.backgroundColor = Colors.lightBlueAccent,
      this.showAnimation = false})
      : assert(0 <= value && value <= 1, 'value 必须在 0 到 1 之间'),
        super(key: key);
```
### 参数说明

| **参数名** | **参数类型** | **描述** | **是否必填** | **默认值** |
| --- | --- | --- | --- | --- |
| width | double | 宽度 | 是 | 0 |
| height | double | 高度 | 是 | 0 |
| value | double | 进度图进度值，必须在 0 到 1 之间 | 是 | 0.2 |
| indicatorLeftPadding | double | 进度条上自定义Widget的左侧padding | 否 | 10 |
| textStyle | TextStyle | 展示默认进度indicator的时候的文本样式 | 否 | TextStyle(color: Colors.white) |
| brnProgressIndicatorBuilder | BrnProgressIndicatorBuilder | 自定义进度条上面的Widget，默认显示为文本 | 否 | null |
| colors | `List<Color>` | 进度条颜色 | 否 | [Colors.blueAccent, Colors.blue] |
| backgroundColor | Color | 背景色 | 否 | Colors.lightBlueAccent |
| showAnimation | bool | 是否展示动画 | 否 | false |

## 四、代码演示

### 效果1：

![](./img/BrnProgressChartDemo1.png)
```dart
BrnProgressChart(  
  key: UniqueKey(),  
  width: 200,  
  height: 20,  
  value: 0.6,  
  brnProgressIndicatorBuilder: (BuildContext context, double value) {  
    	return Text('自定义文本：$value', style: TextStyle(color: Colors.white),  
    );  
  },  
)
```