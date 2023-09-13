
/// 防止多次点击工具类
class BrnMultiClickUtils {
  const BrnMultiClickUtils._();

  static DateTime? _lastClickTime;

  /// 判断是否是多次点击
  /// [intervalMilliseconds] 间隔时间，单位毫秒，默认500毫秒
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
