class CourierNewModel {
  var id;
  var name;
  var sorting;
  var codFee;
  var codMode;
  var code;
  var phone;
  var isRemote;
  var isDimension;
  var isReturn;
  var isDiffPrice;
  var maxWeight;
  var maxSide;
  var maxDimension;
  var remotePercent;
  var dimensionPercent;
  var logo;
  var logoMobile;
  var status;
  var createdAt;
  var updatedAt;

  CourierNewModel(
      {this.id,
      this.name,
      this.sorting,
      this.codFee,
      this.codMode,
      this.code,
      this.phone,
      this.isRemote,
      this.isDimension,
      this.isReturn,
      this.isDiffPrice,
      this.maxWeight,
      this.maxSide,
      this.maxDimension,
      this.remotePercent,
      this.dimensionPercent,
      this.logo,
      this.logoMobile,
      this.status,
      this.createdAt,
      this.updatedAt});

  CourierNewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sorting = json['sorting'];
    codFee = json['cod_fee'];
    codMode = json['cod_mode'];
    code = json['code'];
    phone = json['phone'];
    isRemote = json['is_remote'];
    isDimension = json['is_dimension'];
    isReturn = json['is_return'];
    isDiffPrice = json['is_diff_price'];
    maxWeight = json['max_weight'];
    maxSide = json['max_side'];
    maxDimension = json['max_dimension'];
    remotePercent = json['remote_percent'];
    dimensionPercent = json['dimension_percent'];
    logo = json['logo'];
    logoMobile = json['logo_mobile'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sorting'] = this.sorting;
    data['cod_fee'] = this.codFee;
    data['cod_mode'] = this.codMode;
    data['code'] = this.code;
    data['phone'] = this.phone;
    data['is_remote'] = this.isRemote;
    data['is_dimension'] = this.isDimension;
    data['is_return'] = this.isReturn;
    data['is_diff_price'] = this.isDiffPrice;
    data['max_weight'] = this.maxWeight;
    data['max_side'] = this.maxSide;
    data['max_dimension'] = this.maxDimension;
    data['remote_percent'] = this.remotePercent;
    data['dimension_percent'] = this.dimensionPercent;
    data['logo'] = this.logo;
    data['logo_mobile'] = this.logoMobile;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
