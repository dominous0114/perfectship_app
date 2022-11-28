class BillDeatilModel {
  int? id;
  int? dropoffId;
  int? orderId;
  String? trackNo;
  String? dstName;
  String? dstPhone;
  String? price;
  String? totalPrice;
  double? remotePrice;
  double? codAmount;
  double? codFee;
  double? codVat;
  double? codNonVat;
  double? insuranceFee;
  String? vat;
  int? excludingVat;
  int? productQty;
  int? type;
  String? created;
  String? isCancel;

  BillDeatilModel(
      {this.id,
      this.dropoffId,
      this.orderId,
      this.trackNo,
      this.dstName,
      this.dstPhone,
      this.price,
      this.totalPrice,
      this.remotePrice,
      this.codAmount,
      this.codFee,
      this.codVat,
      this.codNonVat,
      this.insuranceFee,
      this.vat,
      this.excludingVat,
      this.productQty,
      this.type,
      this.created,
      this.isCancel});

  BillDeatilModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dropoffId = json['dropoff_id'];
    orderId = json['order_id'];
    trackNo = json['track_no'];
    dstName = json['dst_name'];
    dstPhone = json['dst_phone'];
    price = json['price'];
    totalPrice = json['total_price'];
    remotePrice = double.parse(json['remote_price'].toString());
    codAmount = double.parse(json['cod_amount'].toString());
    codFee = double.parse(json['cod_fee'].toString());
    codVat = double.parse(json['cod_vat'].toString());
    codNonVat = double.parse(json['cod_non_vat'].toString());
    insuranceFee = double.parse(json['insurance_fee'].toString());
    vat = json['vat'];
    excludingVat = json['excluding_vat'];
    productQty = json['product_qty'];
    type = json['type'];
    created = json['created'];
    isCancel = json['is_cancel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dropoff_id'] = this.dropoffId;
    data['order_id'] = this.orderId;
    data['track_no'] = this.trackNo;
    data['dst_name'] = this.dstName;
    data['dst_phone'] = this.dstPhone;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['remote_price'] = this.remotePrice;
    data['cod_amount'] = this.codAmount;
    data['cod_fee'] = this.codFee;
    data['cod_vat'] = this.codVat;
    data['cod_non_vat'] = this.codNonVat;
    data['insurance_fee'] = this.insuranceFee;
    data['vat'] = this.vat;
    data['excluding_vat'] = this.excludingVat;
    data['product_qty'] = this.productQty;
    data['type'] = this.type;
    data['created'] = this.created;
    data['is_cancel'] = this.isCancel;
    return data;
  }
}
