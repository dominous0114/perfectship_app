part of 'user_data_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

class UserDataLoading extends UserDataState {
  const UserDataLoading();

  @override
  List<Object> get props => [];

  UserDataLoading copyWith() {
    return const UserDataLoading();
  }
}

class UserDataLoaded extends UserDataState {
  final UserDataModel userdatamodel;
  final List<BankModel> bankModel;
  final TextEditingController nameController;
  final TextEditingController idcardController;
  final TextEditingController accountNameController;
  final TextEditingController accountNoController;
  final TextEditingController accountBranchController;
  final TextEditingController addressController;
  final TextEditingController subDistrictController;
  final TextEditingController districtController;
  final TextEditingController provinceController;
  final TextEditingController zipcodeController;
  final BankModel bankSelect;
  final List<CategoryNewModel> categories;
  final CategoryNewModel category;
  final CourierNewModel? courier;
  final List<CourierNewModel> couriers;
  UserDataLoaded({
    required this.userdatamodel,
    required this.bankModel,
    required this.nameController,
    required this.idcardController,
    required this.accountNameController,
    required this.accountNoController,
    required this.accountBranchController,
    required this.addressController,
    required this.subDistrictController,
    required this.districtController,
    required this.provinceController,
    required this.zipcodeController,
    required this.bankSelect,
    required this.category,
    required this.categories,
    required this.courier,
    required this.couriers,
  });

  @override
  List<Object> get props => [
        userdatamodel,
        bankModel,
        nameController,
        idcardController,
        accountNameController,
        accountNoController,
        accountBranchController,
        addressController,
        subDistrictController,
        districtController,
        provinceController,
        zipcodeController,
        bankSelect,
        category,
        categories,
        courier!,
        couriers

        // usercreditmodel,
        // bank,
      ];

  UserDataLoaded copyWith(
      {UserDataModel? userdatamodel,
      List<BankModel>? bankModel,
      TextEditingController? nameController,
      TextEditingController? idcardController,
      TextEditingController? accountNameController,
      TextEditingController? accountNoController,
      TextEditingController? accountBranchController,
      TextEditingController? addressController,
      TextEditingController? subDistrictController,
      TextEditingController? districtController,
      TextEditingController? provinceController,
      TextEditingController? zipcodeController,
      BankModel? bankSelect,
      List<CategoryNewModel>? categories,
      CategoryNewModel? category,
      CourierNewModel? courier,
      List<CourierNewModel>? couriers}) {
    return UserDataLoaded(
        userdatamodel: userdatamodel ?? this.userdatamodel,
        bankModel: bankModel ?? this.bankModel,
        nameController: nameController ?? this.nameController,
        idcardController: idcardController ?? this.idcardController,
        accountNameController: accountNameController ?? this.accountNameController,
        accountNoController: accountNoController ?? this.accountNoController,
        accountBranchController: accountBranchController ?? this.accountBranchController,
        addressController: addressController ?? this.addressController,
        subDistrictController: subDistrictController ?? this.subDistrictController,
        districtController: districtController ?? this.districtController,
        provinceController: provinceController ?? this.provinceController,
        zipcodeController: zipcodeController ?? this.zipcodeController,
        bankSelect: bankSelect ?? this.bankSelect,
        categories: categories ?? this.categories,
        category: category ?? this.category,
        courier: courier ?? this.courier,
        couriers: couriers ?? this.couriers);
  }
}

class UserDataLoadError extends UserDataState {
  final String error;

  UserDataLoadError({required this.error});

  @override
  List<Object> get props => [error];

  UserDataLoadError copyWith({
    String? error,
  }) {
    return UserDataLoadError(
      error: error ?? this.error,
    );
  }
}
