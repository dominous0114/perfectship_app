class DashboardProvinceModel {
  String? dstProvince;
  int? totalPack;

  DashboardProvinceModel({this.dstProvince, this.totalPack});

  DashboardProvinceModel.fromJson(Map<String, dynamic> json) {
    dstProvince = json['dst_province'];
    totalPack = json['total_pack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dst_province'] = this.dstProvince;
    data['total_pack'] = this.totalPack;
    return data;
  }
}
