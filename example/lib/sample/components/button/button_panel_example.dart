import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class ButtonPanelExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '小按钮集合',
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
                fontSize: 18,
              ),
            ),
            BrnBubbleText(
              maxLines: 3,
              text: '靠右的横排展示，每个按钮的间距是8，按钮的组的间距是16'
                  '，次按钮数目不超过两个时，优先展示主按钮，次按钮平分剩余空间，'
                  '次按钮超过两个时，显示更多，剩下的空间主次按钮平分',
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
              ),
            ),
            BrnButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮点击', context);
              },
              secondaryButtonOnTap: (index) {
                BrnToast.show('第$index个次按钮点击了', context);
              },
            ),
            Text(
              '正常案例,主按钮disable',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
              ),
            ),
            BrnButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮点击', context);
              },
              isMainBtnEnable: false,
              secondaryButtonNameList: ['次按钮1'],
              secondaryButtonOnTap: (index) {
                BrnToast.show('第$index个次按钮点击了', context);
              },
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
              ),
            ),
            BrnButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮点击', context);
              },
              secondaryButtonNameList: ['次按钮1', '次按钮2'],
              secondaryButtonOnTap: (index) {
                BrnToast.show('第$index个次按钮点击了', context);
              },
            ),
            Text(
              '正常案例，配置次按钮1 disable',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
              ),
            ),
            BrnButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮点击', context);
              },
              secondaryButtonList: [
                BrnButtonPanelConfig(name: '次按钮1', isEnable: false),
                BrnButtonPanelConfig(name: '次按钮2', isEnable: true)
              ],
              secondaryButtonOnTap: (index) {
                BrnToast.show('第$index个次按钮点击了', context);
              },
            ),
            Text(
              '异常案例：主按钮文字长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
              ),
            ),
            BrnButtonPanel(
              mainButtonName: '主按钮主按钮主按钮主按钮主按钮主按钮主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮点击', context);
              },
              secondaryButtonNameList: ['次按钮1', '次按钮2'],
              secondaryButtonOnTap: (index) {
                BrnToast.show('第$index个次按钮点击了', context);
              },
            ),
            Text(
              '异常案例：次按钮文字长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
              ),
            ),
            BrnButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮点击', context);
              },
              secondaryButtonNameList: ['次按钮1', '次按钮次按钮次按钮次按钮次按钮次按钮次按钮'],
              secondaryButtonOnTap: (index) {
                BrnToast.show('第$index个次按钮点击了', context);
              },
            ),
            Text(
              '异常案例：次按钮多',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
              ),
            ),
            BrnButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮点击', context);
              },
              secondaryButtonList: [
                BrnButtonPanelConfig(name: '次按钮1', isEnable: false),
                BrnButtonPanelConfig(name: '次按钮2', isEnable: true),
                BrnButtonPanelConfig(name: '次按钮3', isEnable: true),
                BrnButtonPanelConfig(name: '次按钮4', isEnable: false),
                BrnButtonPanelConfig(name: '次按钮5', isEnable: true),
              ],
              secondaryButtonOnTap: (index) {
                BrnToast.show('第$index个次按钮点击了', context);
              },
            ),
            Text(
              '异常案例：主按钮文字长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
              ),
            ),
            BrnButtonPanel(
              mainButtonName: '主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮点击', context);
              },
              secondaryButtonNameList: [
                '次按钮1',
                '次按钮2',
                '次按钮3',
              ],
              secondaryButtonOnTap: (index) {
                BrnToast.show('第$index个次按钮点击了', context);
              },
            ),
            Text(
              '异常案例：次按钮文字长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
              ),
            ),
            BrnButtonPanel(
              mainButtonName: '主按钮',
              mainButtonOnTap: () {
                BrnToast.show('主按钮点击', context);
              },
              popDirection: BrnPopupDirection.top,
              secondaryButtonNameList: [
                '次按钮次按钮次按钮次按钮次按钮次按钮次按钮次按钮',
                '次按钮2',
                '次按钮3',
                '次按钮4',
                '次按钮5',
                '次按钮6',
              ],
              secondaryButtonOnTap: (index) {
                BrnToast.show('第$index个次按钮点击了', context);
              },
            ),
            Text(
              '异常案例：字符串长度为0',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
              ),
            ),
            BrnButtonPanel(
              mainButtonName: '',
              mainButtonOnTap: () {
                BrnToast.show('主按钮点击', context);
              },
              secondaryButtonNameList: [
                '',
                '',
                '',
              ],
              secondaryButtonOnTap: (index) {
                BrnToast.show('第$index个次按钮点击了', context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
