import 'package:bruno/src/components/selectcity/brn_az_common.dart';

class BrnSelectCityModel extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;
  String tag;
  String cityCode;

  BrnSelectCityModel({
    this.name,
    this.tagIndex,
    this.namePinyin,
    this.tag,
    this.cityCode,
  });

  BrnSelectCityModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'],
        cityCode = json['cityCode'] == null ? "" : json['cityCode'];

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
