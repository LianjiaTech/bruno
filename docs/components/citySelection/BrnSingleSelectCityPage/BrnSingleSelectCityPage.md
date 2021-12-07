---
title: BrnSingleSelectCityPage
group:
  title: SelectCity
  order: 27
---

# BrnSingleSelectCityPage

## 一、效果总览

![](./img/BrnSingleSelectCityPageIntro.png)

## 二、描述

### 适用场景

`BrnSingleSelectCityPage`是用于城市选择的单选页面，可以自定制导航栏文案，搜索文案信息，定位信息，右侧可快速滑动查看城市。

## 三、构造函数及参数说明

### 构造函数

```dart
BrnSingleSelectCityPage({
    this.appBarTitle = '',
    this.hotCityTitle = '',
    this.hotCityList,
    this.cityList,
    this.showSearchBar = true,
    this.locationText = '',
    this.onValueChanged,
  });
```



### 参数说明

| **参数名** | **参数类型** | **描述** | **是否必填** | **默认值** |
| --- | --- | --- | --- | --- |
| appBarTitle | String | 导航栏标题 | 否 | "" |
| hotCityTitle | String | 热门推荐标题 | 否 | "" |
| showSearchBar | bool | 是否展示searchBar | 否 |  |
| locationText | String | 当前定位城市文案 | 否 | "" |
| cityList | `List<CityInfo>` | 城市列表 | 否 |  |
| onValueChanged | ValueChanged | 点击时间 | 否 |  |
| hotCityList | `List<CityInfo>` | 热门推荐城市列表 | 否 |  |

### 其它数据


```dart
  
  ///页面标题  
  final String appBarTitle;  
  
  ///热门推荐标题  
  final String hotCityTitle;  
  
  ///是否 展示searchBar true  
  final bool showSearchBar;  
  
  ///当前城市定位文案展示  
  final String locationText;  
  
  ///城市列表  
  List<CityInfo> cityList;  
  
  ///热门推荐城市列表  
  List<CityInfo> hotCityList;  
  
  /// 单选项 点击的回调  
  final ValueChanged<CityInfo> onValueChanged;  
  
  ///城市信息  
 CityInfo {  
  //城市名称  
  String name;  
  //城市名称前这是的标记符号  
  String tagIndex;  
  //拼音  
  String namePinyin;  
  //唯一标记  
  String tag;  
}
```


## 四、代码展示

### 效果1

<img src="./img/BrnSingleSelectCityPageDemo1.png" style="zoom: 33%;" />

```dart
List<CityInfo> hotCityList = List();  
   hotCityList.addAll([  
     CityInfo(name: "北京市"),  
     CityInfo(name: "广州市"),  
     CityInfo(name: "成都市"),  
     CityInfo(name: "深圳市"),  
     CityInfo(name: "杭州市"),  
     CityInfo(name: "武汉市"),  
   ]);  

BrnSingleSelectCityPage(  
   appBarTitle: '城市单选',  
   hotCityTitle: '这里是推荐城市',  
   hotCityList: hotCityList,  
   cityList: hotCityList,  
 );  
   			
```