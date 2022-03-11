import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BrnSelectionBottomButtonExample extends StatefulWidget {
  @override
  _BrnSelectionBottomButtonExampleState createState() =>
      _BrnSelectionBottomButtonExampleState();
}

class _BrnSelectionBottomButtonExampleState
    extends State<BrnSelectionBottomButtonExample> {
  BrnMultipleBottomController controller = BrnMultipleBottomController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '多选吸底按钮',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '规则',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBubbleText(
              maxLines: 3,
              text: '文字按钮最多两个：主按钮和次按钮，可以展示三种按钮的排列组合\n'
                  '主按钮和次按钮的宽度大小是 不固定的，随着icon按钮的多少而变化\n'
                  '上下padding：16，18。左右padding：20',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BrnMultipleBottomButton(
                  bottomController: controller,
                  onSelectAll: (state) {
                    BrnToast.show('全选状态为 : $state', context);
                  },
                  onSelectedButtonTap: selectedButtonOnTap,
                  hasArrow: true,
                  mainButton: '主要按钮',
                  subButton: '次要按钮',
                  onMainButtonTap: () {
                    controller.setState(selectedCount: 11);
                    BrnToast.show('已选数量置为 : 11', context);
                  },
                  onSubButtonTap: () {
                    controller.setState(selectedCount: 0);
                    BrnToast.show('已选数量置为 : 0', context);
                  },
                ),
                BrnMultipleBottomButton(
                  onSelectedButtonTap: selectedButtonOnTap,
                  hasArrow: true,
                  mainButton: '主要按钮',
                  onMainButtonTap: () {
                    BrnToast.show('主按钮点击', context);
                  },
                ),
                BrnMultipleBottomButton(
                  onSelectedButtonTap: selectedButtonOnTap,
                  hasArrow: false,
                  mainButton: '主要按钮',
                  onMainButtonTap: () {
                    BrnToast.show('主按钮点击', context);
                  },
                ),
                BrnMultipleBottomButton(
                  onSelectedButtonTap: selectedButtonOnTap,
                  hasArrow: false,
                  mainButton: '主要按钮',
                  onMainButtonTap: () {
                    BrnToast.show('主按钮点击', context);
                  },
                  subButton: '次要按钮',
                ),
                BrnMultipleBottomButton(
                  bottomController: BrnMultipleBottomController(
                      initMultiSelectState:
                          MultiSelectState(selectedCount: 99)),
                  onSelectedButtonTap: selectedButtonOnTap,
                  hasArrow: false,
                  mainButton: '主要按钮',
                  onMainButtonTap: () {
                    BrnToast.show('主按钮点击', context);
                  },
                  subButton: '次要按钮',
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void selectedButtonOnTap(BrnMultipleButtonArrowState state) {
    String info = "";
    switch (state) {
      case BrnMultipleButtonArrowState.unfold:
        info = '展开状态';
        break;
      case BrnMultipleButtonArrowState.cantUnfold:
        info = '无法展开状态';
        break;
      case BrnMultipleButtonArrowState.fold:
        info = '收起状态';
        break;
      case BrnMultipleButtonArrowState.defaultStatus:
        break;
    }
    BrnToast.show('已选择状态为 : $info', context);
  }
}
