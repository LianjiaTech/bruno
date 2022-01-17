import 'package:flutter/material.dart';

class BrnEmptyAppBar extends PreferredSize {
  final double height;
  final Color? color;

  BrnEmptyAppBar(this.height, {this.color})
      : super(child: Container(), preferredSize: const Size(0, 0));

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.white,
    );
  }
}
