class DashboardNewModel {
  String? title;
  int? orderWaitShipping;
  int? successOrder;
  String? codAll;
  String? codWaiting;
  String? codSuccess;
  int? orderAll;
  int? orderOnProcess;
  int? cancelOrder;

  DashboardNewModel(
      {this.title,
      this.orderWaitShipping,
      this.successOrder,
      this.codAll,
      this.codWaiting,
      this.codSuccess,
      this.orderAll,
      this.orderOnProcess,
      this.cancelOrder});

  DashboardNewModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    orderWaitShipping = json['order_wait_shipping'];
    successOrder = json['success_order'];
    codAll = json['cod_all'];
    codWaiting = json['cod_waiting'];
    codSuccess = json['cod_success'];
    orderAll = json['order_all'];
    orderOnProcess = json['order_on_process'];
    cancelOrder = json['cancel_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['order_wait_shipping'] = this.orderWaitShipping;
    data['success_order'] = this.successOrder;
    data['cod_all'] = this.codAll;
    data['cod_waiting'] = this.codWaiting;
    data['cod_success'] = this.codSuccess;
    data['order_all'] = this.orderAll;
    data['order_on_process'] = this.orderOnProcess;
    data['cancel_order'] = this.cancelOrder;
    return data;
  }
}
