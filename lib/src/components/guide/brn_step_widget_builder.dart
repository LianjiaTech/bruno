part of brn_intro;

/// 引导组件所处的方位
enum GuideDirection { left, right, topLeft, bottomLeft, topRight, bottomRight }

/// 单步引导组件
class StepWidgetBuilder {
  static Map _smartGetPosition(
      {required Size size,
      required Size screenSize,
      required Offset offset,
      required GuideMode introMode}) {
    double height = size.height;
    double width = size.width;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    double bottomArea = screenHeight - offset.dy - height;
    double topArea = screenHeight - height - bottomArea;
    double rightArea = screenWidth - offset.dx - width;
    double leftArea = screenWidth - width - rightArea;
    Map position = Map();
    position['crossAxisAlignment'] = CrossAxisAlignment.start;
    bool alignTop = true;
    if (introMode == GuideMode.force) {
      // 强引导模式的计算规则
      // 根据上下剩余空间 先判断整个引导组件位于上还是下
      // 然后根据左右剩余空间，判断组件位于左还是右
      // 如果左边的剩余控件特别大，那么引导组件摆在目标的左侧比较合适，同理右边也一样
      if (topArea > bottomArea) {
        position['bottom'] = bottomArea + height + 4;
      } else {
        position['top'] = offset.dy + height + 4;
        alignTop = false;
      }
      if (leftArea > rightArea) {
        position['right'] = rightArea <= 0 ? 16.0 : rightArea;
        position['crossAxisAlignment'] = CrossAxisAlignment.end;
        position['width'] = min(leftArea + width - 16, screenWidth * 0.618);
        if (alignTop) {
          position['direction'] = GuideDirection.topLeft;
        } else {
          position['direction'] = GuideDirection.bottomLeft;
        }
      } else {
        position['left'] = offset.dx <= 0 ? 16.0 : offset.dx;
        position['width'] = min(rightArea + width - 16, screenWidth * 0.618);
        if (alignTop) {
          position['direction'] = GuideDirection.topRight;
        } else {
          position['direction'] = GuideDirection.bottomRight;
        }
      }

      // The distance on the right side is very large, it is more beautiful on the right side
      if (rightArea > 0.8 * topArea && rightArea > 0.8 * bottomArea) {
        position['left'] = offset.dx + width + 4;
        position['top'] = offset.dy;
        position['bottom'] = null;
        position['right'] = null;
        position['width'] = min<double>(position['width'], rightArea * 0.8);
        position['direction'] = GuideDirection.right;
      }

      // The distance on the left is large, it is more beautiful on the left side
      if (leftArea > 0.8 * topArea && leftArea > 0.8 * bottomArea) {
        position['right'] = rightArea + width + 4;
        position['top'] = offset.dy;
        position['bottom'] = null;
        position['left'] = null;
        position['crossAxisAlignment'] = CrossAxisAlignment.end;
        position['width'] = min<double>(position['width'], leftArea * 0.8);
        position['direction'] = GuideDirection.left;
      }
    }
    if (introMode == GuideMode.soft) {
      // 弱引导模式的计算规则
      // 根据上下剩余空间 先判断整个引导组件位于上还是下
      // 然后根据左右剩余空间，判断组件位于左还是右
      // 如果位置刚好居于中间，则采用强引导的对齐模式，改变小箭头的位置

      if (topArea > bottomArea) {
        position['bottom'] = bottomArea + height / 2 + 16;
      } else {
        position['top'] = offset.dy + height / 2 + 16;
        alignTop = false;
      }
      if (leftArea > rightArea) {
        position['right'] =
            rightArea + width / 2 - 20 <= 0 ? 16.0 : rightArea + width / 2 - 20;
        position['crossAxisAlignment'] = CrossAxisAlignment.end;
        position['width'] = min(leftArea + width - 16, screenWidth * 0.618);

        if (alignTop) {
          position['direction'] = GuideDirection.topLeft;
        } else {
          position['direction'] = GuideDirection.bottomLeft;
        }
      } else {
        position['left'] = offset.dx + width / 2 - 20 <= 0
            ? 16.0
            : offset.dx + size.width / 2 - 20;
        position['width'] = min(rightArea + width - 16, screenWidth * 0.618);

        if (alignTop) {
          position['direction'] = GuideDirection.topRight;
        } else {
          position['direction'] = GuideDirection.bottomRight;
        }
      }

      if (offset.dx + size.width / 2 > screenWidth * 1 / 3 &&
          offset.dx + size.width / 2 < screenWidth * 2 / 3) {
        //标记点位于中间的情况，保持某边对齐
        if (leftArea > rightArea) {
          position['right'] = rightArea;
          position['crossAxisAlignment'] = CrossAxisAlignment.end;
          position['width'] = min(leftArea + width - 16, screenWidth * 0.618);

          position['arrowPadding'] = size.width / 2 - 8;

          if (alignTop) {
            position['direction'] = GuideDirection.topLeft;
          } else {
            position['direction'] = GuideDirection.bottomLeft;
          }
        } else {
          position['left'] = leftArea;
          position['width'] = min(rightArea + width - 16, screenWidth * 0.618);
          position['arrowPadding'] = size.width / 2 - 8;

          if (alignTop) {
            position['direction'] = GuideDirection.topRight;
          } else {
            position['direction'] = GuideDirection.bottomRight;
          }
        }
      }

      /// The distance on the right side is very large, it is more beautiful on the right side
      if (rightArea > 0.8 * topArea && rightArea > 0.8 * bottomArea) {
        position['left'] = offset.dx + width / 2 + 16;
        position['top'] = offset.dy + size.height / 2 - 20;
        position['bottom'] = null;
        position['right'] = null;
        position['width'] = min<double>(position['width'], rightArea * 0.8);
        position['direction'] = GuideDirection.right;
      }

      /// The distance on the left is large, it is more beautiful on the left side
      if (leftArea > 0.8 * topArea && leftArea > 0.8 * bottomArea) {
        position['right'] = rightArea + width / 2 + 16;
        position['top'] = offset.dy + size.height / 2 - 20;
        position['bottom'] = null;
        position['left'] = null;
        position['crossAxisAlignment'] = CrossAxisAlignment.end;
        position['width'] = min<double>(position['width'], leftArea * 0.8);
        position['direction'] = GuideDirection.left;
      }
    }
    return position;
  }

  //默认的主题模式
  //其中tipInfo为每次引导的内容
  //buttonTextBuilder为底部提示下一步的文案
  //showStepLabel表示是否展示下一步的按钮
  //showSkipLabel表示是否展示跳过按钮
  //showClose表示是否展示关闭按钮
  static Widget Function(StepWidgetParams params) useDefaultTheme(
      {required List<BrnTipInfoBean> tipInfo,
      String Function(int currentStepIndex, int stepCount)? buttonTextBuilder,
      bool showStepLabel = true,
      bool showSkipLabel = true,
      bool showClose = true}) {
    return (StepWidgetParams stepWidgetParams) {
      int currentStepIndex = stepWidgetParams.currentStepIndex;
      int stepCount = stepWidgetParams.stepCount;
      Offset offset = stepWidgetParams.offset;
      Size size = stepWidgetParams.size;
      Map position = _smartGetPosition(
          screenSize: stepWidgetParams.screenSize,
          size: size,
          offset: offset,
          introMode: stepWidgetParams.introMode);
      return Stack(
        children: [
          Positioned(
            child: Container(
                width: position['direction'] == GuideDirection.left ||
                        position['direction'] == GuideDirection.right
                    ? position['width'] + 8
                    : position['width'],
                child: BrnTipInfoWidget(
                  width: position['width'],
                  height: null,
                  info: tipInfo[currentStepIndex],
                  onNext: showStepLabel ? stepWidgetParams.onNext : null,
                  onSkip: showSkipLabel ? stepWidgetParams.onFinish : null,
                  onClose: showClose ? stepWidgetParams.onFinish : null,
                  currentStepIndex: currentStepIndex,
                  stepCount: stepCount,
                  direction: position['direction'],
                  mode: stepWidgetParams.introMode,
                  arrowPadding: position['arrowPadding'],
                  nextTip: buttonTextBuilder != null
                      ? buttonTextBuilder(currentStepIndex, stepCount)
                      : null,
                )),
            left: position['left'],
            top: position['top'],
            bottom: position['bottom'],
            right: position['right'],
          ),
          Positioned(
            left: offset.dx + size.width / 2 - 10,
            top: offset.dy + size.height / 2 - 10,
            child: stepWidgetParams.introMode == GuideMode.soft
                ? PulseWidget(
                    width: 20,
                    height: 20,
                  )
                : Row(),
          ),
        ],
      );
    };
  }
}
