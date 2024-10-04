class ProductCreateModel {
  final String productName;
  final String productPrice;
  final String productQTY;
  final String productWidth;
  final String productLength;
  final String productHeight;
  final String productColor;
  final String productWeight;
  final String productRemark;

  ProductCreateModel({
    required this.productName,
    required this.productPrice,
    required this.productQTY,
    required this.productWidth,
    required this.productLength,
    required this.productHeight,
    required this.productColor,
    required this.productWeight,
    required this.productRemark,
  });

  factory ProductCreateModel.fromJson(Map<String, dynamic> json) {
    return ProductCreateModel(
      productName: json['product_name'].toString(),
      productPrice: json['product_price'].toString(),
      productQTY: json['product_qty'].toString(),
      productWidth: json['product_width'].toString(),
      productHeight: json['product_height'].toString(),
      productColor: json['product_color'].toString(),
      productWeight: json['product_weight'].toString(),
      productLength: json['product_length'].toString(),
      productRemark: json['product_remark'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'product_price': productPrice,
      'product_qty': productQTY,
      'product_width': productWidth,
      'product_height': productHeight,
      'product_color': productColor,
      'product_weight': productWeight,
      'product_length': productLength,
      'product_remark': productRemark,
    };
  }

  List<ProductCreateModel> fromJsonList(List list) {
    return list.map((item) => ProductCreateModel.fromJson(item)).toList(); // result is List<ProductCreateModel>
  }

  ProductCreateModel copyWith({
    String? productName,
    String? productPrice,
    String? productQTY,
    String? productWidth,
    String? productLength,
    String? productHeight,
    String? productColor,
    String? productWeight,
    String? productRemark,
  }) {
    return ProductCreateModel(
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productQTY: productQTY ?? this.productQTY,
      productWidth: productWidth ?? this.productWidth,
      productLength: productLength ?? this.productLength,
      productHeight: productHeight ?? this.productHeight,
      productColor: productColor ?? this.productColor,
      productWeight: productWeight ?? this.productWeight,
      productRemark: productRemark ?? this.productRemark,
    );
  }

  @override
  String toString() {
    return 'ProductCreateModel(productName: $productName, productPrice: $productPrice, productQTY: $productQTY, productWidth: $productWidth, productLength: $productLength, productHeight: $productHeight, productColor: $productColor, productWeight: $productWeight, productRemark: $productRemark)';
  }
}
