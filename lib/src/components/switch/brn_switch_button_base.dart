import 'package:flutter/material.dart';

const double _borderWidth = 1.5;

class BrnMetaBaseSwitch extends StatelessWidget {
  final Size? size;

  /// Whether this switch is on or off.
  ///
  /// This property must not be null.
  final bool value;

  /// can click
  final bool enabled;

  final ValueChanged<bool>? onChanged;

  final Color borderColor;

  final Color? trackColor;

  final Color thumbColor;

  const BrnMetaBaseSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.size,
    this.thumbColor = Colors.white,
    this.trackColor,
    this.borderColor = const Color(0xffeeeeee),
    this.enabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (enabled) {
          onChanged?.call(!value);
        }
      },
      child: Stack(
        children: [
          Container(
            height: size?.height,
            width: size?.width,
            decoration: BoxDecoration(
              color: trackColor,
              border: Border.all(
                  color: value ? Colors.transparent : borderColor,
                  width: _borderWidth),
              borderRadius:
                  BorderRadius.all(Radius.circular(size?.height ?? 0 / 2)),
            ),
          ),
          _getThumb(value)
        ],
      ),
    );
  }

  Positioned _getThumb(bool value) {
    return (value)
        ? Positioned(
            right: 0,
            child: Container(
              height: size?.height,
              width: size?.height,
              decoration: BoxDecoration(
                color: thumbColor,
                border: Border.all(color: borderColor, width: _borderWidth),
                borderRadius:
                    BorderRadius.all(Radius.circular(size?.height ?? 0 / 2)),
              ),
            ),
          )
        : Positioned(
            left: 0,
            child: Container(
              height: size?.height,
              width: size?.height,
              decoration: BoxDecoration(
                color: thumbColor,
                border: Border.all(color: borderColor, width: _borderWidth),
                borderRadius:
                    BorderRadius.all(Radius.circular(size?.height ?? 0 / 2)),
              ),
            ),
          );
  }
}
