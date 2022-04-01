

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BrnCommonBottomExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '普通吸底按钮',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '规则',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBubbleText(
              maxLines: 3,
              text: '文字按钮最多两个：主按钮和次按钮，可以展示三种按钮的排列组合\n'
                  '主按钮和次按钮的宽度大小是 不固定的，随着icon按钮的多少而变化\n'
                  '上下padding：16，18。左右padding：20',
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
              secondaryButtonName: '次按钮',
              enableSecondaryButton: false,
              secondaryButtonOnTap: () {
                BrnToast.show('次按钮', context);
              },
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
              secondaryButtonName: '次按钮',
              secondaryButtonOnTap: () {
                BrnToast.show('次按钮', context);
              },
              iconButtonList: [
                BrnVerticalIconButton(
                  name: '写备注',
                  iconWidget: Icon(Icons.add),
                ),
              ],
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
              secondaryButtonName: '次按钮',
              secondaryButtonOnTap: () {
                BrnToast.show('次按钮', context);
              },
              iconButtonList: [
                BrnVerticalIconButton(
                  name: '写备注',
                  iconWidget: Icon(Icons.add),
                ),
                BrnVerticalIconButton(
                  name: '写跟进',
                  iconWidget: Icon(Icons.functions),
                ),
              ],
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
              secondaryButtonName: '次按钮',
              secondaryButtonOnTap: () {
                BrnToast.show('次按钮', context);
              },
              iconButtonList: [
                BrnVerticalIconButton(
                  name: '写备注',
                  iconWidget: Icon(Icons.add),
                ),
                BrnVerticalIconButton(
                  name: '写跟进',
                  iconWidget: Icon(Icons.functions),
                ),
                BrnVerticalIconButton(
                  name: '更多',
                  iconWidget: Icon(Icons.input),
                ),
              ],
            ),
            Text(
              '正常案例 主按钮不可用',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮',
              enableMainButton: false,
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
              secondaryButtonName: '次按钮',
              secondaryButtonOnTap: () {
                BrnToast.show('次按钮', context);
              },
              iconButtonList: [
                BrnVerticalIconButton(
                  name: '写备注',
                  iconWidget: Icon(Icons.add),
                ),
                BrnVerticalIconButton(
                  name: '写跟进',
                  iconWidget: Icon(Icons.functions),
                ),
                BrnVerticalIconButton(
                  name: '更多',
                  onTap: () {
                    BrnToast.show('更多', context);
                  },
                  iconWidget: Icon(Icons.input),
                ),
              ],
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮',
              enableMainButton: false,
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
              secondaryButtonName: '次按钮',
              secondaryButtonOnTap: () {
                BrnToast.show('次按钮', context);
              },
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮',
              enableMainButton: false,
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
            ),
            Text(
              '异常案例：按钮文本长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮',
              secondaryButtonName: '次按钮次按钮次按钮次按钮次按钮次按钮次按钮次按钮次按钮次按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
              secondaryButtonOnTap: () {
                BrnToast.show('次按钮', context);
              },
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮',
              secondaryButtonName: '次按钮次按钮次按钮次按钮次按钮次按钮次按钮次按钮次按钮次按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
              secondaryButtonOnTap: () {
                BrnToast.show('次按钮', context);
              },
            ),
            BrnBottomButtonPanel(
              mainButtonName: '主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮',
              secondaryButtonName: '次按钮次按钮次按钮次按钮次按钮次按钮次按钮次按钮次按钮次按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
              secondaryButtonOnTap: () {
                BrnToast.show('次按钮', context);
              },
              iconButtonList: [
                BrnVerticalIconButton(
                  name: '写备注',
                  iconWidget: Icon(Icons.add),
                ),
                BrnVerticalIconButton(
                  name: '写跟进',
                  iconWidget: Icon(Icons.functions),
                ),
                BrnVerticalIconButton(
                  name: '更多',
                  iconWidget: Icon(Icons.input),
                ),
              ],
            ),
            Text(
              '异常案例：按钮文本长为空串',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBottomButtonPanel(
              mainButtonName: '',
              secondaryButtonName: '',
              mainButtonOnTap: () {
                BrnToast.show('主按钮', context);
              },
              secondaryButtonOnTap: () {
                BrnToast.show('次按钮', context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
