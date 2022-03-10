/// 用于model兼容回调
/// 主要用于各种点击事件

typedef OnBrnFormSelectAll = void Function(int index, bool isSelect);

/// 主要用于各种输入值变化
typedef OnBrnFormRadioValueChanged = void Function(
    String? oldStr, String? newStr);
typedef OnBrnFormSwitchChanged = void Function(bool oldValue, bool newValue);
typedef OnBrnFormValueChanged = void Function(int oldValue, int newValue);
typedef OnBrnFormMultiChoiceValueChanged = void Function(
    List<String> oldValue, List<String> newValue);
typedef OnBrnFormBtnSelectChanged = void Function(
    List<bool> oldValue, List<bool> newValue);

/// 用于model兼容回调 定义等同于 form_interface
/// 主要用于各种点击事件
typedef OnBrnFormTitleSelected = void Function(String title, int index);
