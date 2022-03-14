

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class NumberItemRowExample extends StatefulWidget {
  @override
  _NumberItemRowExampleState createState() => _NumberItemRowExampleState();
}

class _NumberItemRowExampleState extends State<NumberItemRowExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '数字信息',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                text: '数字信息是特殊字体，前后可携带正常字体\n'
                    '特殊字体的样式为28号字，正常字体为12号字\n'
                    '上下间距是8',
              ),
              Text(
                '正常案例 只有一个Item',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnEnhanceNumberCard(
                itemChildren: [
                  BrnNumberInfoItemModel(
                    title: '数字信息',
                    number: '3',
                  ),
                ],
              ),
              Text(
                '正常案例',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnEnhanceNumberCard(
                itemChildren: [
                  BrnNumberInfoItemModel(
                      title: '数字信息',
                      number: '3',
                      preDesc: '前',
                      lastDesc: '后',
                      numberInfoIcon: BrnNumberInfoIcon.arrow,
                      iconTapCallBack: (data) {}),
                ],
              ),
              Text(
                '正常案例',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnEnhanceNumberCard(
                rowCount: 3,
                itemChildren: [
                  BrnNumberInfoItemModel(
                      title: '数字信息数息数字信息数字信息数息数字信息数字信息数息数字信息',
                      number: '3',
                      preDesc: '前',
                      lastDesc: '后',
                      numberInfoIcon: BrnNumberInfoIcon.arrow,
                      iconTapCallBack: (data) {
                        BrnToast.show(data.title!, context);
                      }),
                  BrnNumberInfoItemModel(
                    title: '数字信息数字信息数字信息数字信息数字信息数字信息',
                    number: '3',
                    preDesc: '前',
                    lastDesc: '后',
                  ),
                  BrnNumberInfoItemModel(
                    title: '数字信息数字信息数字信息数字信息数字信息数字信息',
                    number: '3',
                    preDesc: '前',
                    lastDesc: '后',
                  ),
                  BrnNumberInfoItemModel(
                      title: '数字信息',
                      number: '3',
                      preDesc: '前',
                      lastDesc: '后',
                      iconTapCallBack: (data) {}),
                  BrnNumberInfoItemModel(
                    title: '数字信息',
                    number: '3',
                    preDesc: '前',
                    lastDesc: '后',
                  ),
                ],
              ),
              Text(
                '正常案例',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnEnhanceNumberCard(
                rowCount: 3,
                itemChildren: [
                  BrnNumberInfoItemModel(
                    title: '数字信息',
                    number: '3',
                    preDesc: '前',
                    lastDesc: '后',
                  ),
                  BrnNumberInfoItemModel(
                    title: '数字信息',
                    number: '3',
                    preDesc: '前',
                    lastDesc: '后',
                  ),
                  BrnNumberInfoItemModel(
                    title: '数字信息',
                    number: '3',
                    preDesc: '前',
                    lastDesc: '后',
                  ),
                ],
              ),
              Text(
                'Pad 案例',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnEnhanceNumberCard(
                rowCount: 3,
                itemTextAlign: TextAlign.center,
                itemChildren: [
                  BrnNumberInfoItemModel(
                    title: 'itemTextAlign设置居中',
                    number: '1',
                  ),
                  BrnNumberInfoItemModel(
                    title: '可以设置左对齐',
                    number: '4',
                  ),
                  BrnNumberInfoItemModel(
                    title: '主题定制可去掉分割线',
                    number: '2',
                  ),
                  BrnNumberInfoItemModel(
                      title: '数字和描述文案字体都可配置', number: '3', lastDesc: '单位'),
                  BrnNumberInfoItemModel(
                    title: '上下间距可配置',
                    number: '5',
                  ),
                  BrnNumberInfoItemModel(
                      topWidget: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Container(
                            height: 26,
                            transform: Matrix4.translationValues(0, 1, 0),
                            child: Text('3',
                                style: TextStyle(
                                  height: 1.0,
                                  textBaseline: TextBaseline.ideographic,
                                  color: Color(0xFF222222),
                                  package: BrnStrings.flutterPackageName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 28,
                                  fontFamily: 'Bebas',
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              '室',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                textBaseline: TextBaseline.ideographic,
                                color: Color(0xFF222222),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            height: 26,
                            transform: Matrix4.translationValues(0, 1, 0),
                            child: Text('1',
                                style: TextStyle(
                                  height: 1.0,
                                  textBaseline: TextBaseline.ideographic,
                                  color: Color(0xFF222222),
                                  package: BrnStrings.flutterPackageName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28,
                                  fontFamily: 'Bebas',
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              '厅',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                textBaseline: TextBaseline.ideographic,
                                color: Color(0xFF222222),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      bottomWidget: Text(
                        "自定义底部",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF999999)),
                        overflow: TextOverflow.ellipsis,
                      )),
                  BrnNumberInfoItemModel(
                    title: '数字信息',
                    number: '3',
                    preDesc: '前',
                    lastDesc: '后',
                  ),
                ],
              ),
              Text(
                '异常案例 非数字',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnEnhanceNumberCard(
                itemChildren: [
                  BrnNumberInfoItemModel(
                    title: '数字信息',
                    number: '3我',
                    preDesc: '前',
                    lastDesc: '后',
                  ),
                ],
              ),
              Text(
                '异常案例 非数字',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnEnhanceNumberCard(
                itemChildren: [
                  BrnNumberInfoItemModel(
                    title: '数字信息',
                    number: '3A',
                    preDesc: '前',
                    lastDesc: '后',
                  ),
                ],
              ),
              Text(
                '异常案例',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              BrnEnhanceNumberCard(
                itemChildren: [
                  BrnNumberInfoItemModel(
                    title: '数字信息',
                    number: '3A',
                    preDesc: '前前',
                    lastDesc: '后后',
                  ),
                  BrnNumberInfoItemModel(
                    title: '数字信息',
                    number: '3A',
                    preDesc: '前',
                    lastDesc: '后后',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
