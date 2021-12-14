// @dart=2.9

class BrnMultiClickUtils {
  static DateTime _lastClickTime;

  static bool isMultiClick({int intervalMilliseconds}) {
    if (_lastClickTime == null ||
        DateTime.now().difference(_lastClickTime) >
            Duration(milliseconds: intervalMilliseconds ?? 500)) {
      _lastClickTime = DateTime.now();
      return false;
    }
    return true;
  }
}
