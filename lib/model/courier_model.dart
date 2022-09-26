class CourierModel {
  int? id;
  String? name;
  int? sorting;
  int? notifyPickup;
  var normalPrices;
  String? codFee;
  int? insuredFee;
  int? codMode;
  String? code;
  String? logo;
  String? logoMobile;
  int? maximumCod;
  int? createdCount;
  int? createdCodCount;
  int? status;
  String? createdAt;
  String? updatedAt;

  CourierModel(
      {this.id,
      this.name,
      this.sorting,
      this.notifyPickup,
      this.normalPrices,
      this.codFee,
      this.insuredFee,
      this.codMode,
      this.code,
      this.logo,
      this.logoMobile,
      this.maximumCod,
      this.createdCount,
      this.createdCodCount,
      this.status,
      this.createdAt,
      this.updatedAt});

  CourierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sorting = json['sorting'];
    notifyPickup = json['notify_pickup'];
    normalPrices = json['normal_prices'];
    codFee = json['cod_fee'];
    insuredFee = json['insured_fee'];
    codMode = json['cod_mode'];
    code = json['code'];
    logo = json['logo'];
    logoMobile = json['logo_mobile'];
    maximumCod = json['maximum_cod'];
    createdCount = json['created_count'];
    createdCodCount = json['created_cod_count'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sorting'] = this.sorting;
    data['notify_pickup'] = this.notifyPickup;
    data['normal_prices'] = this.normalPrices;
    data['cod_fee'] = this.codFee;
    data['insured_fee'] = this.insuredFee;
    data['cod_mode'] = this.codMode;
    data['code'] = this.code;
    data['logo'] = this.logo;
    data['logo_mobile'] = this.logoMobile;
    data['maximum_cod'] = this.maximumCod;
    data['created_count'] = this.createdCount;
    data['created_cod_count'] = this.createdCodCount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
