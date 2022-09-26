class Banks {
  Banks({
    required this.id,
    required this.code,
    required this.name,
    this.logo,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });
  late final int id;
  late final String code;
  late final String name;
  late var logo;
  late final int status;
  late var createdAt;
  late var updatedAt;

  Banks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    logo = null;
    status = json['status'];
    createdAt = null;
    updatedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['code'] = code;
    _data['name'] = name;
    _data['logo'] = logo;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
