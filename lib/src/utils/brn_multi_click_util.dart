class BrnMultiClickUtils {
  static DateTime? _lastClickTime;

  static bool isMultiClick({int intervalMilliseconds = 500}) {
    if (_lastClickTime == null ||
        DateTime.now().difference(_lastClickTime!) >
            Duration(milliseconds: intervalMilliseconds)) {
      _lastClickTime = DateTime.now();
      return false;
    }
    return true;
  }
}
