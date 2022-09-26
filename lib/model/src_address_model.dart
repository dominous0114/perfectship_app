class SrcAddressModel {
  int? id;
  String? name;
  int? dropoffMemberId;
  String? cardId;
  String? origin;
  int? useLabel;
  String? labelName;
  String? labelAddress;
  String? labelZipcode;
  String? labelPhone;
  String? address;
  String? phone;
  String? subDistrict;
  String? district;
  String? province;
  String? zipcode;
  int? type;
  int? userId;
  String? courierCode;
  int? primaryAddress;
  var deletedAt;
  String? createdAt;
  String? updatedAt;

  SrcAddressModel(
      {this.id,
      this.name,
      this.dropoffMemberId,
      this.cardId,
      this.origin,
      this.useLabel,
      this.labelName,
      this.labelAddress,
      this.labelZipcode,
      this.labelPhone,
      this.address,
      this.phone,
      this.subDistrict,
      this.district,
      this.province,
      this.zipcode,
      this.type,
      this.userId,
      this.courierCode,
      this.primaryAddress,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  SrcAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dropoffMemberId = json['dropoff_member_id'];
    cardId = json['card_id'];
    origin = json['origin'];
    useLabel = json['use_label'];
    labelName = json['label_name'];
    labelAddress = json['label_address'];
    labelZipcode = json['label_zipcode'];
    labelPhone = json['label_phone'];
    address = json['address'];
    phone = json['phone'];
    subDistrict = json['sub_district'];
    district = json['district'];
    province = json['province'];
    zipcode = json['zipcode'];
    type = json['type'];
    userId = json['user_id'];
    courierCode = json['courier_code'];
    primaryAddress = json['primary_address'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dropoff_member_id'] = this.dropoffMemberId;
    data['card_id'] = this.cardId;
    data['origin'] = this.origin;
    data['use_label'] = this.useLabel;
    data['label_name'] = this.labelName;
    data['label_address'] = this.labelAddress;
    data['label_zipcode'] = this.labelZipcode;
    data['label_phone'] = this.labelPhone;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['sub_district'] = this.subDistrict;
    data['district'] = this.district;
    data['province'] = this.province;
    data['zipcode'] = this.zipcode;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['courier_code'] = this.courierCode;
    data['primary_address'] = this.primaryAddress;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
