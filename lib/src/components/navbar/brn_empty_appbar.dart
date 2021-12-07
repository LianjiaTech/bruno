import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BrnEmptyAppBar extends PreferredSize {
  final double height;
  final Color color;

  BrnEmptyAppBar(this.height, {this.color});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.white,
    );
  }
}
