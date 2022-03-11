// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.



import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A single-line [ListTile] with a trailing button that expands or collapses
/// the tile to reveal or hide the [children].
///
/// This widget is typically used with [ListView] to create an
/// "expand / collapse" list entry. When used with scrolling widgets like
/// [ListView], a unique [PageStorageKey] must be specified to enable the
/// [BrnExpandableGroup] to save and restore its expanded state when it is scrolled
/// in and out of view.
///
/// See also:
///
///  * [ListTile], useful for creating expansion tile [children] when the
///    expansion tile represents a sublist.
///  * The "Expand/collapse" section of
///    <https://material.io/guidelines/components/lists-controls.html>.
// ignore: must_be_immutable
class BrnExpandableGroup extends StatefulWidget {
  /// Creates a single-line [ListTile] with a trailing button that expands or collapses
  /// the tile to reveal or hide the [children]. The [initiallyExpanded] property must
  /// be non-null.
  BrnExpandableGroup({
    Key? key,
    required this.title,
    this.subtitle,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.initiallyExpanded = false,
    this.themeData,
  }) : super(key: key) {
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
  }

  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final String title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.

  final String? subtitle;

  /// Called when the tile expands or collapses.
  ///
  /// When the tile starts expanding, this function is called with the value
  /// true. When the tile starts collapsing, this function is called with
  /// the value false.
  final ValueChanged<bool>? onExpansionChanged;

  /// The widgets that are displayed when the tile expands.
  ///
  /// Typically [ListTile] widgets.
  final List<Widget> children;

  /// The color to display behind the sublist when expanded.
  final Color? backgroundColor;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;

  BrnFormItemConfig? themeData;

  @override
  _BrnExpansionElementState createState() => _BrnExpansionElementState();
}

class _BrnExpansionElementState extends State<BrnExpandableGroup>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  /// 头部颜色
  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  Widget? arrowIcon;

  @override
  void initState() {
    super.initState();
    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;

    _controller = AnimationController(
        duration: Duration(milliseconds: 200) /*_kExpand*/, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    if (_isExpanded) {
      _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    } else {
      _iconTurns = _controller
          .drive(Tween<double>(begin: 0.5, end: 0.0).chain(_easeInTween));
    }

    if (_isExpanded) {
      _controller.value = 1.0;
    }

    if (_isExpanded) {
      arrowIcon = BrunoTools.getAssetSizeImage(BrnAsset.iconDownArrow, 12, 12);
    } else {
      arrowIcon = BrunoTools.getAssetSizeImage(BrnAsset.iconUpArrow, 12, 12);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged!(_isExpanded);
  }

  Widget _buildHeader(BuildContext context, Widget? child) {
    final Color backgroundColor = Colors.transparent;

    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _handleTap();
            },
            child: Container(
              color: Colors.white,
              padding:
                  EdgeInsets.only(left: 20, top: 14, bottom: 14, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 6),
                          child: Text(
                            widget.title,
                            style: BrnFormUtil.getHeadTitleTextStyle(
                                widget.themeData!,
                                isBold: true),
                          )),
                      // 副标题
                      Container(
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 4),
                        child: Offstage(
                          // ignore: deprecated_member_use_from_same_package
                          offstage: (widget.subtitle == null ||
                              widget.subtitle!.isEmpty),
                          child: Text(
                            // ignore: deprecated_member_use_from_same_package
                            widget.subtitle ?? "",
                            style: BrnFormUtil.getSubTitleTextStyle(
                                widget.themeData!),
                          ),
                        ),
                      ),
                    ],
                  ),
                  RotationTransition(
                    turns: _iconTurns,
                    child: arrowIcon,
                  )
                ],
              ),
            ),
          ),

          /// 可展开收起项
          Container(
            child: ClipRect(
              child: Align(
                heightFactor: _heightFactor.value,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);

    _borderColorTween..end = theme.dividerColor;

    /// title 文字颜色
    _headerColorTween
      ..begin = theme.textTheme.subtitle1!.color
      ..end = theme.textTheme.subtitle1!.color;

    /// 展开收起图标颜色
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.unselectedWidgetColor;

    _backgroundColorTween..end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildHeader,
      child: closed ? null : Column(children: widget.children),
    );
  }
}
