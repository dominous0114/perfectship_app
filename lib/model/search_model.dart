class Search {
  Search({
    required this.zipcode,
    required this.district,
    required this.amphure,
    required this.province,
  });

  late final String zipcode;
  late final String district;
  late final String amphure;
  late final String province;

  Search.fromJson(Map<String, dynamic> json) {
    zipcode = json['zipcode'].toString().substring(1);
    district = json['district'];
    amphure = json['amphure'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['zipcode'] = zipcode;
    _data['district'] = district;
    _data['amphure'] = amphure;
    _data['province'] = province;
    return _data;
  }
}
