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
  // final UserCreditModel usercreditmodel;
  // final List<Banks> bank;
  // final SrcAddressModel srcaddressmodel;

  UserDataLoaded({
    //required this.srcaddressmodel,
    required this.userdatamodel,
    // required this.usercreditmodel,
    // required this.bank,
  });

  @override
  List<Object> get props => [
        userdatamodel,
        // usercreditmodel,
        // bank,
      ];

  UserDataLoaded copyWith({
    UserDataModel? userdatamodel,
    UserCreditModel? usercreditmodel,
    List<Banks>? bank,
    SrcAddressModel? srcaddressmodel,
  }) {
    return UserDataLoaded(
      userdatamodel: userdatamodel ?? this.userdatamodel,
      // usercreditmodel: usercreditmodel ?? this.usercreditmodel,
      // bank: bank ?? this.bank,
      // srcaddressmodel: srcaddressmodel ?? this.srcaddressmodel,
    );
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
