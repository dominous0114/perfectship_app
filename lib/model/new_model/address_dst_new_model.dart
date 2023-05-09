class AddressDstNewModel {
  int? id;
  String? name;
  String? phone;
  var customerId;
  int? userId;
  int? type;
  String? address;
  String? subDistrict;
  String? district;
  String? province;
  String? zipcode;
  int? useLabel;
  var labelName;
  var labelPhone;
  var labelAddress;
  var labelSubDistrict;
  var labelDistrict;
  var labelProvince;
  var labelZipcode;
  var courierCode;
  int? isPrimary;
  String? createdAt;
  String? updatedAt;

  AddressDstNewModel(
      {this.id,
      this.name,
      this.phone,
      this.customerId,
      this.userId,
      this.type,
      this.address,
      this.subDistrict,
      this.district,
      this.province,
      this.zipcode,
      this.useLabel,
      this.labelName,
      this.labelPhone,
      this.labelAddress,
      this.labelSubDistrict,
      this.labelDistrict,
      this.labelProvince,
      this.labelZipcode,
      this.courierCode,
      this.isPrimary,
      this.createdAt,
      this.updatedAt});

  AddressDstNewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    customerId = json['customer_id'];
    userId = json['user_id'];
    type = json['type'];
    address = json['address'];
    subDistrict = json['sub_district'];
    district = json['district'];
    province = json['province'];
    zipcode = json['zipcode'];
    useLabel = json['use_label'];
    labelName = json['label_name'];
    labelPhone = json['label_phone'];
    labelAddress = json['label_address'];
    labelSubDistrict = json['label_sub_district'];
    labelDistrict = json['label_district'];
    labelProvince = json['label_province'];
    labelZipcode = json['label_zipcode'];
    courierCode = json['courier_code'];
    isPrimary = json['is_primary'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['customer_id'] = this.customerId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['address'] = this.address;
    data['sub_district'] = this.subDistrict;
    data['district'] = this.district;
    data['province'] = this.province;
    data['zipcode'] = this.zipcode;
    data['use_label'] = this.useLabel;
    data['label_name'] = this.labelName;
    data['label_phone'] = this.labelPhone;
    data['label_address'] = this.labelAddress;
    data['label_sub_district'] = this.labelSubDistrict;
    data['label_district'] = this.labelDistrict;
    data['label_province'] = this.labelProvince;
    data['label_zipcode'] = this.labelZipcode;
    data['courier_code'] = this.courierCode;
    data['is_primary'] = this.isPrimary;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
