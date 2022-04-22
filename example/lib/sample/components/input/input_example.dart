

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class TextModel {
  String? text;
}

class BrnInputTextExample extends StatefulWidget {
  BrnInputTextExample();

  @override
  State<StatefulWidget> createState() {
    return _BrnInputTextExampleState();
  }
}

class _BrnInputTextExampleState extends State<BrnInputTextExample> {
  TextModel model = TextModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: 'input动态算高',
        ),
        body: Container(
          color: Colors.white,
          child: Column(children: [
            _inputText(),
            SizedBox(
              height: 20,
            ),
          ]),
        ));
  }

  Widget _inputText() {
    return BrnInputText(
      maxHeight: 200,
      minHeight: 30,
      minLines: 1,
      maxLength: 10,
      bgColor: Colors.grey[200]!,
      textString: model.text ?? '',
      textInputAction: TextInputAction.newline,
      maxHintLines: 20,
      hint: 'input动态算高input动态算高input动态算高input动态算高input动态算高',
      padding: EdgeInsets.fromLTRB(20, 10, 20, 14),
      onTextChange: (text) {
        print(text);
        model.text = text;
        setState(() {});
      },
      onSubmit: (text) {
        print(text);
      },
    );
  }
}
