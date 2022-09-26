part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> addressmodel;
  AddressLoaded({
    required this.addressmodel,
  });
  @override
  // TODO: implement props
  List<Object> get props => [addressmodel];
}
