class UserCreditModel {
  int? orderAmount;
  double? credit;

  UserCreditModel({this.orderAmount, this.credit});

  UserCreditModel.fromJson(Map<String, dynamic> json) {
    orderAmount = json['order_amount'];
    credit = json['credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_amount'] = this.orderAmount;
    data['credit'] = this.credit;
    return data;
  }
}
