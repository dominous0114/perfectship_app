class UserDataModel {
  int? id;
  int? userId;
  int? categoryId;
  String? name;
  String? phone;
  String? password;
  String? cardId;
  var cardUrl;
  String? branchNo;
  int? bankId;
  String? accountName;
  String? accountNumber;
  var bookBankUrl;
  int? status;
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  String? bankName;
  Address? address;

  UserDataModel(
      {this.id,
      this.userId,
      this.categoryId,
      this.name,
      this.phone,
      this.password,
      this.cardId,
      this.cardUrl,
      this.branchNo,
      this.bankId,
      this.accountName,
      this.accountNumber,
      this.bookBankUrl,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.bankName,
      this.address});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    cardId = json['card_id'];
    cardUrl = json['card_url'];
    branchNo = json['branch_no'];
    bankId = json['bank_id'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bookBankUrl = json['book_bank_url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    bankName = json['bank_name'];
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['card_id'] = this.cardId;
    data['card_url'] = this.cardUrl;
    data['branch_no'] = this.branchNo;
    data['bank_id'] = this.bankId;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['book_bank_url'] = this.bookBankUrl;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['bank_name'] = this.bankName;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  int? id;
  String? name;
  String? phone;
  int? customerId;
  int? userId;
  int? type;
  String? address;
  String? subDistrict;
  String? district;
  String? province;
  String? zipcode;
  int? useLabel;
  String? labelName;
  String? labelPhone;
  String? labelAddress;
  String? labelSubDistrict;
  String? labelDistrict;
  String? labelProvince;
  String? labelZipcode;
  var courierCode;
  int? isPrimary;
  String? createdAt;
  String? updatedAt;

  Address(
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

  Address.fromJson(Map<String, dynamic> json) {
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
