

import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/picker/cutomer_bottom_picker_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'date_picker_example.dart';
import 'expend_multi_item.dart';
import 'multi_picker_example.dart';

class PickerEntryPage extends StatelessWidget {
  final String _title;
  final List<BrnPickerEntity> dataList = [];

  PickerEntryPage(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: _title,
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              title: "MultiDataPicker",
              isSupportTheme: true,
              isShowLine: false,
              describe: '底部多级选择',
              onPressed: () {
                _showMultiDataPicker(context);
              },
            ),
            ListItem(
              title: "DatePicker",
              isSupportTheme: true,
              describe: '日期选择控件',
              onPressed: () {
                _showDatePicker(context);
              },
            ),
            ListItem(
              title: "BottomWriteDialog",
              describe: 'Picker/文字录入  底部输入弹框',
              onPressed: () {
                _showBottomWriteDialog(context);
              },
            ),
            ListItem(
              title: "Picker/多选/勾选（MultiSelectBottomPicker）",
              describe: '底部多选弹框',
              onPressed: () {
                _showBottomMultiSelectPicker(context);
              },
            ),
            ListItem(
              title: "Picker/多选/勾选（MultiSelectBottomPicker）",
              describe: '底部多选弹框(自定义数据协议)',
              onPressed: () {
                _showExpandBottomMultiSelectPicker(context);
              },
            ),
            ListItem(
              title: "Picker/多选/勾选（MultiSelectBottomPicker）",
              describe: '底部多选弹框(实现限制选择个数)',
              onPressed: () {
                _showCountLimitBottomMultiSelectPicker(context);
              },
            ),
            ListItem(
              title: "Picker/多选/点选（BrnMultiSelectTagsPicker）",
              describe: "底部多选弹框",
              onPressed: () {
                _showMulSelectTagPicker(context);
              },
            ),
            ListItem(
              title: "Picker/多选/点选（BrnSelectTagsWithInputPicker）",
              describe: "底部多选弹框带输入框",
              onPressed: () {
                _showSelectTagsWithTextInputPicker(context);
              },
            ),
            ListItem(
              title: "Picker 级联选择",
              describe: "底部级联选择框",
              onPressed: () {
                rootBundle.loadString('assets/list_picker.json').then((data) {
                  List<BrnPickerEntity> _selectionData = []..addAll(
                      (JsonDecoder().convert(data)["data"]['list'] as List? ??
                              [])
                          .map((o) => BrnPickerEntity.fromMap(o)));
                  if (_selectionData.length > 0) {
                    _selectionData.forEach((f) => f.configChild());
                    if (dataList.length == 0) {
                      dataList.addAll(_selectionData);
                    }
                    _showRangePicker(context, dataList);
                  }
                });
              },
            ),
            ListItem(
              title: "Picker 级联选择",
              describe: "底部级联选择框（Title 动态改变）",
              onPressed: () {
                rootBundle.loadString('assets/list_picker.json').then((data) {
                  List<BrnPickerEntity> _selectionData = []..addAll(
                      (JsonDecoder().convert(data)["data"]['list'] as List? ??
                              [])
                          .map((o) => BrnPickerEntity.fromMap(o)));
                  if (_selectionData.length > 0) {
                    _selectionData.forEach((f) => f.configChild());
                    if (dataList.length == 0) {
                      dataList.addAll(_selectionData);
                    }
                    _showRangePicker1(context, dataList);
                  }
                });
              },
            ),
            ListItem(
              title: "自定义底部弹窗Picker",
              describe: "支持自定义内容",
              isSupportTheme: true,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CustomPickerExamplePage();
                  },
                ));
              },
            ),
          ],
        ));
  }

  ///多选弹框
  void _showBottomMultiSelectPicker(BuildContext context) {
    List<BrnMultiSelectBottomPickerItem> items = [];
    items.add(new BrnMultiSelectBottomPickerItem("100", "这里是标题1"));
    items.add(new BrnMultiSelectBottomPickerItem("101", "这里是标题2"));
    items.add(
        new BrnMultiSelectBottomPickerItem("102", "这里是标题3", isChecked: true));
    items.add(
        new BrnMultiSelectBottomPickerItem("103", "这里是标题4", isChecked: true));
    items.add(new BrnMultiSelectBottomPickerItem("104", "这里是标题5"));
    items.add(new BrnMultiSelectBottomPickerItem("104", "这里是标题6"));
    BrnMultiSelectListPicker.show(
      context,
      items: items,
      pickerTitleConfig: BrnPickerTitleConfig(titleContent: "多选 Picker"),
      onSubmit: (List<BrnMultiSelectBottomPickerItem> data) {
        var str = "";
        data.forEach((item) {
          str = str + item.content + "  ";
        });
        BrnToast.show(str, context);
        Navigator.of(context).pop();
      },
    );
  }

  ///多选弹框自定义数据协议
  void _showExpandBottomMultiSelectPicker(BuildContext context) {
    List<ExpendMultiSelectBottomPickerItem> items = [];
    items.add(new ExpendMultiSelectBottomPickerItem("100", "这里是标题1",attribute1: "第一条自定义参数1"));
    items.add(new ExpendMultiSelectBottomPickerItem("101", "这里是标题2",attribute1: "第二条自定义参数2"));
    items.add(
        new ExpendMultiSelectBottomPickerItem("102", "这里是标题3", isChecked: true,attribute1: "第三条自定义参数3"));
    items.add(
        new ExpendMultiSelectBottomPickerItem("103", "这里是标题4", isChecked: true));
    items.add(new ExpendMultiSelectBottomPickerItem("104", "这里是标题5"));
    items.add(new ExpendMultiSelectBottomPickerItem("104", "这里是标题6"));
    BrnMultiSelectListPicker.show<ExpendMultiSelectBottomPickerItem>(
      context,
      items: items,
      pickerTitleConfig: BrnPickerTitleConfig(titleContent: "多选 Picker"),
      onSubmit: (List<ExpendMultiSelectBottomPickerItem> data) {
        var str = "";
        data.forEach((item) {
          String attribute = item.attribute1 ?? "";
          str = str + attribute;
        });
        BrnToast.show(str, context);
        Navigator.of(context).pop();
      },
    );
  }

  /// 实现限制选择数量的情况
  void _showCountLimitBottomMultiSelectPicker(BuildContext context) {
    List<BrnMultiSelectBottomPickerItem> items = [];
    items.add(new BrnMultiSelectBottomPickerItem("100", "这里是标题1"));
    items.add(new BrnMultiSelectBottomPickerItem("101", "这里是标题2"));
    items.add(
        new BrnMultiSelectBottomPickerItem("102", "这里是标题3", isChecked: true));
    items.add(
        new BrnMultiSelectBottomPickerItem("103", "这里是标题4", isChecked: true));
    items.add(new BrnMultiSelectBottomPickerItem("104", "这里是标题5"));
    items.add(new BrnMultiSelectBottomPickerItem("104", "这里是标题6"));
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(builder: (_, setState) {
          return BrnMultiSelectListPicker(
            pickerTitleConfig: BrnPickerTitleConfig(titleContent: "多选 Picker"),
            items: items,
            onItemClick: (_, index) {
              if (items.where((element) => element.isChecked).length > 3) {
                BrnToast.show("选择数目超过了 3 个", context);
                items[index].isChecked = false;
                setState(() {});
              }
            },
            onSubmit: (List<BrnMultiSelectBottomPickerItem> data) {
              var str = "";
              data.forEach((item) {
                str = str + item.content + "  ";
              });
              BrnToast.show(str, context);
              Navigator.of(context).pop();
            },
            onCancel: () {
              BrnToast.show('自定义 cancel 回调', context);
            },
          );
        });
      },
    );
  }

  ///底部有输入框弹框
  void _showBottomWriteDialog(BuildContext context) {
    BrnBottomWritePicker.show(
      context,
      title: '这里是标题',
      hintText: '请输入',
      cancelDismiss: true,
      confirmDismiss: false,
      onConfirm: (context, string) {
        BrnToast.show(string ?? '', context);
        return;
      },
      onCancel: (_) {
        Navigator.of(context).pop();
        return;
      },
      defaultText: "",
    );
  }

  void _showRangePicker(
      BuildContext context, List<BrnPickerEntity> _selectionData) {
    _selectionData.forEach((f) => f.configChild());
    var selectionMenuView = BrnMultiColumnPicker(
      entity: _selectionData[3],
      defaultFocusedIndexes: [0, -1, -1],
      onConfirm: (Map<String, List<BrnPickerEntity>> result, int? firstIndex,
          int? secondIndex, int? thirdIndex) {
        List<String> pickResult = [];
        result.forEach((key, val) {
          List<String> tmp = [];
          val.forEach((item) {
            tmp.add(item.name);
          });
          pickResult.add(tmp.toString());
        });
        BrnToast.show(pickResult.toString(), context);
      },
      onEntityTap: (int columnIndex, int rowIndex, BrnPickerEntity entity) {
        BrnToast.show('$columnIndex + $rowIndex + ${entity.name}', context);
      },
    );
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext dialogContext) {
        return selectionMenuView;
      },
    );
  }

  void _showRangePicker1(
      BuildContext context, List<BrnPickerEntity> _selectionData) {
    _selectionData.forEach((f) => f.configChild());
    String titleName = "测试标题";
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(builder: (context, setState) {
        return BrnMultiColumnPicker(
          pickerTitleConfig: BrnPickerTitleConfig(titleContent: titleName),
          entity: _selectionData[3],
          defaultFocusedIndexes: [0, -1, -1],
          onConfirm: (Map<String, List<BrnPickerEntity>> result,
              int? firstIndex, int? secondIndex, int? thirdIndex) {
            List<String> pickResult = [];
            result.forEach((key, val) {
              List<String> tmp = [];
              val.forEach((item) {
                tmp.add(item.name);
              });
              pickResult.add(tmp.toString());
            });
            BrnToast.show(pickResult.toString(), context);
          },
          onEntityTap: (int columnIndex, int rowIndex, BrnPickerEntity entity) {
            titleName = entity.name;
            setState(() {});
            BrnToast.show('$columnIndex + $rowIndex + ${entity.name}', context);
          },
        );
      }),
    );
  }

  ///标签选择弹框
  void _showMulSelectTagPicker(BuildContext context) {
    List tags = [
      '洗衣机池',
      '机池',
      '电冰池',
      '双人床池',
      '电茶池池',
      '洗手池池',
      '电池',
      '洗手池',
      '挖掘池机',
      '抽风机池',
      '可爱多池',
    ];

    List<BrnTagItemBean> items = [];
    for (int i = 0; i < tags.length; i++) {
      String it = tags[i];
      BrnTagItemBean item = BrnTagItemBean(name: it, code: it, index: i);
      items.add(item);
    }

    BrnMultiSelectTagsPicker(
      context: context,
      //排列样式 默认 平均分配排序
      layoutStyle: BrnMultiSelectTagsLayoutStyle.average,
      //一行多少个 默认4个
      crossAxisCount: 4,
      //最大选中数目 - 不设置 或者设置为0 则可以全选
      maxSelectItemCount: 5,
      onItemClick: (BrnTagItemBean onTapTag, bool isSelect) {
        BrnToast.show(onTapTag.toString(), context);
      },
      onMaxSelectClick: () {
        BrnToast.show('最大数值不能超过5个', context);
      },
      pickerTitleConfig: BrnPickerTitleConfig(
        titleContent: '多选标题',
      ),
      tagPickerConfig: BrnTagsPickerConfig(
        tagItemSource: items,
        tagTitleFontSize: 12,
        chipPadding: EdgeInsets.only(left: 5, right: 5),
        tagTitleColor: Color(0xFF666666),
        tagBackgroudColor: Color(0xffF8F8F8),
        selectedTagBackgroudColor: Color(0x140984F9),
        selectedTagTitleColor: Color(0xFF0984F9),
      ),
      onConfirm: (value) {
        BrnToast.show(value.toString(), context);
      },
      onCancel: () {
        BrnToast.show('点击了取消按钮', context);
      },
      onTagValueGetter: (choice) {
        return choice.name;
      },
    ).show();
  }

  ///标签选择弹框
  void _showSelectTagsWithTextInputPicker(BuildContext context) {
    List tags = [
      '我',
      '我是可选择',
      '我是可选择的标签',
      '我是文案特别长独自占一行的样式哦',
      '我是可选择的标签1',
      '我是可选择的标签1',
      '我是可选择的标签1',
    ];

    List<BrnTagInputItemBean> items = [];
    for (int i = 0; i < tags.length; i++) {
      String it = tags[i];
      BrnTagInputItemBean item =
          BrnTagInputItemBean(name: it, index: i, needExpend: (i % 2 == 0));
      items.add(item);
    }

    showDialog(
        context: context,
        builder: (_) => BrnSelectTagsWithInputPicker(
              title: '这里是标题文字',
              hintText: '请输入',
              confirm: (context, selectedTags, string) {
                Navigator.of(context).pop();
                return;
              },
              defaultText: "",
              tagPickerConfig: BrnTagsInputPickerConfig(
                tagItemSource: items,
                tagTitleFontSize: 12,
                tagTitleColor: Color(0xff222222),
                tagBackgroundColor: Color(0xffF8F8F8),
                selectedTagBackgroundColor: Color(0x140984F9),
                selectedTagTitleColor: Color(0xFF0984F9),
              ),
              onTagValueGetter: (choice) {
                return choice.name;
              },
            ));
  }

  ///底部多级弹框
  void _showMultiDataPicker(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return MultiPickerExamplePage();
      },
    ));
  }

  ///日期选择控件
  void _showDatePicker(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return DatePickerExamplePage('日期选择示例');
      },
    ));
  }
}
