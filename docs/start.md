---
order: 2
---

# 快速开始

<blockquote><p style="color:#666666">
  <font size="2">
  开始之前，如果你还没有接触过 Flutter，推荐先学习 <a href="https://flutter.cn/">Flutter</a> 和 <a href="https://dart.cn/guides/language/language-tour">Dart</a> ，并正确安装和配置  <a href="https://developer.android.google.cn/studio">Android Studio </a>  或 <a href="https://developer.apple.com/cn/xcode/"> Xcode </a> 。如果你已经了解官方指南，并已经完成一个简单样例的开发，那么你可以开始以下步骤~</font>
</p>
</blockquote>

#### 从设计侧开始

首先你需要下载 [UI 资源文件](https://bruno.ke.com/download/sketch) ，下载完成后参照 [Sketch 设计指引](./sketch) 制作页面并输出一份带有组件信息的标注稿。

#### 代码侧接入

首先你需要有一个 Flutter 工程，具体工程创建步骤请参考 [Flutter 中文开发者网站](https://flutter.cn/docs/get-started/editor?tab=androidstudio)

然后在工程目录下 `pubspec.yaml` 文件中加入 Bruno 依赖：

```yaml
dependencies:
  bruno: version
```

<p color="#666666"><font size="2">注意：这里版本信息需要根据本地 Flutter SDK 版本选择 详见 <a href="https://pub.flutter-io.cn/packages/bruno/versions"> pub.dev </a> </font></p>

终端运行

```shell
flutter pub get
```

<p color="#666666"><font size="2">如果运行报错，请到<a href="https://pub.flutter-io.cn/packages/bruno/versions"> pub.dev </a> 上查阅依赖版本是否与本地 Flutter SDK 版本对应</font></p>

代码引入：

```dart
import 'package:bruno/bruno.dart';
```

如果你想换「风格」或者适配其它「机型」如 PAD 请参照 [主题定制](./theme) 操作

