part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressLoading extends AddressState {}

class AddressFromphoneLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> addressmodel;
  AddressLoaded({
    required this.addressmodel,
  });
  @override
  // TODO: implement props
  List<Object> get props => [addressmodel];
}

class AddressFromphoneLoaded extends AddressState {
  final List<AddressfromphoneModel> addressphonemodel;
  AddressFromphoneLoaded({
    required this.addressphonemodel,
  });
  @override
  // TODO: implement props
  List<Object> get props => [addressphonemodel];
}

class AddressLoadError extends AddressState {
  final String error;
  AddressLoadError({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
