---
order: 6
---

# FAQ

#### 如何找到适配 Flutter SDK 版本？

我们会把最新适配版本更新到 [pub.dev](https://pub.dev/packages/bruno/) 上

#### 主题定制没生效可能原因？

请确定在 <code>main.dart</code> 中注册，如果正确注册仍没有生效，可以给我们提 [issue](https://github.com/LianjiaTech/bruno/issues/new)

#### 会提供独立组件拆分依赖吗？

Bruno 是作为整套解决方案输出，因此没有做组件拆分，以后也将不会对组件进行拆分。

#### 多渠道主题定制怎么做？

可以参照 [主题定制](./theme) 部分注册每个渠道配置，注册时需要指定不同的 <code>CONFIG_ID</code> ，并且要保证这些 <code>CONFIG_ID</code> 是唯一的，渠道使用时通过注册的 <code>CONFIG_ID</code> 取相应的配置即可生效。

#### 不会使用 Sketch 插件怎么办？

通过阅读这篇文章 [Sketch 设计指引](./sketch) 你将快速了解并完成你的设计。

#### 遇到问题怎么办？

可以提 [issue](https://github.com/LianjiaTech/bruno/issues/new) 给我们，这里请参照 [issue 规范](https://github.com/LianjiaTech/bruno/issues/3) 提交，我们会定期查阅大家提的 issue，如果你已经有了解法，欢迎提 [pull request](https://github.com/LianjiaTech/bruno/pulls) 给我们。

#### Bruno 什么时候支持空安全？

我们已经在着手迁移空安全的工作，但由于组件体量较大，需要对每个组件的属性及接口做评估，因此支持空安全会相对滞后，敬请期待。
