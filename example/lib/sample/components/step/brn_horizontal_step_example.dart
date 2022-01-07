// @dart=2.9

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BrnHorizontalStepExamplePage extends StatefulWidget {
  final String title;

  BrnHorizontalStepExamplePage({this.title});

  @override
  State<StatefulWidget> createState() {
    return BrnHorizontalStepExamplePageState();
  }
}

class BrnHorizontalStepExamplePageState extends State<BrnHorizontalStepExamplePage> {
  int _index;
  BrnHorizontalStepsManager _stepsManager = BrnHorizontalStepsManager();

  @override
  void initState() {
    _index = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: widget.title,
          actions: controlSteps(context),
        ),
        body: _stepsManager.buildSteps(currentIndex: _index, isCompleted: false, steps: <BrunoStep>[
          BrunoStep(
            stepContentText: "文案步骤",
          ),
          BrunoStep(
            stepContentText: "文案步骤",
          ),
          BrunoStep(
            stepContentText: "文案步骤",
          ),
          BrunoStep(
            stepContentText: "文案步骤",
          ),
        ]));
  }

  List<Widget> controlSteps(BuildContext context) {
    List<Widget> result = List<Widget>();

    result.add(BrnTextAction("上一步", iconPressed: () {
      _stepsManager.backStep();
    }));

    result.add(BrnTextAction("下一步", iconPressed: () {
      _stepsManager.forwardStep();
    }));
    return result;
  }
}
