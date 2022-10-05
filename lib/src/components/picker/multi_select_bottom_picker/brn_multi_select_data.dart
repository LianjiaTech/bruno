class BrnMultiSelectBottomPickerItem<T> {
  String code; //选项编号

  String content; //选项内容

  bool isChecked; //是否选中

  T? data; // 选中的数据源

  BrnMultiSelectBottomPickerItem(
    this.code,
    this.content, {
    this.isChecked: false,
    this.data,
  });
}
