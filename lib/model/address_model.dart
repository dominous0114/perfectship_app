class AddressModel {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? subDistrict;
  String? district;
  String? province;
  String? zipcode;
  int? primaryAddress;

  AddressModel(
      {this.id,
      this.name,
      this.phone,
      this.address,
      this.subDistrict,
      this.district,
      this.province,
      this.zipcode,
      this.primaryAddress});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    subDistrict = json['sub_district'];
    district = json['district'];
    province = json['province'];
    zipcode = json['zipcode'];
    primaryAddress = json['primary_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['sub_district'] = this.subDistrict;
    data['district'] = this.district;
    data['province'] = this.province;
    data['zipcode'] = this.zipcode;
    data['primary_address'] = this.primaryAddress;
    return data;
  }
}
