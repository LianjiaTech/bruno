---
title: BrnPageLoading
group:
  title: Loading
  order: 19
---

# BrnPageLoading

## 一、效果总览

![](./img/BrnPageLoadingDemo1.png)

## 二、描述

### 适用场景

页面中间的加载框，可以配置显示的文字。

## 三、构造函数及参数说明

### 构造函数

```dart
const BrnPageLoading({Key? key,
  this.content,
  this.constraints = const BoxConstraints(minWidth: 130, maxWidth: 130, minHeight: 50, maxHeight: 50,),
}): super(key: key);
```
### 参数配置

| **参数名** | **参数类型** | **描述** | **是否必填** | **默认值** |
| --- | --- | --- | --- | --- |
| content | String? | 显示的文案 | 否 | 默认值为国际化配置文本 '加载中...' |
| constraints | BoxConstraints | 约束 | 否 |  BoxConstraints(minWidth: 130, maxWidth: 130, minHeight: 50, maxHeight: 50,) |
## 四、代码演示

###  效果1：只有主按钮

![](./img/BrnPageLoadingDemo1.png) 


```dart
BrnPageLoading()  
```

###  效果2：自定义文字


![](./img/BrnPageLoadingDemo2.png) 


```dart
BrnPageLoading(content: '提交中...',)
```
