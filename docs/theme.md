---
order: 3
---

# 主题定制

<blockquote><p style="color:#666666">
  <font size="2">如果你想对使用的组件进行一些定制，你需要了解以下内容以帮助你快速实现你的构想。</font></p></blockquote>

#### 哪些组件支持主题定制?

主题定制支持 demo 中带有<img src="https://img.ljcdn.com/beike/zjz/bruno/img/1637748742363.png" alt="img" style="zoom: 50%;" />标签的组件

<img src="https://img.ljcdn.com/beike/zjz/bruno/img/1637635513070.gif" alt="img" style="zoom:50%;" />

#### 支持哪些属性的定制？

这里的主题定制不仅是支持换色，还支持文字大小，间距、圆角等，每个可定制组件都有 <code>themeData</code> 属性，可以查看 <code>themeData</code> 相关类了解每个组件支持定制的样式。

#### 适用什么场景？

- 全局样式配置

<img src="https://img.ljcdn.com/beike/zjz/bruno/img/1639051288686.gif" alt="img" style="zoom:50%;" />

- 单组件样式配置

<img src="https://img.ljcdn.com/beike/zjz/bruno/img/1639051268630.gif" alt="img" style="zoom:50%;" />

如果你也需要类似适配，可以参照以下步骤开始专属定制~

### 主题配置

Bruno 默认走 [Bruno](https://mp.weixin.qq.com/s?__biz=MzIyODcxODY0OA==&mid=2247486048&idx=1&sn=0cc95bd85a54ce0f39f6247d15618ae8&chksm=e84ceb37df3b62216b34c7be041229630eca3d7c4fd3823ebf0520a9f2c99ed2cdf3e677904b&mpshare=1&scene=1&srcid=11012tvWvcYunVGfiPa8EfCT&sharer_sharetime=1635751229200&sharer_shareid=dbde8f595d5b99a8f5cfb27122964615&version=3.1.16.90294) 设计风格，如果你想更换主题，可以参照以下步骤：

- step1：

在 Flutter 工程中创建一个 `utils` 类用来存放全局配置 如：`config_xxx_utils.dart`

- step2:

在创建的 `config_xxx_utils.dart` 中创建个工具类 `XxxConfigUtils`

- step3:

类中加入你想定制的样式，比如你想更换主题色，那么可以加如下代码

```dart
class XxxConfigUtils {

  static BrnAllThemeConfig defaultAllConfig = BrnAllThemeConfig(
      commonConfig: defaultCommonConfig);

  /// 全局配置
  static BrnCommonConfig defaultCommonConfig = BrnCommonConfig(
    ///品牌色
    brandPrimary: const Color(0xFF3072F6),
  ）;
}
```

如果你想配置 `Dialog` 圆角更大，那么可以这么做

```dart
class XxxConfigUtils {

  static BrnAllThemeConfig defaultAllConfig = BrnAllThemeConfig(
    commonConfig: defaultCommonConfig,
    // 这里添加dialog配置
    dialogConfig: defaultDialogConfig);

  static BrnCommonConfig defaultCommonConfig = BrnCommonConfig(
    brandPrimary: const Color(0xFF3072F6),
  ）;

  /// Dialog配置
  static BrnDialogConfig defaultDialogConfig = BrnDialogConfig(
    radius: 12.0,
  );
}
```

- step4:

在 `main.dart` 中注册前面创建的配置

```dart
BrnInitializer.register(allThemeConfig: XxxConfigUtils.defaultAllConfig);
```

当然你也可以忽略  step1 ~ step3，直接在 `main.dart` 中注册 `BrnAllThemeConfig`

```dart
BrnInitializer.register(
      allThemeConfig: BrnAllThemeConfig(
          // 全局配置
          commonConfig: BrnCommonConfig(brandPrimary: Color(0xFF3072F6)),
          // dialog配置
          dialogConfig: BrnDialogConfig(radius: 12.0))
);
```

最后

如果你想针对单个组件而并非一组组件进行配置，正如上面我们提到了所有支持主题定制的组件都有一个可选参数  <code>themeData</code>

```dart
BrnMultiChoiceInputFormItem(
  prefixIconType: BrnPrefixIconType.TYPE_REMOVE,
  isRequire: true,
  error: "必填项不能为空",
  title: "自然到访保护期",
  subTitle: "这里是副标题",
  tipLabel: "标签",
  ...
  themeData: BrnFormItemV2Config(titleTextStyle:BrnTextStyle(color: Colors.red)),
)
```
