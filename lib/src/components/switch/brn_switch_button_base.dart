import 'package:flutter/material.dart';

const double _borderWidth = 1.5;

class BrnBaseSwitchButton extends StatelessWidget {
  final Size size;

  /// Whether this switch is on or off.
  ///
  /// This property must not be null.
  final bool value;

  /// can click
  final bool enabled;

  /// Called when the user toggles the switch on or off.
  final ValueChanged<bool>? onChanged;

  /// The color to use when this switch is off.
  final Color borderColor;

  /// The color to use on the track.
  final Color? trackColor;

  /// The color to use on the thumb.
  final Color thumbColor;

  const BrnBaseSwitchButton({
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
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: trackColor,
              border: Border.all(
                  color: value ? Colors.transparent : borderColor,
                  width: _borderWidth),
              borderRadius:
                  BorderRadius.all(Radius.circular(size.height / 2)),
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
            child: Padding(
              padding: EdgeInsets.only(right: _borderWidth),
              child: Container(
                height: size.height - 2 * _borderWidth,
                width: size.height - 2 * _borderWidth,
                decoration: BoxDecoration(
                  color: thumbColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(size.height / 2 - _borderWidth)),
                ),
              ),
            ),
          )
        : Positioned(
            child: Container(
              height: size.height,
              width: size.height,
              decoration: BoxDecoration(
                color: thumbColor,
                border: Border.all(color: borderColor, width: _borderWidth),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.height / 2)),
              ),
            ),
          );
  }
}
