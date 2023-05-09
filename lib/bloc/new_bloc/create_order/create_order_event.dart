part of 'create_order_bloc.dart';

abstract class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderInitialEvent extends CreateOrderEvent {}

class SelectCourierEvent extends CreateOrderEvent {
  final CourierNewModel courier;
  SelectCourierEvent({
    required this.courier,
  });
  @override
  List<Object> get props => [courier];
}

class SelectAddressManulEvent extends CreateOrderEvent {
  final AddressSearchNewModel addressSearchNewModel;
  SelectAddressManulEvent({
    required this.addressSearchNewModel,
  });
  @override
  List<Object> get props => [addressSearchNewModel];
}

class OnAddressChangeEvent extends CreateOrderEvent {
  final String address;
  OnAddressChangeEvent({
    required this.address,
  });
  @override
  List<Object> get props => [address];
}

class SelectCategoryEvent extends CreateOrderEvent {
  final CategoryNewModel category;
  SelectCategoryEvent({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}
