class OrderlistNewModel {
  int? id;
  String? trackNo;
  String? refCode;
  String? courierCode;
  String? labelName;
  String? labelPhone;
  String? labelAddress;
  String? labelSubDistrict;
  String? labelDistrict;
  String? labelProvince;
  String? labelZipcode;
  String? createdAt;
  String? dstName;
  String? dstPhone;
  String? dstAddress;
  String? dstSubDistrict;
  String? dstDistrict;
  String? dstProvince;
  String? dstZipcode;
  double? codAmount;
  double? codFee;
  var remark;
  int? status;
  String? statusColor;
  String? statusName;
  String? logo;
  String? logoMobile;

  OrderlistNewModel(
      {this.id,
      this.trackNo,
      this.refCode,
      this.courierCode,
      this.labelName,
      this.labelPhone,
      this.labelAddress,
      this.labelSubDistrict,
      this.labelDistrict,
      this.labelProvince,
      this.labelZipcode,
      this.createdAt,
      this.dstName,
      this.dstPhone,
      this.dstAddress,
      this.dstSubDistrict,
      this.dstDistrict,
      this.dstProvince,
      this.dstZipcode,
      this.codAmount,
      this.codFee,
      this.remark,
      this.status,
      this.statusColor,
      this.statusName,
      this.logo,
      this.logoMobile});

  OrderlistNewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackNo = json['track_no'];
    refCode = json['ref_code'];
    courierCode = json['courier_code'];
    labelName = json['label_name'];
    labelPhone = json['label_phone'];
    labelAddress = json['label_address'];
    labelSubDistrict = json['label_sub_district'];
    labelDistrict = json['label_district'];
    labelProvince = json['label_province'];
    labelZipcode = json['label_zipcode'];
    createdAt = json['created_at'];
    dstName = json['dst_name'];
    dstPhone = json['dst_phone'];
    dstAddress = json['dst_address'];
    dstSubDistrict = json['dst_sub_district'];
    dstDistrict = json['dst_district'];
    dstProvince = json['dst_province'];
    dstZipcode = json['dst_zipcode'];
    codAmount = double.parse(json['cod_amount'].toString());
    codFee = double.parse(json['cod_fee'].toString());
    remark = json['remark'];
    status = json['status'];
    statusColor = json['status_color'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['track_no'] = this.trackNo;
    data['ref_code'] = this.refCode;
    data['courier_code'] = this.courierCode;
    data['label_name'] = this.labelName;
    data['label_phone'] = this.labelPhone;
    data['label_address'] = this.labelAddress;
    data['label_sub_district'] = this.labelSubDistrict;
    data['label_district'] = this.labelDistrict;
    data['label_province'] = this.labelProvince;
    data['label_zipcode'] = this.labelZipcode;
    data['created_at'] = this.createdAt;
    data['dst_name'] = this.dstName;
    data['dst_phone'] = this.dstPhone;
    data['dst_address'] = this.dstAddress;
    data['dst_sub_district'] = this.dstSubDistrict;
    data['dst_district'] = this.dstDistrict;
    data['dst_province'] = this.dstProvince;
    data['dst_zipcode'] = this.dstZipcode;
    data['cod_amount'] = this.codAmount;
    data['cod_fee'] = this.codFee;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['status_color'] = this.statusColor;
    data['status_name'] = this.statusName;
    return data;
  }
}
