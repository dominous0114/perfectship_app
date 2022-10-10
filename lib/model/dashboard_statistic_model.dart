class DashboardStatisticModel {
  int? waiting;
  int? shiped;
  int? cod;

  DashboardStatisticModel({this.waiting, this.shiped, this.cod});

  DashboardStatisticModel.fromJson(Map<String, dynamic> json) {
    waiting = json['waiting'];
    shiped = json['shiped'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['waiting'] = this.waiting;
    data['shiped'] = this.shiped;
    data['cod'] = this.cod;
    return data;
  }
}
