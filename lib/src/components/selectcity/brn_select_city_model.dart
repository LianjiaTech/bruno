import 'package:bruno/src/components/selectcity/brn_az_common.dart';

/// 城市选择数据类
class BrnSelectCityModel extends ISuspensionBean {

  /// 城市名称
  String name = "";

  /// 城市名称前这是的标记符号
  String tagIndex = "";

  /// 拼音
  String? namePinyin;

  /// 城市 name 对应的锚点 tag
  String tag = "";

  /// 城市编码
  String cityCode = "";

  BrnSelectCityModel({
    required this.name,
    this.tagIndex = "",
    this.namePinyin,
    this.tag = "",
    this.cityCode = "",
  });

  BrnSelectCityModel.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {
        'name': name,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        'isShowSuspension': isShowSuspension,
        'cityCode': cityCode
      };

  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" + '}';
}
