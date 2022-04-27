import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BrnMetaSwitchExample extends StatefulWidget {
  @override
  _BrnMetaSwitchExampleState createState() => _BrnMetaSwitchExampleState();
}

class _BrnMetaSwitchExampleState extends State<BrnMetaSwitchExample> {
  bool value1 = true;
  bool value2 = true;
  bool value3 = false;
  bool value5 = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '开关元件',
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
            BrnBubbleText(maxLines: 2, text: '具备选中、未选中、以及禁用状态'),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BrnMetaSwitch(
                value: value1,
                onChanged: (value) {
                  setState(() {
                    value1 = value;
                  });
                },
              ),
            ),
            Text(
              '禁用案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BrnMetaSwitch(
                enabled: false,
                value: value2,
                onChanged: (value) {
                  setState(() {
                    value2 = value;
                  });
                },
              ),
            ),
            Text(
              '未选案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BrnMetaSwitch(
                value: value3,
                onChanged: (value) {
                  setState(() {
                    value3 = value;
                  });
                },
              ),
            ),
            Text(
              '禁用案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BrnMetaSwitch(
                enabled: false,
                value: false,
                onChanged: (value) {},
              ),
            ),
            Text(
              '自定义大小',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BrnMetaSwitch(
                size: Size(80, 40),
                value: value5,
                onChanged: (value) {
                  setState(() {
                    value5 = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
