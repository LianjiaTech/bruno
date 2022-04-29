

import 'package:bruno/bruno.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

List<Map<String, List>> list1 = [
  {
    '一级1': ['AAA1', 'AAA2', 'AAA3', 'AAA4', 'AAA5', 'AAA6', 'AAA7', 'AAA8']
  },
  {
    '一级2': ['BBB1', 'BBB2', 'BBB3', 'BBB4', 'BBB5']
  },
  {
    '一级3': ['CCC1', 'CCC2', 'CCC3']
  },
  {
    '一级4': ['DDD1', 'DDD2', 'DDD3', 'DDD4']
  },
  {
    '一级5': ['EEE1', 'EEE2', 'EEE3']
  },
  {
    '一级6': ['FFF1']
  },
  {
    '一级7': ['GGG1']
  },
  {
    '一级8': ['HHH1']
  },
  {
    '一级9': ['III1', 'III2']
  }
];

List<Map<String, List>> list = [
  {
    'AAA': [
      {
        'AAA': ['8', '9']
      }
    ]
  },
  {
    'BBB': [
      {
        'BBB': ['5', '6']
      }
    ]
  },
  {
    'CCC': [
      {
        'CCC': ['3', '4']
      }
    ]
  },
  {
    'DDD': [
      {
        'DDD': ['1', '2']
      },
      {
        'DDD1': ['EEE1', 'EEE2']
      }
    ]
  }
];

class MultiPickerExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: '多列选择picker',
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              isShowLine: false,
              title: "单列",
              describe: '自定义单列Picker',
              onPressed: () {
                BrnMultiDataPicker(
                  context: context,
                  title: '来源',
                  delegate: Brn1RowDelegate(firstSelectedIndex: 1),
                  confirmClick: (list) {
                    BrnToast.show(list.toString(), context);
                  },
                ).show();
              },
            ),
            ListItem(
              title: "两列-有联动",
              describe: '自定义Picker',
              onPressed: () {
                BrnMultiDataPicker(
                  context: context,
                  title: '来源',
                  delegate: Brn2RowDelegate(
                      firstSelectedIndex: 1, secondSelectedIndex: 0),
                  confirmClick: (list) {
                    BrnToast.show(list.toString(), context);
                  },
                ).show();
              },
            ),
            ListItem(
              title: "两列-无联动",
              describe: '自定义Picker，两列直接无联动',
              onPressed: () {
                BrnMultiDataPicker(
                  sync: false,
                  context: context,
                  title: '来源',
                  delegate: Brn2RowCustomDelegate(
                      firstSelectedIndex: 1, secondSelectedIndex: 0),
                  confirmClick: (list) {
                    BrnToast.show(list.toString(), context);
                  },
                ).show();
              },
            ),
            ListItem(
              title: "三列-有联动",
              describe: '自定义三列Picker',
              onPressed: () {
                BrnMultiDataPicker(
                  context: context,
                  title: '来源',
                  delegate: Brn3RowDelegate(
                      firstSelectedIndex: 1,
                      secondSelectedIndex: 0,
                      thirdSelectedIndex: 0),
                  confirmClick: (list) {
                    BrnToast.show(list.toString(), context);
                  },
                ).show();
              },
            ),
            ListItem(
              title: "默认 Delegate",
              describe: '使用默认 Delegate 构造数据展示',
              onPressed: () {
                BrnMultiDataPicker(
                  context: context,
                  title: '来源',
                  delegate: BrnDefaultMultiDataPickerDelegate(
                      firstSelectedIndex: 2,
                      secondSelectedIndex: 1,
                      thirdSelectedIndex: 1,
                  data: _getDefaultDelegateData()),
                  confirmClick: (list) {
                    BrnToast.show(list.toString(), context);
                  },
                ).show();
              },
            ),
          ],
        ));
  }

  List<BrnMultiDataPickerEntity> _getDefaultDelegateData() {
    BrnMultiDataPickerEntity data = BrnMultiDataPickerEntity(
        text: '测试1', value: 5095791542795657, children: []);

    BrnMultiDataPickerEntity data2 = BrnMultiDataPickerEntity(
        text: '测试2', value: 5029051542795656, children: []);

    BrnMultiDataPickerEntity data3 = BrnMultiDataPickerEntity(
        text: '测试3', value: 5090501542795658, children: []);

    return [data, data2, data3];
  }
}

class Brn1RowDelegate implements BrnMultiDataPickerDelegate {
  int firstSelectedIndex = 0;
  int secondSelectedIndex = 0;
  int thirdSelectedIndex = 0;

  Brn1RowDelegate({this.firstSelectedIndex = 0, this.secondSelectedIndex = 0});

  @override
  int numberOfComponent() {
    return 1;
  }

  @override
  int numberOfRowsInComponent(int component) {
    if (0 == component) {
      return list.length;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      return secondMap.values.first.length;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first.length;
    }
  }

  @override
  String titleForRowInComponent(int component, int index) {
    if (0 == component) {
      return list[index].keys.first;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      List secondList = secondMap.values.first;
      return secondList[index].keys.first;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first[index];
    }
  }

  @override
  double? rowHeightForComponent(int component) {
    return null;
  }

  @override
  selectRowInComponent(int component, int row) {
    if (0 == component) {
      firstSelectedIndex = row;
    } else if (1 == component) {
      secondSelectedIndex = row;
    } else {
      thirdSelectedIndex = row;
      debugPrint('_thirdSelectedIndex  is selected to $thirdSelectedIndex');
    }
  }

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return firstSelectedIndex;
    }
    return 0;
  }
}

class Brn2RowDelegate implements BrnMultiDataPickerDelegate {
  int firstSelectedIndex = 0;
  int secondSelectedIndex = 0;
  int thirdSelectedIndex = 0;

  Brn2RowDelegate({this.firstSelectedIndex = 0, this.secondSelectedIndex = 0});

  @override
  int numberOfComponent() {
    return 2;
  }

  @override
  int numberOfRowsInComponent(int component) {
    if (0 == component) {
      return list.length;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      return secondMap.values.first.length;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first.length;
    }
  }

  @override
  String titleForRowInComponent(int component, int index) {
    if (0 == component) {
      return list[index].keys.first;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      List secondList = secondMap.values.first;
      return secondList[index].keys.first;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first[index];
    }
  }

  @override
  double? rowHeightForComponent(int component) {
    return null;
  }

  @override
  selectRowInComponent(int component, int row) {
    if (0 == component) {
      firstSelectedIndex = row;
    } else if (1 == component) {
      secondSelectedIndex = row;
    } else {
      thirdSelectedIndex = row;
      debugPrint('_thirdSelectedIndex  is selected to $thirdSelectedIndex');
    }
  }

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return firstSelectedIndex;
    } else if (1 == component) {
      return secondSelectedIndex;
    } else if (2 == component) {
      debugPrint('_thirdSelectedIndex  is selected to $thirdSelectedIndex');
      return thirdSelectedIndex;
    }
    return 0;
  }
}

class Brn3RowDelegate implements BrnMultiDataPickerDelegate {
  int firstSelectedIndex = 0;
  int secondSelectedIndex = 0;
  int thirdSelectedIndex = 0;

  Brn3RowDelegate({
    this.firstSelectedIndex = 0,
    this.secondSelectedIndex = 0,
    this.thirdSelectedIndex = 0,
  });

  @override
  int numberOfComponent() {
    return 3;
  }

  @override
  int numberOfRowsInComponent(int component) {
    if (0 == component) {
      return list.length;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      return secondMap.values.first.length;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first.length;
    }
  }

  @override
  String titleForRowInComponent(int component, int index) {
    if (0 == component) {
      return list[index].keys.first;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      List secondList = secondMap.values.first;
      //return secondList[index];
      return secondList[index].keys.first;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first[index];
    }
  }

  @override
  double? rowHeightForComponent(int component) {
    return null;
  }

  @override
  selectRowInComponent(int component, int row) {
    if (0 == component) {
      firstSelectedIndex = row;
    } else if (1 == component) {
      secondSelectedIndex = row;
    } else {
      thirdSelectedIndex = row;
      debugPrint('_thirdSelectedIndex  is selected to $thirdSelectedIndex');
    }
  }

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return firstSelectedIndex;
    } else if (1 == component) {
      return secondSelectedIndex;
    } else if (2 == component) {
      debugPrint('_thirdSelectedIndex  is selected to $thirdSelectedIndex');
      return thirdSelectedIndex;
    }
    return 0;
  }
}

class Brn2RowCustomDelegate implements BrnMultiDataPickerDelegate {
  int firstSelectedIndex = 0;
  int secondSelectedIndex = 0;

  Brn2RowCustomDelegate(
      {this.firstSelectedIndex = 0, this.secondSelectedIndex = 0});

  @override
  int numberOfComponent() {
    return 2;
  }

  @override
  int numberOfRowsInComponent(int component) {
    if (0 == component) {
      return list.length;
    } else {
      return list.length;
    }
  }

  @override
  String titleForRowInComponent(int component, int index) {
    if (0 == component) {
      return list[index].keys.first;
    } else {
      return list[index].keys.first;
    }
  }

  @override
  double? rowHeightForComponent(int component) {
    return null;
  }

  @override
  selectRowInComponent(int component, int row) {
    if (0 == component) {
      firstSelectedIndex = row;
    } else {
      secondSelectedIndex = row;
    }
  }

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return firstSelectedIndex;
    }
    return secondSelectedIndex;
  }
}
