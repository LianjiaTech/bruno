import 'package:bruno/bruno.dart';

///  退回订单 页面展示
import 'package:flutter/material.dart';

class FormPageExample extends StatefulWidget {
  @override
  _FormPageExampleState createState() => _FormPageExampleState();
}

class _FormPageExampleState extends State<FormPageExample> {
  List<String> selectedOptions = List();
  String commentStr;
  BrnPortraitRadioGroupOption selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      resizeToAvoidBottomInset: true,
      appBar: BrnAppBar(
        title: '退回订单',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BrnExpandableGroup(
                      title: "无法服务",
                      children: [
                        BrnPortraitRadioGroup.withSimpleList(
                          options: [
                            '$index 用户报修项错误',
                            '$index 有同时段其他地址订单',
                            '$index 不在我服务范围',
                            '$index 其他'
                          ],
                          selectedOption: selectedValue?.title,
                          onChanged: (BrnPortraitRadioGroupOption old,
                              BrnPortraitRadioGroupOption newList) {
                            BrnToast.show(newList.title, context);
                            selectedValue = newList;
                            commentStr = '';
                            setState(() {});
                          },
                        ),
                        BrnTextBlockInputFormItem(
                          title: '备注',
                          hint: '请输入备注信息',
                          maxCharCount: 100,
                          onChanged: (String newStr) {
                            commentStr = newStr;
                          },
                        ),
                        BrnPortraitRadioGroup.withOptions(
                          isCollapseContent: false,
                          options: List.generate(3, (index) {
                            return BrnPortraitRadioGroupOption(
                                title:
                                    '$index esubtn你好  哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈 子标题esubtn你好  哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈 子标题',
                                subTitle: 'subtitlesubtn你好  哈哈哈哈哈哈啊哈哈哈哈哈子标题哈哈哈 子标题子标题');
                          }),
                          selectedOption: selectedValue,
                          onChanged: (BrnPortraitRadioGroupOption old,
                              BrnPortraitRadioGroupOption newList) {
                            BrnToast.show(newList.title, context);
                            selectedValue = newList;
                            commentStr = '';
                            setState(() {});
                          },
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return BrnLine();
                  },
                  itemCount: 5),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BrnBottomButtonPanel(
                mainButtonName: '确认',
                mainButtonOnTap: () {
                  BrnToast.show(
                      '原因：' + selectedOptions.toString() + '\n备注：' + (commentStr ?? ''), context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
