class OrderStatusModel {
  var id;
  String? name;
  String? statusCode;
  String? color;
  String? colorCode;
  String? icon;
  var createdAt;
  var updatedAt;

  OrderStatusModel(
      {this.id,
      this.name,
      this.statusCode,
      this.color,
      this.colorCode,
      this.icon,
      this.createdAt,
      this.updatedAt});

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    statusCode = json['status_code'];
    color = json['color'];
    colorCode = json['color_code'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status_code'] = this.statusCode;
    data['color'] = this.color;
    data['color_code'] = this.colorCode;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
