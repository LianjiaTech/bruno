

import 'dart:collection' show Queue;
import 'dart:math' as math;

import 'package:bruno/src/components/tabbar/bottom/brn_bottom_tab_bar_item.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';

/// 定义一些UI常量,根据UI稿进行填写
const double _kActiveFontSize = 10.0;
const double _kInactiveFontSize = 9.0;
const double _kTopMargin = 6.0;
const double _kBottomMargin = 0.0;
const double _kMiddleInterval = 4.0;

/// tabBar显示状态
enum BrnBottomTabBarDisplayType {
  /// 固定显示状态
  fixed,

  /// 浮动显示状态
  shifting,
}

/// 简述：底部导航栏组件容器，其中[BrnBottomTabBarItem]控制每个tab的状态
/// 功能：底部导航栏主容器控制，如点击动画，每个tab的悬浮样式
/// 特别注意：默认关闭点击动画，为固定显示状态
class BrnBottomTabBar extends StatefulWidget {
  BrnBottomTabBar({
    Key? key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.type = BrnBottomTabBarDisplayType.fixed,
    this.fixedColor,
    this.iconSize = 24.0,
    this.isAnimation = false,
    this.badgeColor,
    this.isInkResponse = false,
  })  : assert(items.isNotEmpty),
        assert(
          items.every((BrnBottomTabBarItem item) => item.title != null) == true,
          'Every item must have a non-null title',
        ),
        assert(0 <= currentIndex && currentIndex < items.length),
        super(key: key);

  /// 动画是否可见，默认：true
  final bool isAnimation;

  /// 未读弹窗背景颜色，默认：fixedColor
  final Color? badgeColor;

  /// InkResponse:是否可访问, 默认：true
  final bool isInkResponse;

  /// 底部导航栏中的交互式Tab，每个Tab都有一个图标和标题。
  final List<BrnBottomTabBarItem> items;

  /// Tab点击之后的回调函数
  final ValueChanged<int>? onTap;

  /// 当前活动项的索引值
  final int currentIndex;

  /// 底部选项卡的枚举类型fixed/shifting 默认为fixed
  final BrnBottomTabBarDisplayType type;

  /// 底部Tab所选中时的颜色
  final Color? fixedColor;

  /// Tab中图标的大小
  final double iconSize;

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}


/// 底部导航栏中状态控制类
class _BottomTabBarState extends State<BrnBottomTabBar> with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  late List<CurvedAnimation> _animations;

  /// 当前正在执行图标变色逻辑的队列
  final Queue<_Circle> _circles = Queue<_Circle>();

  /// 执行完动画之后的背景颜色
  Color? _backgroundColor;

  static final Animatable<double> _flexTween =
      Tween<double>(begin: 1.0, end: 1.5);

  void _resetState() {
    for (AnimationController controller in _controllers) {
      controller.dispose();
    }
    for (_Circle circle in _circles) {
      circle.dispose();
    }
    _circles.clear();

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      )..addListener(_rebuild);
    });
    _animations =
        List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });
    _controllers[widget.currentIndex].value = 1.0;
    _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
  }

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _rebuild() {
    setState(() {
      /// 当任何控制器运行时重新构建，即当项目运行时动画
    });
  }

  @override
  void dispose() {
    for (AnimationController controller in _controllers) {
      controller.dispose();
    }
    for (_Circle circle in _circles) {
      circle.dispose();
    }
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) =>
      _flexTween.evaluate(animation);

  void _pushCircle(int index) {
    if (widget.items[index].backgroundColor != null) {
      _circles.add(
        _Circle(
          state: this,
          index: index,
          color: widget.items[index].backgroundColor!,
          vsync: this,
        )..controller.addStatusListener(
            (AnimationStatus status) {
              switch (status) {
                case AnimationStatus.completed:
                  setState(() {
                    final _Circle circle = _circles.removeFirst();
                    _backgroundColor = circle.color;
                    circle.dispose();
                  });
                  break;
                case AnimationStatus.dismissed:
                case AnimationStatus.forward:
                case AnimationStatus.reverse:
                  break;
              }
            },
          ),
      );
    }
  }

  /// 更新整个widget
  @override
  void didUpdateWidget(BrnBottomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// 如果项目列表的长度发生变化，则没有动画。
    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      switch (widget.type) {
        case BrnBottomTabBarDisplayType.fixed:
          break;
        case BrnBottomTabBarDisplayType.shifting:
          _pushCircle(widget.currentIndex);
          break;
      }
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    } else {
      if (_backgroundColor != widget.items[widget.currentIndex].backgroundColor) {
        _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
      }
    }
  }

  /// 生成瓦片
  List<Widget> _createTiles() {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final List<Widget> children = <Widget>[];
    switch (widget.type) {
      case BrnBottomTabBarDisplayType.fixed:
        final ThemeData themeData = Theme.of(context);
        final TextTheme textTheme = themeData.textTheme;
        Color? themeColor;
        switch (themeData.brightness) {
          case Brightness.light:
            themeColor = themeData.primaryColor;
            break;
          case Brightness.dark:
            themeColor = themeData.colorScheme.secondary;
            break;
        }
        final ColorTween colorTween = ColorTween(
          begin: textTheme.bodySmall!.color,
          end: widget.fixedColor ?? themeColor,
        );
        for (int i = 0; i < widget.items.length; i += 1) {
          children.add(
            _BottomNavigationTile(
              widget.type,
              widget.items[i],
              _animations[i],
              widget.iconSize,
              onTap: () {
                if (widget.onTap != null) widget.onTap!(i);
              },
              colorTween: colorTween,
              selected: i == widget.currentIndex,
              indexLabel: localizations.tabLabel(
                  tabIndex: i + 1, tabCount: widget.items.length),
              isAnimation: widget.isAnimation,
              isInkResponse: widget.isInkResponse,
              badgeColor: widget.badgeColor == null
                  ? widget.fixedColor
                  : widget.badgeColor,
            ),
          );
        }
        break;
      case BrnBottomTabBarDisplayType.shifting:
        for (int i = 0; i < widget.items.length; i += 1) {
          children.add(
            _BottomNavigationTile(
              widget.type,
              widget.items[i],
              _animations[i],
              widget.iconSize,
              onTap: () {
                if (widget.onTap != null) widget.onTap!(i);
              },
              flex: _evaluateFlex(_animations[i]),
              selected: i == widget.currentIndex,
              indexLabel: localizations.tabLabel(
                  tabIndex: i + 1, tabCount: widget.items.length),
              isAnimation: widget.isAnimation,
              isInkResponse: widget.isInkResponse,
              badgeColor: widget.badgeColor == null
                  ? widget.fixedColor
                  : widget.badgeColor,
            ),
          );
        }
        break;
    }
    return children;
  }

  /// 生成容器
  /// tiles: 传入的瓦片list
  Widget _createContainer(List<Widget> tiles) {
    return DefaultTextStyle.merge(
      overflow: TextOverflow.ellipsis,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tiles,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(debugCheckHasMaterialLocalizations(context));

    /// 标签应用到_bottomMargin padding。其余部分是媒体填充。
    /// 下标题距底部距离
    final double additionalBottomPadding =
        math.max(MediaQuery.of(context).padding.bottom - _kBottomMargin, 0.0);
    Color? backgroundColor;
    switch (widget.type) {
      case BrnBottomTabBarDisplayType.fixed:
        break;
      case BrnBottomTabBarDisplayType.shifting:
        backgroundColor = _backgroundColor;
        break;
    }
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Material(
              /// 投下阴影
              elevation: 8.0,
              color: backgroundColor,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight:
                    kBottomNavigationBarHeight + additionalBottomPadding),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: CustomPaint(
                    painter: _RadialPainter(
                      circles: _circles.toList(),
                      textDirection: Directionality.of(context),
                    ),
                  ),
                ),
                Material(
                  // Splashes.
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: additionalBottomPadding),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      child: _createContainer(_createTiles()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/// 表示底部导航栏中的单个tile，它的目的是进入一个伸缩页面
class _BottomNavigationTile extends StatelessWidget {

  const _BottomNavigationTile(
      this.type,
      this.item,
      this.animation,
      this.iconSize, {
        this.onTap,
        this.colorTween,
        this.flex,
        this.selected = false,
        this.indexLabel,
        this.isAnimation = true,
        this.isInkResponse = true,
        this.badgeColor,
      });

  final BrnBottomTabBarDisplayType type;
  final BrnBottomTabBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback? onTap;
  final ColorTween? colorTween;
  final double? flex;
  final bool selected;
  final String? indexLabel;
  final bool isAnimation;
  final bool isInkResponse;
  final Color? badgeColor;

  @override
  Widget build(BuildContext context) {
    /// 为了在动画过程中使用flex容器来增长平铺块，我们
    /// 需要将flex分配中的更改划分为更小的块
    /// 制作流畅的动画。我们通过将flex值相乘来实现这一点
    /// (这是一个整数)乘以一个大数。
    late int size;
    Widget? label;
    switch (type) {
      case BrnBottomTabBarDisplayType.fixed:
        size = 1;
        label = _buildFixedLabel();
        break;
      case BrnBottomTabBarDisplayType.shifting:
        size = (flex! * 1000.0).round();
        label = _buildShiftingLabel();
        break;
    }

    return Expanded(
      flex: size,
      child: Semantics(
        container: true,
        header: true,
        selected: selected,
        child: Stack(
          children: <Widget>[
            Positioned(right: 4, top: 4, child: _buildBadge()!),
            _buildInkWidget(label),
            Semantics(
              label: indexLabel,
            )
          ],
        ),
      ),
    );
  }


  /// 构建icon
  Widget _buildIcon() {
    double? tweenStart;
    Color? iconColor;
    switch (type) {
      case BrnBottomTabBarDisplayType.fixed:
        tweenStart = 8.0;
        iconColor = colorTween?.evaluate(animation);
        break;
      case BrnBottomTabBarDisplayType.shifting:
        tweenStart = 16.0;
        iconColor = selected ? BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary : null;
        break;
    }
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1.0,
      child: Container(
        margin: EdgeInsets.only(
          top: isAnimation
              ? Tween<double>(
            begin: tweenStart,
            end: _kTopMargin,
          ).evaluate(animation)
              : _kTopMargin,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: iconSize,
          ),
          child: selected ? item.activeIcon : item.icon,
        ),
      ),
    );
  }

  /// 构建固定Label
  /// 修改icon与text间距在这里修改
  Widget _buildFixedLabel() {
    double scale = isAnimation
        ? Tween<double>(
      begin: _kInactiveFontSize / _kActiveFontSize,
      end: 1.0,
    ).evaluate(animation)
        : 1.0;
    return Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1.0,
      child: Container(
        margin: const EdgeInsets.only(
            bottom: _kBottomMargin, top: _kMiddleInterval),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: _kActiveFontSize,
            color: colorTween?.evaluate(animation),
          ).merge(selected ? item.selectedTextStyle : item.unSelectedTextStyle),

          /// 使用矩阵变化控制字体大小
          child: Transform(
            transform: Matrix4.diagonal3Values(
              scale,
              scale,
              scale,
            ),
            alignment: Alignment.bottomCenter,
            child: item.title,
          ),
        ),
      ),
    );
  }

  /// 构建可变Label
  Widget _buildShiftingLabel() {
    return Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1.0,
      child: Container(
        margin: EdgeInsets.only(
          bottom: Tween<double>(
            /// 在规范中，他们只是删除了非活动项目的标签，并指定了16dp的底部边距，
            /// 我们不想移除标签因为我们想淡入淡出它，所以这修改了底部边距来考虑到这一点。
            begin: 2.0,
            end: _kBottomMargin,
          ).evaluate(animation),
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: _kActiveFontSize,
            color: selected ? BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary
                : BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase,
          ).merge(selected ? item.selectedTextStyle : item.unSelectedTextStyle),
          child: item.title!,
        ),
      ),
    );
  }

  /// 构建未读消息弹窗
  Widget? _buildBadge() {
    if (item.badge == null && (item.badgeNo == null || item.badgeNo!.isEmpty)) {
      return Container();
    }
    if (item.badge != null) {
      return item.badge;
    }
    return Container(
      width: 24,
      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: badgeColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(
        /// 设置未读数 > item.maxBadgeNo 则报加+ 默认 99
        _getUnReadText(),
        style: TextStyle(fontSize: 10, color: Colors.white),
      ),
    );
  }

  String _getUnReadText() {
    int _badgeNo = 0;
    try {
      if (item.badgeNo != null) {
        _badgeNo = int.parse(item.badgeNo!);
      }
    } catch (e) {
      debugPrint('badgeNo has FormatException');
    }
    return '${_badgeNo > item.maxBadgeNo ? '${item.maxBadgeNo}+' : _badgeNo}';
  }

  /// 构建底字体缩放动画
  /// label: 传入的文字组件
  Widget _buildInkWidget(Widget? label) {
    if (isInkResponse) {
      return InkResponse(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildIcon(),
            label!,
          ],
        ),
      );
    }
    return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildIcon(),
            label!,
          ],
        ));
  }
}


/// 简介：TabBarItem点击飞溅动画私有类
/// 功能：实现点击飞溅动画
class _Circle {
  _Circle({
    required this.state,
    required this.index,
    required this.color,
    required TickerProvider vsync,
  }) {
    controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
    controller.forward();
  }

  final _BottomTabBarState state;
  final int index;
  final Color color;
  late AnimationController controller;
  late CurvedAnimation animation;

  double get horizontalLeadingOffset {
    double weightSum(Iterable<Animation<double>> animations) {
      /// 我们添加了flex值而不是动画值来生成正确的比率。
      return animations
          .map<double>(state._evaluateFlex)
          .fold<double>(0.0, (double sum, double value) => sum + value);
    }

    final double allWeights = weightSum(state._animations);

    /// 这些权重和到索引项的起始边
    final double leadingWeights =
        weightSum(state._animations.sublist(0, index));

    /// 添加其伸缩值的一半，以到达中心
    return (leadingWeights +
            state._evaluateFlex(state._animations[index]) / 2.0) /
        allWeights;
  }

  void dispose() {
    controller.dispose();
  }
}


/// 绘制动画色彩飞溅的圆圈
class _RadialPainter extends CustomPainter {
  _RadialPainter({
    required this.circles,
    required this.textDirection,
  });

  final List<_Circle> circles;
  final TextDirection textDirection;

  /// 计算边界矩形的至少一个角与圆的边缘接触所能达到的最大半径。
  /// 不需要绘制比这个半径大的圆，因为裁切矩形内没有可感知的差异。
  static double _maxRadius(Offset center, Size size) {
    final double maxX = math.max(center.dx, size.width - center.dx);
    final double maxY = math.max(center.dy, size.height - center.dy);
    return math.sqrt(maxX * maxX + maxY * maxY);
  }

  @override
  bool shouldRepaint(_RadialPainter oldPainter) {
    if (textDirection != oldPainter.textDirection) return true;
    if (circles == oldPainter.circles) return false;
    if (circles.length != oldPainter.circles.length) return true;
    for (int i = 0; i < circles.length; i += 1) {
      if (circles[i] != oldPainter.circles[i]) return true;
    }
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (_Circle circle in circles) {
      final Paint paint = Paint()..color = circle.color;
      final Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
      canvas.clipRect(rect);
      late double leftFraction;
      switch (textDirection) {
        case TextDirection.rtl:
          leftFraction = 1.0 - circle.horizontalLeadingOffset;
          break;
        case TextDirection.ltr:
          leftFraction = circle.horizontalLeadingOffset;
          break;
      }
      final Offset center =
          Offset(leftFraction * size.width, size.height / 2.0);
      final Tween<double> radiusTween = Tween<double>(
        begin: 0.0,
        end: _maxRadius(center, size),
      );
      canvas.drawCircle(
        center,
        radiusTween.transform(circle.animation.value),
        paint,
      );
    }
  }
}
