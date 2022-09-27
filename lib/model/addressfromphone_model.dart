class AddressfromphoneModel {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? origin;
  String? subDistrict;
  String? district;
  String? province;
  String? zipcode;

  AddressfromphoneModel(
      {this.id,
      this.name,
      this.phone,
      this.address,
      this.origin,
      this.subDistrict,
      this.district,
      this.province,
      this.zipcode});

  AddressfromphoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    origin = json['origin'];
    subDistrict = json['sub_district'];
    district = json['district'];
    province = json['province'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['origin'] = this.origin;
    data['sub_district'] = this.subDistrict;
    data['district'] = this.district;
    data['province'] = this.province;
    data['zipcode'] = this.zipcode;
    return data;
  }
}
