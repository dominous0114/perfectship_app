class AddressSearchNewModel {
  int? id;
  String? zipcode;
  String? district;
  String? amphure;
  String? province;

  AddressSearchNewModel({this.id, this.zipcode, this.district, this.amphure, this.province});

  AddressSearchNewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zipcode = json['zipcode'].toString().substring(1);
    district = json['district'];
    amphure = json['amphure'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['zipcode'] = this.zipcode;
    data['district'] = this.district;
    data['amphure'] = this.amphure;
    data['province'] = this.province;
    return data;
  }
}
