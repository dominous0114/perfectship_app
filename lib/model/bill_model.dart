class BillModel {
  int? id;
  String? code;
  String? customerName;
  String? customerPhone;
  String? totalAmount;
  String? cash;
  String? change;
  String? created;
  int? isPrint;

  BillModel(
      {this.id,
      this.code,
      this.customerName,
      this.customerPhone,
      this.totalAmount,
      this.cash,
      this.change,
      this.created,
      this.isPrint});

  BillModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    totalAmount = json['total_amount'];
    cash = json['cash'];
    change = json['change'];
    created = json['created'];
    isPrint = json['is_print'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['total_amount'] = this.totalAmount;
    data['cash'] = this.cash;
    data['change'] = this.change;
    data['created'] = this.created;
    data['is_print'] = this.isPrint;
    return data;
  }
}
