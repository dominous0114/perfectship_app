class Normalize {
  Normalize({
    required this.name,
    required this.cutAll,
    required this.address,
    required this.district,
    required this.amphure,
    required this.province,
    required this.zipcode,
    required this.phone,
  });
  late final String name;
  late final String cutAll;
  late final String address;
  late final String district;
  late final String amphure;
  late final String province;
  late final String zipcode;
  late final String phone;

  Normalize.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cutAll = json['cut_all'];
    address = json['address'];
    district = json['district'];
    amphure = json['amphure'];
    province = json['province'];
    zipcode = json['zipcode'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['cut_all'] = cutAll;
    _data['address'] = address;
    _data['district'] = district;
    _data['amphure'] = amphure;
    _data['province'] = province;
    _data['zipcode'] = zipcode;
    _data['phone'] = phone;
    return _data;
  }
}
