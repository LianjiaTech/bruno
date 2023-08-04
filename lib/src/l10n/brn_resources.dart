
import 'dart:core';
import 'dart:ui';

/// 资源抽象类
abstract class BrnBaseResource {

  String get ok;

  String get cancel;

  String get confirm;

  String get loading;

  String get pleaseEnter;

  String get enterRangeError;

  String get pleaseChoose;

  String get selectRangeError;

  String get reset;

  String get confirmClearSelectedList;

  String get selectedList;

  String get clear;

  String get shareTo;

  List<String> get appriseLevel;

  String get dateFormatYYYYMM;

  String get dateFormatYYYYMMDD;

  String get dateFormatYYYYMMMMDD;

  String get expand;

  String get collapse;

  String get more;

  String get allPics;

  String get submit;

  String get noTagDataTip;

  List<String> get months;

  List<String> get weekFullName;

  List<String> get weekShortName;

  List<String> get weekMinName;

  String get skip;

  String get known;

  String get next;

  String get inputSearchTip;

  String get done;

  String get noDataTip;

  String get selectAll;

  String get selected;

  String get shareWayTip;

  String get max;

  String get min;

  String get selectCountLimitTip;

  String get to;

  String get recommandCity;

  String get selectCity;

  String get filterConditionCountLimited;

  String get minValue;

  String get maxValue;

  String selectTitle(String selected);

  String get customRange;

  String get startDate;

  String get endDate;

  String get selectStartDate;

  String get selectEndDate;

  List<String> get shareChannels;

  String get fetchErrorAndRetry;

  String get netErrorAndRetryLater;

  String get noSearchData;

  String get clickPageAndRetry;
}

///
/// 中文资源
///
class BrnResourceZh extends BrnBaseResource {

  static Locale locale = Locale('zh', 'CN');

  @override
  String get ok => '确定';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get loading => '加载中...';

  @override
  String get pleaseEnter => '请输入';

  @override
  String get enterRangeError => '您输入的区间有误';

//// TODO
  @override
  String get pleaseChoose => '请选择';

  @override
  String get selectRangeError => '您选择的区间有误';

  @override
  String get reset => '重置';

  @override
  String get confirmClearSelectedList => '确定要清空已选列表吗?';

  @override
  String get selectedList => '已选列表';

  @override
  String get clear => '清空';

  @override
  String get shareTo => '分享至';

  @override
  List<String> get appriseLevel => [
        '不好',
        '还行',
        '满意',
        '很棒',
        '超惊喜',
      ];

  @override
  String get dateFormatYYYYMM => 'yyyy年MM月';

  @override
  String get dateFormatYYYYMMDD => 'yyyy年MM月dd日';

  @override
  String get dateFormatYYYYMMMMDD => 'yyyy年,MMMM月,dd日';

  @override
  String get expand => '展开';

  @override
  String get collapse => '收起';

  @override
  String get more => '更多';

  @override
  String get allPics => '全部图片';

  @override
  String get submit => '提交';

  @override
  String get noTagDataTip => '暂未配置可选标签数据';

  List<String> get months =>[
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];

  @override
  List<String> get weekFullName => [
        '星期一',
        '星期二',
        '星期三',
        '星期四',
        '星期五',
        '星期六',
        '星期日',
      ];

  @override
  List<String> get weekShortName => [
        '周一',
        '周二',
        '周三',
        '周四',
        '周五',
        '周六',
        '周日',
      ];

  @override
  List<String> get weekMinName => [
        '日',
        '一',
        '二',
        '三',
        '四',
        '五',
        '六',
      ];

  @override
  String get skip => '跳过';

  @override
  String get known => '我知道了';

  @override
  String get next => '下一步';

  @override
  String get inputSearchTip => '请输入搜索内容';

  @override
  String get done => '完成';

  @override
  String get noDataTip => '暂无数据';

  @override
  String get selectAll => '全选';

  @override
  String get selected => '已选';

  @override
  String get shareWayTip => '你可以通过以下方式分享给客户';

  @override
  String get max => '最小';

  @override
  String get min => '最大';

  @override
  String get selectCountLimitTip => '您选择的数量已达上限';

  @override
  String get to => '至';

  @override
  String get recommandCity => '这里是推荐城市';

  @override
  String get selectCity => '城市选择';

  @override
  String get filterConditionCountLimited => '您选择的筛选条件数量已达上限';

  @override
  String get minValue => '最小值';

  @override
  String get maxValue => '最大值';

  @override
  String selectTitle(String selected) => '选择$selected';

  @override
  String get customRange => '自定义区间';

  @override
  String get startDate => '开始日期';

  @override
  String get endDate => '结束日期';

  @override
  String get selectStartDate => '请选择开始时间';

  @override
  String get selectEndDate => '请选择结束时间';

  @override
  List<String> get shareChannels => [
        '微信',
        '朋友圈',
        'QQ',
        'QQ空间',
        '微博',
        '链接',
        '短信',
        '剪贴板',
        '浏览器',
        '相册',
      ];

  @override
  String get fetchErrorAndRetry => '获取数据失败，请重试';

  @override
  String get netErrorAndRetryLater => '网络连接失败，检查后重试';

  @override
  String get noSearchData => '暂无搜索结果';

  @override
  String get clickPageAndRetry => '请点击页面重试';
}

///
/// en resources
///
class BrnResourceEn extends BrnBaseResource {

  static Locale locale = Locale('en', 'US');

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get loading => 'Loading ...';

  @override
  String get pleaseEnter => 'Please Enter';

  @override
  String get enterRangeError => 'The range you entered is incorrect';

  @override
  String get pleaseChoose => 'Please choose';

  @override
  String get selectRangeError => 'You have selected the wrong range';

  @override
  String get reset => 'Reset';

  @override
  String get confirmClearSelectedList => 'Are you sure you want to clear the selected list?';

  @override
  String get selectedList => 'Selected list';

  @override
  String get clear => 'Clear';

  @override
  String get shareTo => 'Share to';

  @override
  List<String> get appriseLevel => [
        'not good',
        'good',
        'satisfy',
        'great',
        'surprise',
      ];

  @override
  String get dateFormatYYYYMM => 'MM/yyyy';

  @override
  String get dateFormatYYYYMMDD => 'dd/MM/yyyy';

  @override
  String get dateFormatYYYYMMMMDD => 'dd/MMMM/yyyy';

  @override
  String get expand => 'Expand';

  @override
  String get collapse => 'Collapse';

  @override
  String get more => 'More';

  @override
  String get allPics => 'All pictures';

  @override
  String get submit => 'Submit';

  @override
  String get noTagDataTip => 'Tag data not configured yet';

  @override
  List<String> get months =>[
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];

  @override
  List<String> get weekFullName => [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];

  @override
  List<String> get weekShortName => [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
      ];

  @override
  List<String> get weekMinName => [
        'U',
        'M',
        'T',
        'W',
        'R',
        'F',
        'S',
      ];

  @override
  String get skip => 'Skip';

  @override
  String get known => 'I see';

  @override
  String get next => 'Next';

  @override
  String get inputSearchTip => 'Please enter search content';

  @override
  String get done => 'Done';

  @override
  String get noDataTip => 'No data';

  @override
  String get selectAll => 'Select all';

  @override
  String get selected => 'Selected';

  @override
  String get shareWayTip => 'You can share with customers in the following ways';

  @override
  String get max => 'Min';

  @override
  String get min => 'Max';

  @override
  String get selectCountLimitTip => 'You have already selected the maximum number';

  @override
  String get to => 'to';

  @override
  String get recommandCity => 'Here are the recommended cities';

  @override
  String get selectCity => 'Select city';

  @override
  String get filterConditionCountLimited => 'You have selected the maximum number of filters';

  @override
  String get minValue => 'Min';

  @override
  String get maxValue => 'Max';

  @override
  String selectTitle(String selected) => 'Select $selected';

  @override
  String get customRange => 'Custom range';

  @override
  String get startDate => 'Start date';

  @override
  String get endDate => 'End date';

  @override
  String get selectStartDate => 'Please select a start time';

  @override
  String get selectEndDate => 'Please select a end time';

  @override
  List<String> get shareChannels => [
        'Wechat',
        'Friends',
        'QQ',
        'QQ Zone',
        'Weibo',
        'Link',
        'Message',
        'Clipboard',
        'Browser',
        'Photo Album',
      ];

  @override
  String get fetchErrorAndRetry => 'Fetch data fail, please try again';

  @override
  String get netErrorAndRetryLater => 'Network connection failed, check and try again';

  @override
  String get noSearchData => 'No search results';

  @override
  String get clickPageAndRetry => 'Please click the page to try again';
}
