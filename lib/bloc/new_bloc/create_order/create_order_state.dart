part of 'create_order_bloc.dart';

abstract class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderData extends CreateOrderState {
  final String courierCode;
  final String courierImg;
  final String courierImgMobile;
  final List<CourierNewModel> courierNewModels;
  final CourierNewModel courierNewModel;
  final List<CategoryNewModel> categories;
  final CategoryNewModel category;
  final int type;
  final String labelName;
  final String labelPhone;
  final String labelAddress;
  final String labelSubDistrict;
  final String labelDistrict;
  final String labelProvince;
  final String labelZipcode;
  final String accountName;
  final String accountNumber;
  final String accountBranch;
  final String accountBank;
  final String dstName;
  final String dstPhone;
  final String dstAddress;
  final String dstSubDistrict;
  final String dstDistrict;
  final String dstProvince;
  final String dstZipcode;
  final int weight;
  final int width;
  final int length;
  final int height;
  final int codAmount;
  final String remark;
  final int isInsured;
  final int productValue;
  final int customerId;
  final int isBulky;
  final int jntPickup;
  final int kerryPickup;
  final dynamic categoryId;
  final TextEditingController srcnameController;
  final TextEditingController srcphoneController;
  final TextEditingController srcaddressController;
  final TextEditingController srcsubDistrictController;
  final TextEditingController srcdistrictController;
  final TextEditingController srcprovinceController;
  final TextEditingController srczipcodeController;
  CreateOrderData({
    required this.courierCode,
    required this.courierImg,
    required this.courierImgMobile,
    required this.courierNewModels,
    required this.courierNewModel,
    required this.categories,
    required this.category,
    required this.type,
    required this.labelName,
    required this.labelPhone,
    required this.labelAddress,
    required this.labelSubDistrict,
    required this.labelDistrict,
    required this.labelProvince,
    required this.labelZipcode,
    required this.accountName,
    required this.accountNumber,
    required this.accountBranch,
    required this.accountBank,
    required this.dstName,
    required this.dstPhone,
    required this.dstAddress,
    required this.dstSubDistrict,
    required this.dstDistrict,
    required this.dstProvince,
    required this.dstZipcode,
    required this.weight,
    required this.width,
    required this.length,
    required this.height,
    required this.codAmount,
    required this.remark,
    required this.isInsured,
    required this.productValue,
    required this.customerId,
    required this.isBulky,
    required this.jntPickup,
    required this.kerryPickup,
    required this.categoryId,
    required this.srcnameController,
    required this.srcphoneController,
    required this.srcaddressController,
    required this.srcsubDistrictController,
    required this.srcdistrictController,
    required this.srcprovinceController,
    required this.srczipcodeController,
  });

  CreateOrderData copyWith({
    String? courierCode,
    String? courierImg,
    String? courierImgMobile,
    List<CourierNewModel>? courierNewModels,
    CourierNewModel? courierNewModel,
    List<CategoryNewModel>? categories,
    CategoryNewModel? category,
    int? type,
    String? labelName,
    String? labelPhone,
    String? labelAddress,
    String? labelSubDistrict,
    String? labelDistrict,
    String? labelProvince,
    String? labelZipcode,
    String? accountName,
    String? accountNumber,
    String? accountBranch,
    String? accountBank,
    String? dstName,
    String? dstPhone,
    String? dstAddress,
    String? dstSubDistrict,
    String? dstDistrict,
    String? dstProvince,
    String? dstZipcode,
    int? weight,
    int? width,
    int? length,
    int? height,
    int? codAmount,
    String? remark,
    int? isInsured,
    int? productValue,
    int? customerId,
    int? isBulky,
    int? jntPickup,
    int? kerryPickup,
    int? categoryId,
    TextEditingController? srcnameController,
    TextEditingController? srcphoneController,
    TextEditingController? srcaddressController,
    TextEditingController? srcsubDistrictController,
    TextEditingController? srcdistrictController,
    TextEditingController? srcprovinceController,
    TextEditingController? srczipcodeController,
  }) {
    return CreateOrderData(
        courierCode: courierCode ?? this.courierCode,
        courierImg: courierImg ?? this.courierImg,
        courierImgMobile: courierImgMobile ?? this.courierImgMobile,
        courierNewModels: courierNewModels ?? this.courierNewModels,
        courierNewModel: courierNewModel ?? this.courierNewModel,
        categories: categories ?? this.categories,
        category: category ?? this.category,
        type: type ?? this.type,
        labelName: labelName ?? this.labelName,
        labelPhone: labelPhone ?? this.labelPhone,
        labelAddress: labelAddress ?? this.labelAddress,
        labelSubDistrict: labelSubDistrict ?? this.labelSubDistrict,
        labelDistrict: labelDistrict ?? this.labelDistrict,
        labelProvince: labelProvince ?? this.labelProvince,
        labelZipcode: labelZipcode ?? this.labelZipcode,
        accountName: accountName ?? this.accountName,
        accountNumber: accountNumber ?? this.accountNumber,
        accountBranch: accountBranch ?? this.accountBranch,
        accountBank: accountBank ?? this.accountBank,
        dstName: dstName ?? this.dstName,
        dstPhone: dstPhone ?? this.dstPhone,
        dstAddress: dstAddress ?? this.dstAddress,
        dstSubDistrict: dstSubDistrict ?? this.dstSubDistrict,
        dstDistrict: dstDistrict ?? this.dstDistrict,
        dstProvince: dstProvince ?? this.dstProvince,
        dstZipcode: dstZipcode ?? this.dstZipcode,
        weight: weight ?? this.weight,
        width: width ?? this.width,
        length: length ?? this.length,
        height: height ?? this.height,
        codAmount: codAmount ?? this.codAmount,
        remark: remark ?? this.remark,
        isInsured: isInsured ?? this.isInsured,
        productValue: productValue ?? this.productValue,
        customerId: customerId ?? this.customerId,
        isBulky: isBulky ?? this.isBulky,
        jntPickup: jntPickup ?? this.jntPickup,
        kerryPickup: kerryPickup ?? this.kerryPickup,
        categoryId: categoryId ?? this.categoryId,
        srcprovinceController: srcprovinceController ?? this.srcprovinceController,
        srcsubDistrictController: srcsubDistrictController ?? this.srcsubDistrictController,
        srczipcodeController: srczipcodeController ?? this.srczipcodeController,
        srcaddressController: srcaddressController ?? this.srcaddressController,
        srcdistrictController: srcdistrictController ?? this.srcdistrictController,
        srcnameController: srcnameController ?? this.srcnameController,
        srcphoneController: srcphoneController ?? this.srcphoneController);
  }

  @override
  List<Object> get props => [
        courierCode,
        courierImg,
        courierImgMobile,
        courierNewModels,
        courierNewModel,
        categories,
        category,
        type,
        labelName,
        labelPhone,
        labelAddress,
        labelSubDistrict,
        labelDistrict,
        labelProvince,
        labelZipcode,
        accountName,
        accountNumber,
        accountBranch,
        accountBank,
        dstName,
        dstPhone,
        dstAddress,
        dstSubDistrict,
        dstDistrict,
        dstProvince,
        dstZipcode,
        weight,
        width,
        length,
        height,
        codAmount,
        remark,
        isInsured,
        productValue,
        customerId,
        isBulky,
        jntPickup,
        kerryPickup,
        categoryId,
        srcnameController,
        srcphoneController,
        srcaddressController,
        srcsubDistrictController,
        srcdistrictController,
        srcprovinceController,
        srczipcodeController,
      ];
}
