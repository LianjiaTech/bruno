

import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class DoughnutChartExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DoughnutChartExampleState();
  }
}

class DoughnutChartExampleState extends State<DoughnutChartExample> {
  BrnDoughnutDataItem? selectedItem;

  List<BrnDoughnutDataItem> dataList = [];
  List<Color> preinstallColors = [
    Color(0xffFF862D),
    Color(0xff26BB7D),
    Color(0xffFFDD00),
    Color(0xff6AA6FB),
    Color(0xff0984F9),
  ];
  int count = 5;

  void initState() {
    super.initState();
    for (int i = 0; i < count; i++) {
      dataList.add(BrnDoughnutDataItem(
          title: '示例',
          value: random(1, 5).toDouble(),
          color: getColorWithIndex(i)));
    }
  }

  int random(int min, int max) {
    final _random = Random();
    return min + _random.nextInt(max - min + 1);
  }

  Color getColorWithIndex(int index) {
    return this.preinstallColors[index % this.preinstallColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '数据展示',
      ),
      body: Column(
        children: <Widget>[
          BrnDoughnutChart(
            padding: EdgeInsets.all(50),
            width: 200,
            height: 200,
            data: dataList,
            selectedItem: selectedItem,
            showTitleWhenSelected: true,
            selectCallback: (BrnDoughnutDataItem? selectedItem) {
              setState(() {
                this.selectedItem = selectedItem;
              });
            },
          ),
          DoughnutChartLegend(
              data: this.dataList,
              legendStyle: BrnDoughnutChartLegendStyle.wrap),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('数据个数'),
              ),
              Expanded(
                child: Slider(
                    value: count.toDouble(),
                    divisions: 10,
                    onChanged: (data) {
                      setState(() {
                        this.count = data.toInt();
                        dataList.clear();
                        for (int i = 0; i < count; i++) {
                          dataList.add(BrnDoughnutDataItem(
                              title: '示例',
                              value: random(1, 5).toDouble(),
                              color: getColorWithIndex(i)));
                        }
                      });
                    },
                    onChangeStart: (data) {},
                    onChangeEnd: (data) {},
                    min: 1,
                    max: 10,
                    label: '$count',
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()}}';
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
