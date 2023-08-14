/// 用于model兼容回调
/// 主要用于各种点击事件

typedef OnBrnFormSelectAll = void Function(int index, bool isSelect);

/// 主要用于各种输入值变化
typedef OnBrnFormRadioValueChanged = void Function(
    String? oldStr, String? newStr);

/// 开关变化回调
typedef OnBrnFormSwitchChanged = void Function(bool oldValue, bool newValue);

/// 星值数量变化回调
typedef OnBrnFormValueChanged = void Function(int oldValue, int newValue);

/// 选项选中状态变化回调
typedef OnBrnFormMultiChoiceValueChanged = void Function(
    List<String> oldValue, List<String> newValue);

/// 用于model兼容回调 定义等同于 form_interface
/// 主要用于各种点击事件
typedef OnBrnFormTitleSelected = void Function(String title, int index);
