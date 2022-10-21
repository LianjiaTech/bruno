import 'package:bruno/bruno.dart';

class ExpendMultiSelectBottomPickerItem extends BrnMultiSelectBottomPickerItem {
  final String? attribute1;
  final String? attribute2;
  final String? attribute3;
  String code; //选项编号
  String content; //选项内容
  bool isChecked; //是否选中

  ExpendMultiSelectBottomPickerItem(
    this.code,
    this.content, {
    this.attribute1,
    this.attribute2,
    this.attribute3,
    this.isChecked = false,
  }) : super(code, content, isChecked: isChecked);
}