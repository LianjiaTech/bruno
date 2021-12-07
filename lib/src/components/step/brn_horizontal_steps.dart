import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 描述: 横向步骤条,是一种常见的导航形式，它具有导航通用的属性：告知用户”我在哪/我能去哪“，
/// 步骤数目就相当于告知用户--能去哪或者说流程将要经历什么。
/// 通用组件步骤条分为三个状态：完成态/进行态/等待态，三种状态在样式上均加以区分
/// 注意事项：横向步骤条内的步骤总数最多只支持5个
class BrnHorizontalStepsManager {
  int maxCount = 0;
  BrnStepsController controller = BrnStepsController();

  ///
  /// 构建步骤条widget
  /// steps: 步骤条中元素的列表
  /// currentIndex: 指示当前进行态的步骤
  /// isCompleted: 整个流程是否完成
  /// doingIcon: 自定义正在进行状态的icon
  /// completedIcon: 自定义已完成状态的icon
  ///
  Widget buildSteps(
      {List<BrunoStep> steps,
      int currentIndex,
      bool isCompleted,
      Widget doingIcon,
      Widget completedIcon}) {
    if (steps != null) {
      maxCount = steps.length;
    }
    if (currentIndex != null) {
      controller.currentIndex = currentIndex;
    }
    if (isCompleted != null) {
      controller.isCompleted = isCompleted;
    }
    return Container(
      child: BrnHorizontalSteps(
          steps: steps, controller: controller, doingIcon: doingIcon, completedIcon: completedIcon),
    );
  }

  ///
  /// 设置步骤条当前活跃的index
  ///
  void setCurrentIndex(int index) {
    controller.setCurrentIndex(index);
  }

  ///
  /// 设置整个流程是否完成
  ///
  void setIsCompleted(bool isCompleted) {
    controller.setIsCompleted(isCompleted);
  }

  ///
  /// 向前一步
  ///
  void forwardStep() {
    if (controller.currentIndex < maxCount) {
      controller.setCurrentIndex(controller.currentIndex + 1);
    }
  }

  ///
  /// 向后一步
  ///
  void backStep() {
    int backIndex = controller.currentIndex <= 0 ? 0 : controller.currentIndex - 1;
    controller.setCurrentIndex(backIndex);
  }
}

// ignore: must_be_immutable
class BrnHorizontalSteps extends StatefulWidget {
  /// The steps of the stepper whose titles, subtitles, icons always get shown.
  ///
  /// The length of [steps] must not change.
  final List<BrunoStep> steps;

  BrnStepsController controller;

  final Widget doingIcon;
  final Widget completedIcon;

  BrnHorizontalSteps({this.steps, this.controller, this.doingIcon, this.completedIcon})
      : assert(steps.length < 6);

  @override
  State<StatefulWidget> createState() {
    return BrnHorizontalStepsState();
  }
}

class BrnHorizontalStepsState extends State<BrnHorizontalSteps> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_handleStepStateListenerTick);
  }

  void _handleStepStateListenerTick() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(_handleStepStateListenerTick);
  }

  @override
  Widget build(BuildContext context) {
    return _buildHorizontalSteps();
  }

  Widget _buildHorizontalSteps() {
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    final List<Widget> childrenList = <Widget>[];
    for (int i = 0; i < widget.steps.length; i += 1) {
      childrenList.add(_applyStepItem(widget.steps[i], i));
      if (i < widget.steps.length - 1) {
        childrenList.add(_applyLineItem(i));
      }
    }
    content = Container(
      height: 78,
      padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: childrenList,
      ),
    );
    return content;
  }

  Widget _applyStepIcon(BrunoStep step, int index) {
    Widget icon;
    if (widget.controller.isCompleted) {
      return _getCompletedIcon(step);
    }
    if (step.state != null) {
      switch (step.state) {
        case BrunoStepState.indexed:
          icon = getIndexIcon(index);
          break;
        case BrunoStepState.complete:
          icon = _getCompletedIcon(step);
          break;
        case BrunoStepState.doing:
          icon = _getDoingIcon(step);
          break;
        default:
          icon = _getDoingIcon(step);
          break;
      }
    } else {
      int currentIndex = widget.controller.currentIndex;
      if (index < currentIndex) {
        // 当前index小于指定的活跃index
        icon = _getCompletedIcon(step);
      } else if (index == currentIndex) {
        icon = _getDoingIcon(step);
      } else if (index > currentIndex) {
        icon = getIndexIcon(index);
      }
    }
    return icon;
  }

  Widget _applyStepItem(BrunoStep step, int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _applyStepIcon(step, index),
          _applyStepContent(step, index),
        ],
      ),
    );
  }

  Widget _applyLineItem(int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 28),
        color: index >= widget.controller.currentIndex
            ? Color(0xFFE7E7E7)
            : BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary,
        height: 1,
      ),
    );
  }

  Widget getIndexIcon(int index) {
    Widget icon;
    switch (index) {
      case 1:
        icon = BrunoTools.getAssetSizeImage(BrnAsset.ICON_STEP_2, 20, 20);
        break;
      case 2:
        icon = BrunoTools.getAssetSizeImage(BrnAsset.ICON_STEP_3, 20, 20);
        break;
      case 3:
        icon = BrunoTools.getAssetSizeImage(BrnAsset.ICON_STEP_4, 20, 20);
        break;
      case 4:
        icon = BrunoTools.getAssetSizeImage(BrnAsset.ICON_STEP_5, 20, 20);
        break;
      default:
        icon = BrunoTools.getAssetSizeImage(BrnAsset.ICON_STEP_DOING, 20, 20);
        break;
    }
    return icon;
  }

  _applyStepContent(BrunoStep step, int index) {
    if (step.stepContent != null) {
      return step.stepContent;
    }
    return Container(
        margin: EdgeInsets.only(top: 6),
        child: Text(
          step.stepContentText,
          style: TextStyle(
            fontSize: 14,
            color: index > widget.controller.currentIndex ? Color(0xFFCCCCCC) : Color(0xFF222222),
          ),
        ));
  }

  Widget _getCompletedIcon(BrunoStep step) {
    if (step.completedIcon != null) {
      // 如果Step中自定义completedIcon不为空，则使用自定义的icon
      return step.completedIcon;
    }
    if (widget.completedIcon != null) {
      // 如果自定义completedIcon不为空，则使用自定义的icon
      return widget.completedIcon;
    }
    // 使用组件默认的icon
    return BrunoTools.getAssetSizeImage(BrnAsset.ICON_STEP_COMPLETED, 20, 20,
        color: BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary);
  }

  Widget _getDoingIcon(BrunoStep step) {
    if (step.doingIcon != null) {
      // 如果Step中自定义doingIcon不为空，则使用自定义的icon
      return step.doingIcon;
    }
    if (widget.doingIcon != null) {
      // 如果自定义doingIcon不为空，则使用自定义的icon
      return widget.doingIcon;
    }
    // 使用组件默认的icon
    return BrunoTools.getAssetSizeImage(BrnAsset.ICON_STEP_DOING, 20, 20,
        color: BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary);
  }
}

enum BrunoStepState {
  /// A step that displays its index in its circle.
  indexed,

  /// A step that displays a doing icon in its circle.
  doing,

  /// A step that displays a completed icon in its circle.
  complete
}

@immutable
class BrunoStep {
  /// Creates a step for a [Stepper].
  ///
  /// The [stepContent], [doingIcon] arguments must not be null.
  const BrunoStep({
    this.stepContent,
    this.stepContentText,
    this.doingIcon,
    this.completedIcon,
    this.state,
  });

  /// The String title of the step that typically describes it.
  final String stepContentText;

  /// The title of the step that typically describes it.
  final Widget stepContent;

  /// The doingIcon of the step
  final Widget doingIcon;

  /// The completedIcon of the step
  final Widget completedIcon;

  /// The state of the step which determines the styling of its components
  /// and whether steps are interactive.
  final BrunoStepState state;
}

class BrnStepsController with ChangeNotifier {
  int currentIndex = 0;
  bool isCompleted = false;

  BrnStepsController({this.currentIndex, this.isCompleted});

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void setIsCompleted(bool isCompleted) {
    this.isCompleted = isCompleted;
    notifyListeners();
  }
}
