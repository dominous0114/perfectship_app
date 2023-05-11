class StatusModel {
  dynamic? id;
  String? code;
  String? name;
  String? color;

  StatusModel({this.id, this.code, this.name, this.color});

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}
