---
order: 1
title: Bruno
---

### Bruno 是什么？

Bruno 是基于一整套设计体系的 Flutter 组件库。

### 特征

- 提炼自企业级移动端产品的交互和视觉风格
- 开箱即用的高质量 Flutter 组件
- 提供满足业务差异的主题定制能力

### 适配 Flutter SDK 版本

| Bruno 版本 | Flutter SDK 版本 |
| ---------- | ---------------- |
| 1.0.0      | 1.22.4           |
| 2.0.0      | 2.2.2            |

### 接入

Flutter 工程中 `pubspec.yaml` 文件里加入以下依赖：

```yaml
dependencies:
  bruno: version
```

### 代码引入

```dart
import 'package:bruno/bruno.dart';
```

### 主题定制

在 Flutter 工程目录 `main.dart` 中加如下注册方法：

```dart
BrnInitializer.register(allThemeConfig:TestConfigUtils.defaultAllConfig);
```

详见 [主题定制](./theme)

### 链接

- [首页](../)
- [所有组件](../widgets)
- [设计理念](https://mp.weixin.qq.com/s?__biz=MzIyODcxODY0OA==&mid=2247486048&idx=1&sn=0cc95bd85a54ce0f39f6247d15618ae8&chksm=e84ceb37df3b62216b34c7be041229630eca3d7c4fd3823ebf0520a9f2c99ed2cdf3e677904b&mpshare=1&scene=1&srcid=11012tvWvcYunVGfiPa8EfCT&sharer_sharetime=1635751229200&sharer_shareid=dbde8f595d5b99a8f5cfb27122964615&version=3.1.16.90294)
- [快速接入](./start)
- [主题定制](./theme)
- [常见问题](./faq)
- [Sketch 设计指引](./sketch)

- [设计物料下载](https://bruno.ke.com:3008/download/sketch)

### 谁在使用

覆盖贝壳 B 端所有业务线，服务贝壳 10+ App ，组件累积引用超 1w 次。

<blockquote><p style="color:#666666">
  <font size="2">如果你有意愿接入Bruno，或者你公司和产品使用了Bruno，欢迎到 <a href="https://github.com/LianjiaTech/bruno/issues/2">这里</a> 留言。</font></p></blockquote>

### 如何贡献

请阅读 [贡献指南](./contribution)。如果你希望参与贡献，欢迎 [Pull Request](https://github.com/LianjiaTech/bruno/pulls)，或给我们 [报告 Bug](https://github.com/LianjiaTech/bruno/issues/new)。
