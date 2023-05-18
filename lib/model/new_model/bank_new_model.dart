class BankModel {
  int? id;
  String? code;
  String? name;
  String? logo;

  BankModel({this.id, this.code, this.name, this.logo});

  BankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
