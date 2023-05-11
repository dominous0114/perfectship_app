class NormalizeModel {
  bool? status;
  String? name;
  String? cutAll;
  String? address;
  String? district;
  String? amphure;
  String? province;
  String? zipcode;
  String? phone;

  NormalizeModel({this.status, this.name, this.cutAll, this.address, this.district, this.amphure, this.province, this.zipcode, this.phone});

  NormalizeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.name;
    data['cut_all'] = this.cutAll;
    data['address'] = this.address;
    data['district'] = this.district;
    data['amphure'] = this.amphure;
    data['province'] = this.province;
    data['zipcode'] = this.zipcode;
    data['phone'] = this.phone;
    return data;
  }
}
