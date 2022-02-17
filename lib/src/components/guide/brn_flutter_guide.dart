library brn_intro;

import 'dart:async';
import 'dart:math';

import 'package:bruno/src/components/guide/brn_pulse_widget.dart';
import 'package:bruno/src/components/guide/brn_tip_widget.dart';
import 'package:flutter/material.dart';

part 'brn_delay_rendered_widget.dart';

part 'brn_step_widget_builder.dart';

part 'brn_step_widget_params.dart';

part 'brn_throttling.dart';

class BrnTipInfoBean {
  /// 引导标题
  final String title;

  /// 引导信息
  final String message;

  /// 引导图片
  final String imgUrl;

  BrnTipInfoBean(this.title, this.message, this.imgUrl);
}

/// 通过阻断式的交互弹框，实现新手交互
/// 支持 强引导：界面变灰，引导框高亮| 弱引导：直接在界面浮现提示框两种
class BrnGuide {
  bool _removed = false;
  late double _widgetWidth;
  late double _widgetHeight;
  late Offset _widgetOffset;
  OverlayEntry? _overlayEntry;
  int _currentStepIndex = 0;
  late Widget _stepWidget;
  List<Map> _configMap = [];
  List<GlobalKey> _globalKeys = [];
  final Color _maskColor = Colors.black.withOpacity(.6);
  final Duration _animationDuration = Duration(milliseconds: 300);
  final _th = _Throttling(duration: Duration(milliseconds: 500));
  late Size _lastScreenSize;

  /// 当前处于第几步
  int get currentStepIndex => _currentStepIndex;

  /// 每一步的具体引导 Widget
  final Widget Function(StepWidgetParams params) widgetBuilder;

  /// 高亮组件与目标组件的间距，默认是 10
  final EdgeInsets padding;

  /// 强提示下的高亮圆角，默认 BorderRadius.all(Radius.circular(4))
  final BorderRadiusGeometry borderRadius;

  /// 步骤数量，必传
  final int stepCount;

  /// 每次点击的下一步的时候的回调
  final void Function(int nextIndex)? onNextClick;

  /// 引导交互的模式
  GuideMode introMode;

  BrnGuide(
      {required this.introMode,
      required this.widgetBuilder,
      required this.stepCount,
      this.borderRadius = const BorderRadius.all(Radius.circular(4)),
      this.padding = const EdgeInsets.all(10),
      this.onNextClick})
      : assert(stepCount > 0) {
    for (int i = 0; i < stepCount; i++) {
      _globalKeys.add(GlobalKey());
      _configMap.add({});
    }
  }

  List<GlobalKey> get keys => _globalKeys;

  /// Set the configuration of the specified number of steps
  ///
  /// [stepIndex] Which step of configuration needs to be modified
  /// [padding] Padding setting
  /// [borderRadius] BorderRadius setting
  void setStepConfig(
    int stepIndex, {
    EdgeInsets? padding,
    BorderRadiusGeometry? borderRadius,
  }) {
    assert(stepIndex >= 0 && stepIndex < stepCount);
    _configMap[stepIndex] = {
      'padding': padding,
      'borderRadius': borderRadius,
    };
  }

  /// Set the configuration of multiple steps
  ///
  /// [stepsIndex] Which steps of configuration needs to be modified
  /// [padding] Padding setting
  /// [borderRadius] BorderRadius setting
  void setStepsConfig(
    List<int> stepsIndex, {
    EdgeInsets? padding,
    BorderRadiusGeometry? borderRadius,
  }) {
    assert(stepsIndex
        .every((stepIndex) => stepIndex >= 0 && stepIndex < stepCount));
    stepsIndex.forEach((index) {
      setStepConfig(
        index,
        padding: padding,
        borderRadius: borderRadius,
      );
    });
  }

  void _getWidgetInfo(GlobalKey globalKey) {
    try {
      EdgeInsets? currentConfig = _configMap[_currentStepIndex]['padding'];
      RenderBox renderBox =
          globalKey.currentContext?.findRenderObject() as RenderBox;
      _widgetWidth = renderBox.size.width +
          (currentConfig?.horizontal ?? padding.horizontal);
      _widgetHeight =
          renderBox.size.height + (currentConfig?.vertical ?? padding.vertical);
      _widgetOffset = Offset(
        renderBox.localToGlobal(Offset.zero).dx -
            (currentConfig?.left ?? padding.left),
        renderBox.localToGlobal(Offset.zero).dy -
            (currentConfig?.top ?? padding.top),
      );
    } on Exception catch (e) {
      _widgetWidth = 0;
      _widgetHeight = 0;
      _widgetOffset = Offset.zero;
      debugPrint('获取组件尺寸信息异常${e.toString()}');
    }
  }

  Widget _maskBuilder({
    double? width,
    double? height,
    BlendMode? backgroundBlendMode,
    required double left,
    required double top,
    double? bottom,
    double? right,
    BorderRadiusGeometry? borderRadiusGeometry,
    Widget? child,
  }) {
    final decoration = BoxDecoration(
      color: Colors.white,
      backgroundBlendMode: backgroundBlendMode,
      borderRadius: borderRadiusGeometry,
    );
    return AnimatedPositioned(
      duration: _animationDuration,
      child: AnimatedContainer(
        padding: padding,
        decoration: decoration,
        width: width,
        height: height,
        child: child,
        duration: _animationDuration,
      ),
      left: left,
      top: top,
      bottom: bottom,
      right: right,
    );
  }

  void _showOverlay(
    BuildContext context,
    GlobalKey globalKey,
  ) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        Size screenSize = MediaQuery.of(context).size;

        if (screenSize.width != _lastScreenSize.width &&
            screenSize.height != _lastScreenSize.height) {
          _lastScreenSize = screenSize;
          _th.throttle(() {
            _createStepWidget(context);
            _overlayEntry?.markNeedsBuild();
          });
        }

        return _DelayRenderedWidget(
          removed: _removed,
          childPersist: true,
          duration: _animationDuration,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                introMode == GuideMode.force
                    ? ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          _maskColor,
                          BlendMode.srcOut,
                        ),
                        child: Stack(
                          children: [
                            _maskBuilder(
                              backgroundBlendMode: BlendMode.dstOut,
                              left: 0,
                              top: 0,
                              right: 0,
                              bottom: 0,
                            ),
                            _maskBuilder(
                              width: _widgetWidth,
                              height: _widgetHeight,
                              left: _widgetOffset.dx,
                              top: _widgetOffset.dy,
                              borderRadiusGeometry:
                                  _configMap[_currentStepIndex]
                                          ['borderRadius'] ??
                                      borderRadius,
                            ),
                          ],
                        ),
                      )
                    : Row(),
                _DelayRenderedWidget(
                  child: _stepWidget,
                ),
              ],
            ),
          ),
        );
      },
    );
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _onNext(BuildContext context) {
    _currentStepIndex++;
    if (_currentStepIndex < stepCount) {
      if (onNextClick != null) {
        onNextClick!(currentStepIndex);
      }
      _renderStep(context);
    }
  }

  void _onFinish() {
    if (_overlayEntry == null) return;
    _removed = true;
    _overlayEntry!.markNeedsBuild();
    Timer(_animationDuration, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  void _createStepWidget(BuildContext context) {
    _getWidgetInfo(_globalKeys[_currentStepIndex]);
    Size screenSize = MediaQuery.of(context).size;
    Size widgetSize = Size(_widgetWidth, _widgetHeight);

    _stepWidget = widgetBuilder(StepWidgetParams(
      introMode: introMode,
      screenSize: screenSize,
      size: widgetSize,
      onNext: _currentStepIndex == stepCount - 1
          ? () => _onFinish()
          : () => _onNext(context),
      offset: _widgetOffset,
      currentStepIndex: _currentStepIndex,
      stepCount: stepCount,
      onFinish: _onFinish,
    ));
  }

  void _renderStep(BuildContext context) {
    _createStepWidget(context);
    _overlayEntry?.markNeedsBuild();
  }

  /// 触发引导操作 [context]当前环境[BuildContext]的启动方法
  void start(BuildContext context) {
    _lastScreenSize = MediaQuery.of(context).size;
    _removed = false;
    _currentStepIndex = 0;
    _createStepWidget(context);
    _showOverlay(
      context,
      _globalKeys[_currentStepIndex],
    );
  }

  /// Destroy the guide page and release all resources
  void dispose() {
    _onFinish();
  }
}
