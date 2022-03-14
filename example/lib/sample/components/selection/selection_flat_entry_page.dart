

import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/selection/flat_selection_five_tags_example.dart';
import 'package:example/sample/components/selection/flat_selection_four_tags_example.dart';
import 'package:example/sample/components/selection/flat_selection_three_tags_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlatSelectionEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: 'Selection 示例',
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Text(
                "BrnSelectionView 组件：",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple),
              ),
            ),
            Divider(indent: 15),
            ListItem(
              title: "新筛选示例(更多里面抽出平级筛选+一行3个tag)",
              onPressed: () {
                rootBundle
                    .loadString('assets/flat_selection_filter.json')
                    .then((data) {
                  var datas = BrnSelectionEntityListBean.fromJson(
                          JsonDecoder().convert(data)["data"])!
                      .list!;
                  void _configMaxSelectedCount(
                      BrnSelectionEntity entity, int maxCount) {
                    entity.maxSelectedCount = maxCount;
                    if (entity.children.length > 0) {
                      for (BrnSelectionEntity child in entity.children) {
                        _configMaxSelectedCount(child, maxCount);
                      }
                    }
                  }

                  _configMaxSelectedCount(datas[0].children[1], 5);
                  var page = FlatSelectionThreeTagsExample(
                      "新筛选示例(更多里面抽出平级筛选+一行3个tag)", datas);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return page;
                    },
                  ));
                });
              },
            ),
            ListItem(
              title: "新筛选示例(更多里面抽出平级筛选+一行4个tag)",
              onPressed: () {
                rootBundle
                    .loadString('assets/flat_selection_filter.json')
                    .then((data) {
                  var datas = BrnSelectionEntityListBean.fromJson(
                          JsonDecoder().convert(data)["data"])!
                      .list!;
                  void _configMaxSelectedCount(
                      BrnSelectionEntity entity, int maxCount) {
                    entity.maxSelectedCount = maxCount;
                    if (entity.children.length > 0) {
                      for (BrnSelectionEntity child in entity.children) {
                        _configMaxSelectedCount(child, maxCount);
                      }
                    }
                  }

                  _configMaxSelectedCount(datas[0].children[1], 5);
                  var page = FlatSelectionFourTagsExample(
                      "新筛选示例(更多里面抽出平级筛选+一行4个tag)", datas);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return page;
                    },
                  ));
                });
              },
            ),
            ListItem(
              title: "新筛选示例(更多里面抽出平级筛选+一行5个tag)",
              onPressed: () {
                rootBundle
                    .loadString('assets/flat_selection_filter.json')
                    .then((data) {
                  var datas = BrnSelectionEntityListBean.fromJson(
                          JsonDecoder().convert(data)["data"])!
                      .list!;
                  void _configMaxSelectedCount(
                      BrnSelectionEntity entity, int maxCount) {
                    entity.maxSelectedCount = maxCount;
                    if (entity.children.length > 0) {
                      for (BrnSelectionEntity child in entity.children) {
                        _configMaxSelectedCount(child, maxCount);
                      }
                    }
                  }

                  _configMaxSelectedCount(datas[0].children[1], 5);
                  var page = NewSelectionViewExamplePage23(
                      "新筛选示例(更多里面抽出平级筛选+一行5个tag)", datas);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return page;
                    },
                  ));
                });
              },
            ),
          ],
        ));
  }
}
