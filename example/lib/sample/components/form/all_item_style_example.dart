import 'package:bruno/bruno.dart';
import 'package:example/sample/components/form/group_example/expansion_group_example.dart';
import 'package:example/sample/components/form/group_example/group_add_example.dart';
import 'package:example/sample/components/form/group_example/normal_group_example.dart';
import 'package:example/sample/components/form/items_example/base_title_example.dart';
import 'package:example/sample/components/form/items_example/multi_choice_example.dart';
import 'package:example/sample/components/form/items_example/multi_choice_protrait_example.dart';
import 'package:example/sample/components/form/items_example/radio_input_example.dart';
import 'package:example/sample/components/form/items_example/radio_protrait_example.dart';
import 'package:example/sample/components/form/items_example/range_input_example.dart';
import 'package:example/sample/components/form/items_example/ratio_input_example.dart';
import 'package:example/sample/components/form/items_example/select_all_title_example.dart';
import 'package:example/sample/components/form/items_example/star_example.dart';
import 'package:example/sample/components/form/items_example/step_input_example.dart';
import 'package:example/sample/components/form/items_example/switch_example.dart';
import 'package:example/sample/components/form/items_example/text_block_input_example.dart';
import 'package:example/sample/components/form/items_example/text_input_example.dart';
import 'package:example/sample/components/form/items_example/text_quick_select_input_example.dart';
import 'package:example/sample/components/form/items_example/text_select_example.dart';
import 'package:example/sample/components/form/items_example/title_example.dart';
import 'package:example/sample/components/form/items_example/title_select_example.dart';
import 'package:example/sample/components/form/items_example/general_item_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AllFormItemStyleExamplePage extends StatelessWidget {
  final String _title;
  bool hideAppBar = false;

  AllFormItemStyleExamplePage(this._title);

  @override
  Widget build(BuildContext context) {
    if (this.hideAppBar) {
      return this.getBodyWidget(context);
    }
    return Scaffold(
        appBar: BrnAppBar(
          title: _title,
        ),
        body: this.getBodyWidget(context));
  }

  Widget getBodyWidget(BuildContext context) {
    return ListView(
      children: <Widget>[

        ListItem(
          title: "基础类型 ",
          titleFontSize: 22,
          titleColor: Colors.red,
        ),
        ListItem(
          title: "基础标题表单项",
          describe: "基础类型",
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return BaseTitleExamplePage("标题表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "基础通用表单项",
          describe: "自定义基础表单",
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return GeneralFormExamplePage("自定义基础表单");
              },
            ));
          },
        ),
        ListItem(
          title: "选择类型",
          titleFontSize: 22,
          titleColor: Colors.red,
        ),
        ListItem(
          title: "文本选择表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return TextSelectInputExamplePage("文本选择表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "快速选择输入表单项",
          isSupportTheme: true,
          describe: "快速选择录入类型",
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return TextQuickSelectInputExamplePage("快速选择输入表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "文本输入类型: 5种",
          titleFontSize: 22,
          titleColor: Colors.red,
        ),
        ListItem(
          title: "文本输入表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return TextInputExamplePage("文本输入表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "块文本输入表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return TextBlockInputExamplePage("块文本输入表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "范围输入表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return RangeInputExamplePage("范围表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "比例输入表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return RatioInputExamplePage("比例输入表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "Title选择输入表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return TitleSelectInputExamplePage("Title选择表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "单选&多选类型: 4种",
          titleFontSize: 22,
          titleColor: Colors.red,
        ),
        ListItem(
          title: "横向单选选表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return RadioInputExamplePage("横向单选选表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "纵向单选选表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return RadioPortraitInputExamplePage("纵向单选表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "横向多选表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return MultiChoiceInputExamplePage("横向多选表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "纵向多选表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return MultiChoicePortraitInputExamplePage("纵向多选表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "其他类型: 6种",
          titleFontSize: 22,
          titleColor: Colors.red,
        ),
        ListItem(
          title: "标题表单项",
          describe: "杂项类型",
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return TitleExamplePage("标题表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "全选表单项",
          describe: "杂项类型",
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return SelectAllTitleExamplePage("全选表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "评星表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return StarInputExamplePage("评星表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "递增表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return StepInputExamplePage(title: "递增表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "Switch表单项",
          describe: '各种形态',
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return SwitchInputExamplePage("Switch表单项");
              },
            ));
          },
        ),
        ListItem(
          title: "组类型: 4种",
          titleFontSize: 22,
          titleColor: Colors.red,
        ),
        ListItem(
          title: "添加组表单项" "",
          describe: "组类型",
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return GroupAddExamplePage("添加组表单项" "");
              },
            ));
          },
        ),
        ListItem(
          title: "普通分组表单项" "",
          describe: "组类型",
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return NormalGroupExample("普通分组表单项" "");
              },
            ));
          },
        ),
        ListItem(
          title: "可展开收起分组表单项" "",
          describe: "组类型",
          isSupportTheme: true,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return ExpansionGroupExample("可展开收起分组表单项" "");
              },
            ));
          },
        )
      ],
    );
  }
}
