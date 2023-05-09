class CategoryNewModel {
  int? id;
  String? name;
  String? nameEn;
  int? status;

  CategoryNewModel({this.id, this.name, this.nameEn, this.status});

  CategoryNewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['status'] = this.status;
    return data;
  }
}
