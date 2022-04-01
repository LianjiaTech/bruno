

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class RadioExample extends StatefulWidget {
  @override
  _RadioExampleState createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  /// 单选选中的index
  int _singleSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '单选示例',
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
                  fontWeight: FontWeight.bold),
            ),
            BrnBubbleText(maxLines: 2, text: '具备选中、未选中、以及禁用状态,支持设置左右widget'),
            Text(
              '正常案例：单选，控件在选择按钮右边',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Text("选项："),
                BrnRadioButton(
                  radioIndex: 0,
                  isSelected: _singleSelectedIndex == 0,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "选项A",
                    ),
                  ),
                  onValueChangedAtIndex: (index, value) {
                    setState(() {
                      _singleSelectedIndex = index;
                      BrnToast.show("单选，选中第$index个", context);
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                BrnRadioButton(
                  radioIndex: 1,
                  isSelected: _singleSelectedIndex == 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "选项B",
                    ),
                  ),
                  onValueChangedAtIndex: (index, value) {
                    setState(() {
                      _singleSelectedIndex = index;
                      BrnToast.show("单选，选中第$index个", context);
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                BrnRadioButton(
                  radioIndex: 1,
                  disable: true,
                  isSelected: _singleSelectedIndex == 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "选项C",
                    ),
                  ),
                  onValueChangedAtIndex: (index, value) {
                    setState(() {
                      _singleSelectedIndex = index;
                      BrnToast.show("单选，选中第$index个", context);
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '单选，未选中，禁用',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnRadioButton(
              disable: true,
              radioIndex: 0,
              onValueChangedAtIndex: (index, value) {},
            ),
            Text(
              '单选,已选中，禁用',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnRadioButton(
              disable: true,
              radioIndex: 0,
              isSelected: true,
              onValueChangedAtIndex: (index, value) {},
            ),
          ],
        ),
      ),
    );
  }
}
