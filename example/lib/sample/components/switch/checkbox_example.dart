

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class CheckboxExample extends StatefulWidget {
  @override
  _CheckboxExampleState createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '多选示例',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '正常案例：多选，控件在选择按钮左边',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "选项：",
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 130,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return BrnCheckbox(
                    radioIndex: index,
                    disable: index == 2,
                    childOnRight: false,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "选项$index",
                      ),
                    ),
                    onValueChangedAtIndex: (index, value) {
                      if (value) {
                        BrnToast.show("第$index项被选中", context);
                      } else {
                        BrnToast.show("第$index项取消选中", context);
                      }
                    },
                  );
                },
              ),
            ),
            Text(
              '正常案例：多选, 居于屏幕两侧',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnCheckbox(
              radioIndex: 10,
              isSelected: true,
              childOnRight: true,
              mainAxisSize: MainAxisSize.max,
              child: Container(
                  width: 100,
                  height: 20,
                  color: Colors.lightBlue,
                  child: Center(
                      child: Text('自定义视图',
                          style: TextStyle(color: Colors.white)))),
              onValueChangedAtIndex: (index, value) {
                if (value) {
                  BrnToast.show("第$index项被选中", context);
                } else {
                  BrnToast.show("第$index项取消选中", context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
