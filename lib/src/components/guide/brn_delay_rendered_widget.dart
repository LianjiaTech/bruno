part of brn_intro;

/// 延时渲染一个 Widget
class _DelayRenderedWidget extends StatefulWidget {
  /// Sub-elements that need to fade in and out
  final Widget child;

  /// [child] Whether to continue rendering, that is, the animation will only be once
  final bool childPersist;

  /// Animation duration
  final Duration duration;

  /// [child] need to be removed (hidden)
  final bool removed;

  const _DelayRenderedWidget({
    Key? key,
    this.removed = false,
    this.duration = const Duration(milliseconds: 200),
    required this.child,
    this.childPersist = false,
  }) : super(key: key);

  @override
  _DelayRenderedWidgetState createState() => _DelayRenderedWidgetState();
}

class _DelayRenderedWidgetState extends State<_DelayRenderedWidget> {
  double opacity = 0;
  late Widget child;
  late Timer timer;

  /// Time interval between animations
  final Duration durationInterval = Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();
    child = widget.child;
    timer = Timer(durationInterval, () {
      if (mounted) {
        setState(() {
          opacity = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(_DelayRenderedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    var duration = widget.duration;
    if (widget.removed) {
      setState(() {
        opacity = 0;
      });
      return;
    }
    if (!identical(oldWidget.child, widget.child)) {
      if (widget.childPersist) {
        setState(() {
          child = widget.child;
        });
      } else {
        setState(() {
          opacity = 0;
        });
        Timer(
          Duration(
            milliseconds:
                duration.inMilliseconds + durationInterval.inMilliseconds,
          ),
          () {
            setState(() {
              child = widget.child;
              opacity = 1;
            });
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: widget.duration,
      child: child,
    );
  }
}
