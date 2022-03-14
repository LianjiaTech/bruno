

import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/actionsheet/actionsheet_entry_page.dart';
import 'package:example/sample/components/appraise/appraise_example.dart';
import 'package:example/sample/components/bottom_tabbar/bottom_tabbar_example.dart';
import 'package:example/sample/components/button/bottom_button_entry_page.dart';
import 'package:example/sample/components/button/button_entry_page.dart';
import 'package:example/sample/components/button/button_panel_entry_page.dart';
import 'package:example/sample/components/button/icon_button_example.dart';
import 'package:example/sample/components/calendar/calendarview_example.dart';
import 'package:example/sample/components/card/brn_shadow_example.dart';
import 'package:example/sample/components/card/bubble/bubble_entry_page.dart';
import 'package:example/sample/components/card/content/text_content_entry_page.dart';
import 'package:example/sample/components/card_title/title_example.dart';
import 'package:example/sample/components/charts/chart_entry_example.dart';
import 'package:example/sample/components/charts/doughnut_chart_example.dart';
import 'package:example/sample/components/charts/line/brn_broken_line_example.dart';
import 'package:example/sample/components/charts/line/db_data_node_model.dart';
import 'package:example/sample/components/charts/progress_bar_chart_example.dart';
import 'package:example/sample/components/charts/progress_chart_entry_page.dart';
import 'package:example/sample/components/dialog/dialog_entry_page.dart';
import 'package:example/sample/components/empty/abnormal_entry_page.dart';
import 'package:example/sample/components/form/all_item_style_example.dart';
import 'package:example/sample/components/gallery/gallery_example.dart';
import 'package:example/sample/components/guide/guide_entry_page.dart';
import 'package:example/sample/components/input/input_example.dart';
import 'package:example/sample/components/line/dashed_line_example.dart';
import 'package:example/sample/components/loading/loading_widget_example.dart';
import 'package:example/sample/components/navbar/appbar_entry_page.dart';
import 'package:example/sample/components/noticebar/brn_notice_bar_example.dart';
import 'package:example/sample/components/picker/picker_entry_page.dart';
import 'package:example/sample/components/popup/popwindow_example.dart';
import 'package:example/sample/components/rating/rating_example.dart';
import 'package:example/sample/components/scroll_anchor/scroll_actor_tab_example.dart';
import 'package:example/sample/components/selection/selection_entry_page.dart';
import 'package:example/sample/components/step/step_example.dart';
import 'package:example/sample/components/sugsearch/search_text_example.dart';
import 'package:example/sample/components/switch/checkbox_example.dart';
import 'package:example/sample/components/switch/radio_example.dart';
import 'package:example/sample/components/tabbar/brn_tab_example.dart';
import 'package:example/sample/components/tag/tag_example.dart';
import 'package:example/sample/components/toast/toast_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 卡片信息
class GroupInfo {
  /// 唯一ID
  int? groupId;

  /// 组名称
  String groupName;

  /// 描述
  String desc;

  /// 是否展开
  bool isExpand;

  /// 是否可定制
  bool isSupportTheme;

  /// 子Widget
  List<GroupInfo>? children;

  /// 跳转到下一个页面
  Function(BuildContext context)? navigatorPage;

  GroupInfo(
      {this.groupId,
      this.groupName = "",
      this.desc = "",
      this.isExpand = false,
      this.navigatorPage,
      this.isSupportTheme = false,
      this.children});
}

/// 数据配置类
class CardDataConfig {
  /// 全部
  static List<GroupInfo> getAllGroup() {
    List<GroupInfo> list = [];
    list.add(_getChartGroup());
    list.add(_getDataInputGroup());
    list.add(_getOperateGroup());
    list.add(_getNavigatorGroup());
    list.add(_getButtonGroup());
    list.add(_getContentGroup());
    return list;
  }

  /// 数据图表
  static GroupInfo _getChartGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "BrokenLine 折线图 ",
        desc: "数据折线图",
        navigatorPage: (BuildContext context) {
          rootBundle.loadString('assets/brokenline_data.json').then((data) {
            var brokenData = <DBDataNodeModel>[]..addAll(
                ((JsonDecoder().convert(data) as List?) ?? [])
                    .map((o) => DBDataNodeModel.fromJson(o)));
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return BrokenLineExample(brokenData);
              },
            ));
          });
        }));
    children.add(GroupInfo(
        groupName: "Radar 雷达图",
        desc: "数据雷达图",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return RadarChartExamplePage();
            },
          ));
        }));

    children.add(GroupInfo(
        groupName: "Funnel 漏斗图",
        desc: "数据漏斗图",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return FunnelChartExamplePage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Doughnut 环状图",
        desc: "环状图",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return DoughnutChartExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Progress 进度图",
        desc: "进度图",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ProgressChartExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "ProgressBar 柱状图",
        desc: "柱状图",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ProgressBarChartExample();
            },
          ));
        }));
    return GroupInfo(groupName: "数据图表", children: children, isExpand: true);
  }

  /// 数据录入
  static GroupInfo _getDataInputGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "Form 表单项",
        desc: "各种表单项",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AllFormItemStyleExamplePage("表单项类型示例");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Picker 选择器",
        desc: "选择弹框",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return PickerEntryPage("Picker示例");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Appraise 评价",
        desc: "表情和星星评价组件",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AppraiseExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Input 动态输入框",
        desc: "自动输入动态算高",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnInputTextExample();
            },
          ));
        }));
    return GroupInfo(groupName: "数据录入", children: children, isExpand: false);
  }

  /// 操作反馈类
  static GroupInfo _getOperateGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "Dialog 弹窗",
        desc: "Dialog多种类型展示",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return DialogEntryPage("Dialog类型示例");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "ActionSheet 底部菜单",
        desc: "底部操作弹框",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ActionSheetEntryPage("ActionSheet示例");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Tips 提示",
        desc: "在指定位置弹出提示",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return PopWindowExamplePage("Tips 提示示例");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Toast 吐司",
        desc: "页面 Toast",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ToastExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Loading 加载框",
        desc: "页面loading",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return LoadingExample();
            },
          ));
        }));
    return GroupInfo(groupName: "操作反馈", children: children, isExpand: false);
  }

  /// 导航类
  static GroupInfo _getNavigatorGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "Appbar 导航栏",
        desc: "Appbar 导航栏",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AppbarEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Search 搜索",
        desc: "只用于搜索",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return SearchTextExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Tabs 切换",
        desc: "tab",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnTabExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "BottomTabBar 底部导航",
        desc: "底部导航",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BottomTabbarExample();
          }));
        }));
    children.add(GroupInfo(
        groupName: "Selection 筛选",
        desc: "筛选项+筛选抽屉",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return SelectionEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "CitySelection 城市选择",
        desc: "城市选择",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return _buildSingleSelectCityPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Anchor 锚点",
        desc: "锚点 Tab 滑动实例",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ScrollActorTabExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Guide 引导",
        desc: "强引导&弱引导",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return GuideEntryPage();
            },
          ));
        }));
    return GroupInfo(groupName: "导航", children: children);
  }

  /// 按钮
  static GroupInfo _getButtonGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "NormalButton 普通按钮",
        desc: "主按钮、次按钮、按钮集合",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ButtonEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "BottomButtonPanel 吸底按钮",
        desc: "吸底按钮集合",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BottomButtonEntryWidget();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "ButtonPanel 按钮集合",
        desc: "按钮集合",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ButtonPanelEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "IconButton 图文按钮",
        desc: "button和图片任意位置组合",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnIconBtnExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Radio 单选按钮",
        desc: "单选按钮",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return RadioExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Checkbox 多选按钮",
        desc: "多选按钮",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return CheckboxExample();
            },
          ));
        }));
    return GroupInfo(groupName: "按钮", children: children, isExpand: false);
  }

  /// 内容
  static GroupInfo _getContentGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "Tag 标签",
        desc: "标签多种样式",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return TagExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "RatingBar 星级",
        desc: "星级评分条",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return RatingExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "DashedLine 虚线分割线",
        desc: "自定义虚线",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return DashedLineExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "ShadowCard 阴影卡片",
        desc: "BrnShadowCard",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnShadowExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Title 标题",
        desc: "多种标题示例",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return TitleExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "AbnormalCard 异常卡片",
        desc: "多种异常页面展示",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AbnormalStatesEntryPage("异常页面示例");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Bubble 气泡 ",
        desc: "普通气泡&可展开气泡",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BubbleEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "StepBar 步骤条",
        desc: "横向&竖向步骤条",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return StepExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Notification 通知",
        desc: "各种通知样式，支持设置图标和颜色",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnNoticeBarExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Text 文本内容",
        desc: "文本内容多样式",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return TextContentEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Calendar日历",
        desc: "日历组件",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return CalendarViewExample("日历组件");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Gallery 图片",
        desc: "图片选择&图片查看",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return GalleryExample();
            },
          ));
        }));
    return GroupInfo(groupName: "内容", children: children);
  }

  /// 城市选择
  static Widget _buildSingleSelectCityPage() {
    List<BrnSelectCityModel> hotCityList = [];
    hotCityList.addAll([
      BrnSelectCityModel(name: "北京市"),
      BrnSelectCityModel(name: "广州市"),
      BrnSelectCityModel(name: "成都市"),
      BrnSelectCityModel(name: "深圳市"),
      BrnSelectCityModel(name: "杭州市"),
      BrnSelectCityModel(name: "武汉市"),
    ]);
    return BrnSingleSelectCityPage(
      appBarTitle: '城市单选',
      hotCityTitle: '这里是推荐城市',
      hotCityList: hotCityList,
    );
  }
}
