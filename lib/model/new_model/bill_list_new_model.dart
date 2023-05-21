class BillListNewModel {
  int? id;
  String? code;
  int? userId;
  var employeeId;
  var employeeName;
  int? customerId;
  double? amount;
  int? discount;
  int? vat;
  int? excludingVat;
  double? totalAmount;
  int? cash;
  double? change;
  int? status;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  String? labelName;
  String? labelPhone;

  BillListNewModel(
      {this.id,
      this.code,
      this.userId,
      this.employeeId,
      this.employeeName,
      this.customerId,
      this.amount,
      this.discount,
      this.vat,
      this.excludingVat,
      this.totalAmount,
      this.cash,
      this.change,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.labelName,
      this.labelPhone});

  BillListNewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    customerId = json['customer_id'];
    amount = json['amount'];
    discount = json['discount'];
    vat = json['vat'];
    excludingVat = json['excluding_vat'];
    totalAmount = json['total_amount'];
    cash = json['cash'];
    change = json['change'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    labelName = json['label_name'];
    labelPhone = json['label_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['customer_id'] = this.customerId;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['vat'] = this.vat;
    data['excluding_vat'] = this.excludingVat;
    data['total_amount'] = this.totalAmount;
    data['cash'] = this.cash;
    data['change'] = this.change;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['label_name'] = this.labelName;
    data['label_phone'] = this.labelPhone;
    return data;
  }
}
