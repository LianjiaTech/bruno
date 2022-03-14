import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BrnHorizontalStepExamplePage extends StatefulWidget {
  final String title;

  const BrnHorizontalStepExamplePage({Key? key, required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BrnHorizontalStepExamplePageState();
  }
}

class BrnHorizontalStepExamplePageState
    extends State<BrnHorizontalStepExamplePage> {
  late int _index;
  double sliderValue = 2;
  late BrnStepsController _controller;
  late ValueNotifier<double> valueNotifier;

  @override
  void initState() {
    super.initState();
    _index = 0;
    _controller = BrnStepsController(currentIndex: _index);
    valueNotifier = ValueNotifier(sliderValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(title: widget.title),
      body: Column(
        children: [
          SliverBrnHorizontalStep(
            controller: _controller,
            valueNotifier: valueNotifier,
          ),
          const Text('步骤个数：'),
          SliderWidget(
            initValue: sliderValue,
            valueNotifier: valueNotifier,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: const Text('上一步'),
                onPressed: () {
                  _controller.backStep();
                },
              ),
              ElevatedButton(
                child: const Text('下一步'),
                onPressed: () {
                  _controller.forwardStep();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: const Text('跳至第3步'),
                onPressed: () {
                  _controller.setCurrentIndex(2);
                },
              ),
              ElevatedButton(
                child: const Text('完成'),
                onPressed: () {
                  _controller.setCompleted();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 自定义 widget
class SliderWidget extends StatefulWidget {
  const SliderWidget({
    Key? key,
    required this.initValue,
    required this.valueNotifier,
  }) : super(key: key);
  final double initValue;
  final ValueNotifier<double> valueNotifier;

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late double sliderValue;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: sliderValue,
      min: 2,
      max: 5,
      divisions: 3,
      onChanged: (value) {
        setState(() {
          sliderValue = value;
          widget.valueNotifier.value = value;
        });
      },
    );
  }
}

/// 自定义 widget
class SliverBrnHorizontalStep extends StatefulWidget {
  const SliverBrnHorizontalStep({
    Key? key,
    required this.controller,
    required this.valueNotifier,
  }) : super(key: key);
  final BrnStepsController controller;
  final ValueNotifier<double> valueNotifier;

  @override
  _SliverBrnHorizontalStepsState createState() =>
      _SliverBrnHorizontalStepsState();
}

class _SliverBrnHorizontalStepsState extends State<SliverBrnHorizontalStep> {
  List<BrunoStep> brunoSteps() {
    final List<BrunoStep> _list = [];
    final int value = widget.valueNotifier.value.toInt();
    for (int i = 0; i < value; i++) {
      _list.add(BrunoStep(stepContentText: ('第你好11${i + 1}步')));
    }
    return _list;
  }

  void _onChange() {
    setState(() {
      brunoSteps();
      widget.controller.setCurrentIndex(0);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.valueNotifier.addListener(_onChange);
  }

  @override
  void dispose() {
    widget.valueNotifier.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BrnHorizontalSteps(
      steps: brunoSteps(),
      controller: widget.controller,
    );
  }
}
