import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// 评价组件example

class AppraiseExample extends StatefulWidget {
  @override
  _AppraiseExampleState createState() => _AppraiseExampleState();
}

class _AppraiseExampleState extends State<AppraiseExample> {
  List<String> tags = [
    '我',
    '我是可选择',
    '我是可选择的标签',
    '我是文案特别长独自占一行的样式哦',
    '我是可选择的标签1',
    '我是可选择的标签1',
    '我是可选择的标签1',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '评价组件',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
              Container(
                color: Color(0x260984F9),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '支持页面和弹窗使用，页面里使用BrnAppraise, 弹窗使用BrnAppraiseBottomPicker，picker对widget做了一层封装，两者参数完全一致',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '显示在页面内部',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              Text(
                '说明：显示在页面里时，需要隐藏提交按钮，回调的话，调用config里面的inputChangeCallback，iconClickCallback和tagSelectCallback',
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                ),
              ),
              BrnAppraise(
                title: "这里是标题文字",
                headerType: BrnAppraiseHeaderType.center,
                type: BrnAppraiseType.star,
                tags: tags,
                inputHintText: '这里是文本输入的组件',
                iconDescriptions: [
                  '一星',
                  '二星',
                  '三星',
                  '四星',
                  '五星',
                ],
                config: BrnAppraiseConfig(
                    showConfirmButton: false,
                    starAppraiseHint: '星星未选择时的文案',
                    inputDefaultText: '这是一段默认文字',
                    inputTextChangeCallback: (input) {
                      BrnToast.show('输入的内容为' + input, context);
                    },
                    iconClickCallback: (index) {
                      BrnToast.show('选中的评价为$index', context);
                    },
                    tagSelectCallback: (list) {
                      BrnToast.show('选中的标签为:' + list.toString(), context);
                    }),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                '显示弹窗',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                ),
              ),
              Text(
                '--说明：默认样式',
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BrnSmallMainButton(
                title: '点击显示默认样式弹窗',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BrnAppraiseBottomPicker(
                          title: "这里是标题文字",
                          tags: tags,
                          inputHintText: '这里是文本输入的组件',
                          onConfirm: (index, list, input) {
                            showToast(index, list, input, context);
                            Navigator.pop(context);
                          },
                          config: BrnAppraiseConfig(
                              showConfirmButton: true,
                              count: 5,
                              starAppraiseHint: '星星未选择时的文案',
                              inputTextChangeCallback: (input) {
                                BrnToast.show('输入的内容为' + input, context);
                              },
                              iconClickCallback: (index) {
                                BrnToast.show('选中的评价为$index', context);
                              },
                              tagSelectCallback: (list) {
                                BrnToast.show(
                                    '选中的标签为:' + list.toString(), context);
                              }),
                        );
                      });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '--说明：显示3个表情弹窗,tags传空隐藏标签',
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BrnSmallMainButton(
                title: '点击显示评价弹窗',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BrnAppraiseBottomPicker(
                          title:
                              "这里是标题文字这里是标题文字这里是标题文字这里是标题文字这里是标题文字这里是标题文字这里是标题文字这里是标题文字",
                          inputHintText: '这里是文本输入的组件',
                          onConfirm: (index, list, input) {
                            showToast(index, list, input, context);
                            Navigator.pop(context);
                          },

                          ///必须传入5个字符串，没有的位置传''
                          type: BrnAppraiseType.emoji,
                          iconDescriptions: ['很差', '', '可以', '', '非常好'],
                          config: BrnAppraiseConfig(
                              indexes: [0, 2, 4], titleMaxLines: 3),
                        );
                      });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '--说明：显示4颗星，隐藏输入框',
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BrnSmallMainButton(
                title: '点击显示评价弹窗',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BrnAppraiseBottomPicker(
                          title: "这里是标题文字",
                          tags: tags,
                          onConfirm: (index, list, input) {
                            showToast(index, list, input, context);
                            Navigator.pop(context);
                          },
                          type: BrnAppraiseType.star,
                          iconDescriptions: ['很差', '不行', '可以', '好'],
                          config: BrnAppraiseConfig(
                              showTextInput: false,
                              count: 4,
                              starAppraiseHint: '请评价'),
                        );
                      });
                },
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(int index, List<String> selectedTags, String input,
      BuildContext context) {
    String str = '选中的评价为$index';
    if (selectedTags.isNotEmpty) {
      str = str + ',选中的标签为:' + selectedTags.toString();
    }
    if (input.isNotEmpty) {
      str = str + '，输入的内容为:' + input;
    }
    BrnToast.show(str, context);
  }
}
