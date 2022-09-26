part of 'user_data_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

class UserDataLoading extends UserDataState {}

class UserDataLoaded extends UserDataState {
  final UserDataModel userdatamodel;
  final UserCreditModel usercreditmodel;
  final List<Banks> bank;
  final SrcAddressModel srcaddressmodel;
  UserDataLoaded(
      {required this.srcaddressmodel,
      required this.userdatamodel,
      required this.usercreditmodel,
      required this.bank});
  @override
  List<Object> get props => [userdatamodel, usercreditmodel, bank];
}

class UserDataLoadError extends UserDataState {
  final String error;
  UserDataLoadError({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
