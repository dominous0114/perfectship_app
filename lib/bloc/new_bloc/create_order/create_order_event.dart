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

class OnSrcAddressChangeEvent extends CreateOrderEvent {
  final String subDistrict;
  final String district;
  final String province;
  final String zipcode;
  OnSrcAddressChangeEvent({
    required this.subDistrict,
    required this.district,
    required this.province,
    required this.zipcode,
  });

  @override
  List<Object> get props => [subDistrict, district, province, zipcode];
}
