

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BrnTwoRichContentExample extends StatefulWidget {
  @override
  _BrnTwoRichContentExampleState createState() =>
      _BrnTwoRichContentExampleState();
}

class _BrnTwoRichContentExampleState extends State<BrnTwoRichContentExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '两列复杂文本',
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
            BrnBubbleText(
              maxLines: 4,
              text: '两组key-value内容平分屏幕，每一组key-value都是一行展示，'
                  'value紧挨着key，不考虑对齐',
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnRichInfoGrid(
              pairInfoList: <BrnRichGridInfo>[
                BrnRichGridInfo("名称：", '内容内容内容内容'),
                BrnRichGridInfo("名称：", '内容内容内容'),
                BrnRichGridInfo("名称：", '内容内容'),
                BrnRichGridInfo.valueLastClickInfo('名称', '内容内容',
                    keyQuestionCallback: (value) {
                  BrnToast.show(value, context);
                }),
                BrnRichGridInfo.valueLastClickInfo('名称', '内容内容',
                    valueQuestionCallback: (value) {
                  BrnToast.show(value, context);
                }),
                BrnRichGridInfo.valueLastClickInfo('名称', '内容内容',
                    valueQuestionCallback: (value) {
                      BrnToast.show(value, context);
                    },
                    clickTitle: "可点击内容",
                    clickCallback: (value) {
                      BrnToast.show(value, context);
                    }),
                BrnRichGridInfo.valueLastClickInfo('名称', '内容内容',
                    clickTitle: "可点击内容", clickCallback: (value) {
                  BrnToast.show(value, context);
                }),
              ],
            ),
            Text(
              '异常案例：key过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnRichInfoGrid(
              pairInfoList: <BrnRichGridInfo>[
                BrnRichGridInfo.valueLastClickInfo('名称名称名称名称名称名称名称', '内容内容',
                    keyQuestionCallback: (value) {
                  BrnToast.show(value, context);
                }),
                BrnRichGridInfo("名称：", '内容内容内容'),
                BrnRichGridInfo("名称：", '内容内容'),
                BrnRichGridInfo("名称：", '内容'),
              ],
            ),
            Text(
              '异常案例：内容过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnRichInfoGrid(
              pairInfoList: <BrnRichGridInfo>[
                BrnRichGridInfo.valueLastClickInfo(
                    '名称名称', '内容内容内容内容内容内容内容内容内容内容内容',
                    keyQuestionCallback: (value) {
                  BrnToast.show(value, context);
                }),
                BrnRichGridInfo("名称：", '内容内容内容内容内容内容内容内容内容内容内容'),
                BrnRichGridInfo("名称：", '内容内容'),
                BrnRichGridInfo("名称：", '内容'),
              ],
            ),
            Text(
              '异常案例：Key和Value过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnRichInfoGrid(
              pairInfoList: <BrnRichGridInfo>[
                BrnRichGridInfo("名称名称：", '内容内容内容内容'),
                BrnRichGridInfo.valueLastClickInfo(
                    "名称名称名称名称名称名称名称名称名称：", '内容内容内容内容内容内容内容内容内容内容内容'),
                BrnRichGridInfo("名称：", '内容内容'),
                BrnRichGridInfo("名称：", '内容'),
              ],
            ),
            Text(
              '异常案例：可点击内容过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnRichInfoGrid(
              pairInfoList: <BrnRichGridInfo>[
                BrnRichGridInfo("名称名称：", '内容内容内容内容'),
                BrnRichGridInfo.valueLastClickInfo("名称名称名", '内容内容内容',
                    clickTitle: '可点击内容可点击内容可点击内容',
                    valueQuestionCallback: (value) {
                  BrnToast.show(value, context);
                }),
                BrnRichGridInfo("名称：", '内容内容'),
                BrnRichGridInfo("名称：", '内容'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
