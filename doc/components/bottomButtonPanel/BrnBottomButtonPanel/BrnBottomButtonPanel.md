---
title: BrnBottomButtonPanel
group:
  title: Button
  order: 5
---

# BrnBottomButtonPanel

## 一、效果总览

样式1
<br/>
<img src="./img/pannel_2.png" style="zoom:50%;" />
<br/>
样式2
<br/>
<img src="./img/pannel_3.png" style="zoom:50%;" />
<br/>
样式3
<br/>
<img src="./img/pannel_4.png" style="zoom:50%;" />
<br/>
样式4
<br/>
<img src="./img/pannel_5.png" style="zoom: 33%;" />
<br/>
样式5
<br/>
<img src="./img/pannel_6.png" style="zoom:50%;" />
<br/>
样式6
<br/>
<img src="./img/disable_main.png" style="zoom:50%;" />

## 二、描述

### 适用场景

1. 常用于页面底部的组合按钮：主题色按钮、辅助色按钮、icon按钮

## 三、构造函数及参数说明

### 构造函数

```dart
const BrnBottomButtonPanel(
      {Key? key,
      required this.mainButtonName,
      required this.mainButtonOnTap,
      this.secondaryButtonName,
      this.secondaryButtonOnTap,
      this.enableMainButton = true,
      this.enableSecondaryButton = true,
      this.iconButtonList})
      : super(key: key);
```
### 参数说明

| 参数名 | 参数类型 | 描述 | 是否必填 | 默认值 |
| --- | --- | --- | --- | --- |
| mainButtonName | String | 主按钮的显示文案 | 是 | 无 |
| mainButtonOnTap | VoidCallback | 主按钮的点击回调 | 是 | 无 |
| secondaryButtonName | String? | 次按钮显示文案 | 否 | 无 |
| secondaryButtonOnTap | VoidCallback? | 次按钮的点击回调 | 否 | 无 |
| iconButtonList | List<BrnVerticalIconButton>? | icon按钮的集合 | 否 | 无 |
| enableMainButton | bool | 主按钮是否可用 | 否 | true |
| enableSecondaryButton | bool | 次按钮是否可用 | 否 | true |

## 四、代码演示

###  效果1：只有主按钮

 

<img src="./img/pannel_1.png" style="zoom:50%;" />

```dart
BrnBottomButtonPanel(  
   mainButtonName:'主按钮 Normal',  
   mainButtonOnTap:() {  
     BrnToast.show('主按钮被点击', context);  
   },  
)
```
###  效果2：只有主按钮和次按钮

 

<img src="./img/pannel_2.png" style="zoom:50%;" />



```dart
BrnBottomButtonPanel(  
   mainButtonName:'主按钮',  
   mainButtonOnTap:() {  
     BrnToast.show('主按钮被点击', context);  
   },  
   secondaryButtnoName:'次按钮',  
   secondaryButtonOnTap: () {  
     BrnToast.show('次按钮被点击', context);  
   },  
)
```
###  效果3：只有主按钮和一个Icon按钮

 

<img src="./img/pannel_3.png" style="zoom:50%;" />



```dart
BrnBottomButtonPanel(  
   mainButtonName:'主按钮',  
   mainButtonOnTap:() {  
     BrnToast.show('主按钮被点击', context);  
   },  
   iconButtonList:[  
     //构造Icon按钮 
     BrnVerticalIconButton (  
       name: '更多',  
       iconWidget: _iconImage,  
       onTap:() {  
         BrnToast.show('更多按钮被点击', context);  
       }  
     )  
   ]
 )
```
###  效果4：一个主按钮，一个次按钮和一个Icon按钮

 

<img src="./img/pannel_4.png" style="zoom:50%;" />

```dart
BrnBottomButtonPanel(  
   mainButtonName: '主按钮',  
   mainButtonOnTap: () {  
     BrnToast.show('主按钮被点击', context);  
   },  
   secondaryButtnoName: '次按钮',  
   secondaryButtonOnTap: () {  
     BrnToast.show('次按钮被点击', context);  
   },  
   iconButtonList: [  
     //构造Icon按钮  
     BrnVerticalIconButton(  
         name: 'Icon1',  
         iconWidget: _iconImage,  
         onTap: () {  
           BrnToast.show('更多按钮被点击', context);  
         }  
     )  
   ]  
 )
```
###  效果5：一个主按钮，多个Icon按钮

 

<img src="./img/pannel_5.png" style="zoom: 33%;" />



```dart
BrnBottomButtonPanel(  
   mainButtonName: '主按钮',  
   mainButtonOnTap: () {  
     BrnToast.show('主按钮被点击', context);  
   },  
   iconButtonList: [  
     //构造Icon按钮 
     BrnVerticalIconButton(  
         name: 'Icon1',  
         iconWidget: _iconImage,  
         onTap: () {  
           BrnToast.show('更多按钮被点击', context);  
         }  
     ),  
     BrnVerticalIconButton(  
         name: 'Icon2',  
         iconWidget: _iconImage,  
         onTap: () {  
           BrnToast.show('更多按钮被点击', context);  
         }  
     )  
   ]  
)  
```
###  效果6：一个主按钮，一个次按钮和多个Icon按钮

 

<img src="./img/pannel_6.png" style="zoom:50%;" />



```dart
BrnBottomButtonPanel(  
   mainButtonName: '主要按钮',  
   mainButtonOnTap: () {  
     BrnToast.show('主按钮被点击', context);  
   },  
   secondaryButtnoName:'次要按钮',  
   secondaryButtonOnTap: () {  
     BrnToast.show('次按钮被点击', context);  
   },  
   iconButtonList: [  
     BrnVerticalIconButton(  
         name: 'Icon1',  
         iconWidget: _iconImage,  
         onTap: () {  
           BrnToast.show('更多按钮被点击', context);  
         }  
     ),  
     BrnVerticalIconButton(  
         name: 'Icon2',  
         iconWidget: _iconImage,  
         onTap: () {  
           BrnToast.show('更多按钮被点击', context);  
         }  
     )  
   ]  
)  
```
###  效果7：一个不可用的主按钮，一个可用的次按钮

 

<img src="./img/pannel_6.png" style="zoom:50%;" />

```dart
BrnBottomButtonPanel(  
   mainButtonName: '主按钮',  
   mainButtonOnTap: () {  
     BrnToast.show('主按钮被点击', context);  
   },  
   iconButtonList: [  
     //构造Icon按钮
     BrnVerticalIconButton(  
         name: 'Icon1',  
         iconWidget: _iconImage,  
         onTap: () {  
           BrnToast.show('更多按钮被点击', context);  
         }  
     ),  
     BrnVerticalIconButton(  
         name: 'Icon2',  
         iconWidget: _iconImage,  
         onTap: () {  
           BrnToast.show('更多按钮被点击', context);  
         }  
     )  
   ]  
)
```
###  效果8：一个主按钮，一个次按钮和多个Icon按钮

 

<img src="./img/disable_and_enable.png" style="zoom:50%;" />



```dart
//次按钮的颜色可以通过 主题定制来修改
//BrnThemeConfigurator.instance.getConfig().commonConfig.brandAuxiliary
BrnBottomButtonPanel(  
  mainButtonName: '主按钮',  
  enableMainButton: false,  
  mainButtonOnTap: () {  
    BrnToast.show('主按钮', context);  
  },  
  secondaryButtnoName: '次按钮',  
  secondaryButtonOnTap: () {  
    BrnToast.show('次按钮', context);  
  }  
)
```
