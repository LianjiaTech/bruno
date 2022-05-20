import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BrnTitlePanelExample extends StatefulWidget {
  @override
  _BrnTitlePanelExampleState createState() => _BrnTitlePanelExampleState();
}

class _BrnTitlePanelExampleState extends State<BrnTitlePanelExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '卡片标题组件面板',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            BrnCardTitlePanel(
              children: [
                BrnActionCardTitle(
                  title: '箭头标题1',
                  onTap: () {
                    BrnToast.show('BrnActionCardTitle1 is clicked', context);
                  },
                ),
                BrnActionCardTitle(
                  title: '箭头标题2',
                  onTap: () {
                    BrnToast.show('BrnActionCardTitle2 is clicked', context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
