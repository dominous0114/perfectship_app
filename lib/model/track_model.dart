class TrackModel {
  int? id;
  String? createdAt;
  String? dstName;
  String? dstAddress;
  String? dstZipcode;
  String? dstPhone;
  int? printCount;
  var remark;
  String? codAmount;
  String? trackNo;
  String? refCode;
  var actualWeight;
  String? shippingType;
  String? logo;
  String? logoMobile;
  String? courierCode;
  int? statusId;
  String? statusName;
  String? statusColor;
  String? icon;
  int? inBill;

  TrackModel(
      {this.id,
      this.createdAt,
      this.dstName,
      this.dstAddress,
      this.dstZipcode,
      this.dstPhone,
      this.printCount,
      this.remark,
      this.codAmount,
      this.trackNo,
      this.refCode,
      this.actualWeight,
      this.shippingType,
      this.logo,
      this.logoMobile,
      this.courierCode,
      this.statusId,
      this.statusName,
      this.statusColor,
      this.icon,
      this.inBill});

  TrackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    dstName = json['dst_name'];
    dstAddress = json['dst_address'];
    dstZipcode = json['dst_zipcode'];
    dstPhone = json['dst_phone'];
    printCount = json['print_count'];
    remark = json['remark'];
    codAmount = json['cod_amount'];
    trackNo = json['track_no'];
    refCode = json['ref_code'];
    actualWeight = json['actual_weight'];
    shippingType = json['shipping_type'];
    logo = json['logo'];
    logoMobile = json['logo_mobile'];
    courierCode = json['courier_code'];
    statusId = json['status_id'];
    statusName = json['status_name'];
    statusColor = json['status_color'];
    icon = json['icon'];
    inBill = json['in_bill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['dst_name'] = this.dstName;
    data['dst_address'] = this.dstAddress;
    data['dst_zipcode'] = this.dstZipcode;
    data['dst_phone'] = this.dstPhone;
    data['print_count'] = this.printCount;
    data['remark'] = this.remark;
    data['cod_amount'] = this.codAmount;
    data['track_no'] = this.trackNo;
    data['ref_code'] = this.refCode;
    data['actual_weight'] = this.actualWeight;
    data['shipping_type'] = this.shippingType;
    data['logo'] = this.logo;
    data['logo_mobile'] = this.logoMobile;
    data['courier_code'] = this.courierCode;
    data['status_id'] = this.statusId;
    data['status_name'] = this.statusName;
    data['status_color'] = this.statusColor;
    data['icon'] = this.icon;
    data['in_bill'] = this.inBill;
    return data;
  }
}
