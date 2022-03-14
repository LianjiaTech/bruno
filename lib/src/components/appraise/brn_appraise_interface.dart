import 'package:flutter/material.dart';

/// 点击表情或者星星时的回调
/// index 点击的表情或者星星的index
typedef BrnAppraiseIconClick = void Function(int index);

/// 点击tag的回调
/// selectedTags 所有选中标签的集合
typedef BrnAppraiseTagClick = void Function(List<String> selectedTags);

/// 提交按钮点击事件回调
/// index 选中的表情或者星星的index
/// selectedTags 所有选中标签的集合
/// input 自定义输入的内容
typedef BrnAppraiseConfirmClick = void Function(
    int index, List<String> selectedTags, String input);

/// 点击关闭的回掉
typedef BrnAppraiseCloseClickCallBack = void Function(BuildContext context);
