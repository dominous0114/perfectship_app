class TrackingListModel {
  List<TraceLogs>? traceLogs;
  Shipping? shipping;

  TrackingListModel({this.traceLogs, this.shipping});

  TrackingListModel.fromJson(Map<String, dynamic> json) {
    if (json['trace_logs'] != null) {
      traceLogs = <TraceLogs>[];
      json['trace_logs'].forEach((v) {
        traceLogs!.add(TraceLogs.fromJson(v));
      });
    }

    print('trace = ${json['trace_logs'].toString()}');
    shipping = Shipping.fromJson(json['shipping']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.traceLogs != null) {
      data['trace_logs'] = this.traceLogs!.map((v) => v.toJson()).toList();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    return data;
  }
}

class TraceLogs {
  var id;
  String? tracking;
  String? courierCode;
  var length;
  var width;
  var height;
  var weight;
  var price;
  var codFee;
  var codAmount;
  String? statusCode;
  String? statusDesc;
  String? refCode;
  String? createdAt;
  String? updatedAt;

  TraceLogs(
      {this.id,
      this.tracking,
      this.courierCode,
      this.length,
      this.width,
      this.height,
      this.weight,
      this.price,
      this.codFee,
      this.codAmount,
      this.statusCode,
      this.statusDesc,
      this.refCode,
      this.createdAt,
      this.updatedAt});

  TraceLogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tracking = json['tracking'];
    courierCode = json['courier_code'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    weight = json['weight'];
    price = json['price'];
    codFee = json['cod_fee'];
    codAmount = json['cod_amount'];
    statusCode = json['status_code'];
    statusDesc = json['status_desc'];
    refCode = json['ref_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tracking'] = this.tracking;
    data['courier_code'] = this.courierCode;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['price'] = this.price;
    data['cod_fee'] = this.codFee;
    data['cod_amount'] = this.codAmount;
    data['status_code'] = this.statusCode;
    data['status_desc'] = this.statusDesc;
    data['ref_code'] = this.refCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Shipping {
  var id;
  var userId;
  var employeeId;
  var employeeName;
  var customerId;
  var orderId;
  var withdrawId;
  var transferId;
  String? courierCode;
  var type;
  String? shippingType;
  var isImport;
  var isBulky;
  var jntPickup;
  var kerryPickup;
  String? trackNo;
  String? refCode;
  String? srcName;
  String? srcPhone;
  String? srcAddress;
  String? srcSubDistrict;
  String? srcDistrict;
  String? srcProvince;
  String? srcZipcode;
  String? labelName;
  String? labelPhone;
  String? labelAddress;
  String? labelSubDistrict;
  String? labelDistrict;
  String? labelProvince;
  String? labelZipcode;
  String? dstName;
  String? dstPhone;
  String? dstAddress;
  String? dstSubDistrict;
  String? dstDistrict;
  String? dstProvince;
  String? dstZipcode;
  var remark;
  var width;
  var length;
  var height;
  var weight;
  var categoryId;
  var bankId;
  String? accountName;
  String? accountNumber;
  String? branchNo;
  var codAmount;
  var codFee;
  var codBalance;
  var codVat;
  var codNonVat;
  var codFeeIship;
  var codFeeShop;
  var codBalanceShop;
  var codVatShop;
  var codNonVatShop;
  var remoteArea;
  var returnFee;
  String? sortCode;
  var sortingCode;
  String? sortingLineCode;
  String? dstStoreName;
  var actualWeight;
  var actualLength;
  var actualWidth;
  var actualHeight;
  var actualPrice;
  String? remotePercent;
  String? remotePrice;
  String? dimensionPercent;
  String? dimensionPrice;
  var costPolicies;
  var shopPolicies;
  var costPrice;
  var shopPrice;
  String? customerPrice;
  var productPrice;
  var productQty;
  var productVat;
  var productExcludingVat;
  var discountShipping;
  var discountProduct;
  var amount;
  var totalAmount;
  var orderStatus;
  String? pickupDate;
  String? deliveredDate;
  var codVerified;
  var pod;
  var podDate;
  String? settelmentDate;
  var canceledDate;
  var status;
  String? statusText;
  var adminIdUpdate;
  String? createdAt;
  String? updatedAt;
  String? courierName;

  Shipping(
      {this.id,
      this.userId,
      this.employeeId,
      this.employeeName,
      this.customerId,
      this.orderId,
      this.withdrawId,
      this.transferId,
      this.courierCode,
      this.type,
      this.shippingType,
      this.isImport,
      this.isBulky,
      this.jntPickup,
      this.kerryPickup,
      this.trackNo,
      this.refCode,
      this.srcName,
      this.srcPhone,
      this.srcAddress,
      this.srcSubDistrict,
      this.srcDistrict,
      this.srcProvince,
      this.srcZipcode,
      this.labelName,
      this.labelPhone,
      this.labelAddress,
      this.labelSubDistrict,
      this.labelDistrict,
      this.labelProvince,
      this.labelZipcode,
      this.dstName,
      this.dstPhone,
      this.dstAddress,
      this.dstSubDistrict,
      this.dstDistrict,
      this.dstProvince,
      this.dstZipcode,
      this.remark,
      this.width,
      this.length,
      this.height,
      this.weight,
      this.categoryId,
      this.bankId,
      this.accountName,
      this.accountNumber,
      this.branchNo,
      this.codAmount,
      this.codFee,
      this.codBalance,
      this.codVat,
      this.codNonVat,
      this.codFeeIship,
      this.codFeeShop,
      this.codBalanceShop,
      this.codVatShop,
      this.codNonVatShop,
      this.remoteArea,
      this.returnFee,
      this.sortCode,
      this.sortingCode,
      this.sortingLineCode,
      this.dstStoreName,
      this.actualWeight,
      this.actualLength,
      this.actualWidth,
      this.actualHeight,
      this.actualPrice,
      this.remotePercent,
      this.remotePrice,
      this.dimensionPercent,
      this.dimensionPrice,
      this.costPolicies,
      this.shopPolicies,
      this.costPrice,
      this.shopPrice,
      this.customerPrice,
      this.productPrice,
      this.productQty,
      this.productVat,
      this.productExcludingVat,
      this.discountShipping,
      this.discountProduct,
      this.amount,
      this.totalAmount,
      this.orderStatus,
      this.pickupDate,
      this.deliveredDate,
      this.codVerified,
      this.pod,
      this.podDate,
      this.settelmentDate,
      this.canceledDate,
      this.status,
      this.statusText,
      this.adminIdUpdate,
      this.createdAt,
      this.updatedAt,
      this.courierName});

  Shipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    customerId = json['customer_id'];
    orderId = json['order_id'];
    withdrawId = json['withdraw_id'];
    transferId = json['transfer_id'];
    courierCode = json['courier_code'];
    type = json['type'];
    shippingType = json['shipping_type'];
    isImport = json['is_import'];
    isBulky = json['is_bulky'];
    jntPickup = json['jnt_pickup'];
    kerryPickup = json['kerry_pickup'];
    trackNo = json['track_no'];
    refCode = json['ref_code'];
    srcName = json['src_name'];
    srcPhone = json['src_phone'];
    srcAddress = json['src_address'];
    srcSubDistrict = json['src_sub_district'];
    srcDistrict = json['src_district'];
    srcProvince = json['src_province'];
    srcZipcode = json['src_zipcode'];
    labelName = json['label_name'];
    labelPhone = json['label_phone'];
    labelAddress = json['label_address'];
    labelSubDistrict = json['label_sub_district'];
    labelDistrict = json['label_district'];
    labelProvince = json['label_province'];
    labelZipcode = json['label_zipcode'];
    dstName = json['dst_name'];
    dstPhone = json['dst_phone'];
    dstAddress = json['dst_address'];
    dstSubDistrict = json['dst_sub_district'];
    dstDistrict = json['dst_district'];
    dstProvince = json['dst_province'];
    dstZipcode = json['dst_zipcode'];
    remark = json['remark'];
    width = json['width'];
    length = json['length'];
    height = json['height'];
    weight = json['weight'];
    categoryId = json['category_id'];
    bankId = json['bank_id'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    branchNo = json['branch_no'];
    codAmount = json['cod_amount'];
    codFee = json['cod_fee'];
    codBalance = json['cod_balance'];
    codVat = json['cod_vat'];
    codNonVat = json['cod_non_vat'];
    codFeeIship = json['cod_fee_iship'];
    codFeeShop = json['cod_fee_shop'];
    codBalanceShop = json['cod_balance_shop'];
    codVatShop = json['cod_vat_shop'];
    codNonVatShop = json['cod_non_vat_shop'];
    remoteArea = json['remote_area'];
    returnFee = json['return_fee'];
    sortCode = json['sortCode'];
    sortingCode = json['sortingCode'];
    sortingLineCode = json['sortingLineCode'];
    dstStoreName = json['dstStoreName'];
    actualWeight = json['actual_weight'];
    actualLength = json['actual_length'];
    actualWidth = json['actual_width'];
    actualHeight = json['actual_height'];
    actualPrice = json['actual_price'];
    remotePercent = json['remote_percent'];
    remotePrice = json['remote_price'];
    dimensionPercent = json['dimension_percent'];
    dimensionPrice = json['dimension_price'];
    costPolicies = json['cost_policies'];
    shopPolicies = json['shop_policies'];
    costPrice = json['cost_price'];
    shopPrice = json['shop_price'];
    customerPrice = json['customer_price'];
    productPrice = json['product_price'];
    productQty = json['product_qty'];
    productVat = json['product_vat'];
    productExcludingVat = json['product_excluding_vat'];
    discountShipping = json['discount_shipping'];
    discountProduct = json['discount_product'];
    amount = json['amount'];
    totalAmount = json['total_amount'];
    orderStatus = json['order_status'];
    pickupDate = json['pickup_date'];
    deliveredDate = json['delivered_date'];
    codVerified = json['cod_verified'];
    pod = json['pod'];
    podDate = json['pod_date'];
    settelmentDate = json['settelment_date'];
    canceledDate = json['canceled_date'];
    status = json['status'];
    statusText = json['status_text'];
    adminIdUpdate = json['admin_id_update'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courierName = json['courier_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['customer_id'] = this.customerId;
    data['order_id'] = this.orderId;
    data['withdraw_id'] = this.withdrawId;
    data['transfer_id'] = this.transferId;
    data['courier_code'] = this.courierCode;
    data['type'] = this.type;
    data['shipping_type'] = this.shippingType;
    data['is_import'] = this.isImport;
    data['is_bulky'] = this.isBulky;
    data['jnt_pickup'] = this.jntPickup;
    data['kerry_pickup'] = this.kerryPickup;
    data['track_no'] = this.trackNo;
    data['ref_code'] = this.refCode;
    data['src_name'] = this.srcName;
    data['src_phone'] = this.srcPhone;
    data['src_address'] = this.srcAddress;
    data['src_sub_district'] = this.srcSubDistrict;
    data['src_district'] = this.srcDistrict;
    data['src_province'] = this.srcProvince;
    data['src_zipcode'] = this.srcZipcode;
    data['label_name'] = this.labelName;
    data['label_phone'] = this.labelPhone;
    data['label_address'] = this.labelAddress;
    data['label_sub_district'] = this.labelSubDistrict;
    data['label_district'] = this.labelDistrict;
    data['label_province'] = this.labelProvince;
    data['label_zipcode'] = this.labelZipcode;
    data['dst_name'] = this.dstName;
    data['dst_phone'] = this.dstPhone;
    data['dst_address'] = this.dstAddress;
    data['dst_sub_district'] = this.dstSubDistrict;
    data['dst_district'] = this.dstDistrict;
    data['dst_province'] = this.dstProvince;
    data['dst_zipcode'] = this.dstZipcode;
    data['remark'] = this.remark;
    data['width'] = this.width;
    data['length'] = this.length;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['category_id'] = this.categoryId;
    data['bank_id'] = this.bankId;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['branch_no'] = this.branchNo;
    data['cod_amount'] = this.codAmount;
    data['cod_fee'] = this.codFee;
    data['cod_balance'] = this.codBalance;
    data['cod_vat'] = this.codVat;
    data['cod_non_vat'] = this.codNonVat;
    data['cod_fee_iship'] = this.codFeeIship;
    data['cod_fee_shop'] = this.codFeeShop;
    data['cod_balance_shop'] = this.codBalanceShop;
    data['cod_vat_shop'] = this.codVatShop;
    data['cod_non_vat_shop'] = this.codNonVatShop;
    data['remote_area'] = this.remoteArea;
    data['return_fee'] = this.returnFee;
    data['sortCode'] = this.sortCode;
    data['sortingCode'] = this.sortingCode;
    data['sortingLineCode'] = this.sortingLineCode;
    data['dstStoreName'] = this.dstStoreName;
    data['actual_weight'] = this.actualWeight;
    data['actual_length'] = this.actualLength;
    data['actual_width'] = this.actualWidth;
    data['actual_height'] = this.actualHeight;
    data['actual_price'] = this.actualPrice;
    data['remote_percent'] = this.remotePercent;
    data['remote_price'] = this.remotePrice;
    data['dimension_percent'] = this.dimensionPercent;
    data['dimension_price'] = this.dimensionPrice;
    data['cost_policies'] = this.costPolicies;
    data['shop_policies'] = this.shopPolicies;
    data['cost_price'] = this.costPrice;
    data['shop_price'] = this.shopPrice;
    data['customer_price'] = this.customerPrice;
    data['product_price'] = this.productPrice;
    data['product_qty'] = this.productQty;
    data['product_vat'] = this.productVat;
    data['product_excluding_vat'] = this.productExcludingVat;
    data['discount_shipping'] = this.discountShipping;
    data['discount_product'] = this.discountProduct;
    data['amount'] = this.amount;
    data['total_amount'] = this.totalAmount;
    data['order_status'] = this.orderStatus;
    data['pickup_date'] = this.pickupDate;
    data['delivered_date'] = this.deliveredDate;
    data['cod_verified'] = this.codVerified;
    data['pod'] = this.pod;
    data['pod_date'] = this.podDate;
    data['settelment_date'] = this.settelmentDate;
    data['canceled_date'] = this.canceledDate;
    data['status'] = this.status;
    data['status_text'] = this.statusText;
    data['admin_id_update'] = this.adminIdUpdate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['courier_name'] = this.courierName;
    return data;
  }
}
