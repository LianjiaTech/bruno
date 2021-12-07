part of brn_intro;

///  Throttling
///  Have method [throttle]
class _Throttling {
  Duration _duration;
  Timer _timer;

  _Throttling({Duration duration = const Duration(seconds: 1)})
      : assert(duration is Duration && !duration.isNegative) {
    _duration = duration;
  }

  void throttle(Function func) {
    if (_timer == null) {
      _timer = Timer(_duration, () {
        Function.apply(func, []);
        _timer = null;
      });
    }
  }
}
