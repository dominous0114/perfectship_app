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
  UserDataLoaded(
      {required this.userdatamodel,
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
      required this.bankSelect});
  // final UserCreditModel usercreditmodel;
  // final List<Banks> bank;
  // final SrcAddressModel srcaddressmodel;

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
        bankSelect

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
      BankModel? bankSelect}) {
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
        bankSelect: bankSelect ?? this.bankSelect);
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
