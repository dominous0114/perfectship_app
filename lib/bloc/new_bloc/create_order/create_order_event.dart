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

class OnEditSrcDataEvent extends CreateOrderEvent {
  final String name;
  final String subDistrict;
  final String district;
  final String province;
  final String zipcode;
  final CourierNewModel courier;
  final CategoryNewModel category;
  final List<CategoryNewModel> categories;
  OnEditSrcDataEvent({
    required this.name,
    required this.subDistrict,
    required this.district,
    required this.province,
    required this.zipcode,
    required this.courier,
    required this.category,
    required this.categories,
  });
  @override
  List<Object> get props => [subDistrict, district, province, zipcode, name, category, courier, categories];
}

class OnResetDstDataEvent extends CreateOrderEvent {
  @override
  List<Object> get props => [];
}

class OnCheckBoxCodChange extends CreateOrderEvent {
  final bool isCod;
  OnCheckBoxCodChange({
    required this.isCod,
  });
  @override
  List<Object> get props => [isCod];
}

class OnCheckBoxInsureChange extends CreateOrderEvent {
  final bool isInsure;
  OnCheckBoxInsureChange({
    required this.isInsure,
  });
  @override
  List<Object> get props => [isInsure];
}

class OnRecieveSearchEvent extends CreateOrderEvent {
  final String district;
  final String subdistrict;
  final String province;
  final String zipcode;
  final String name;
  final String phone;
  final String address;
  OnRecieveSearchEvent({
    required this.district,
    required this.subdistrict,
    required this.province,
    required this.zipcode,
    required this.name,
    required this.phone,
    required this.address,
  });

  @override
  List<Object> get props => [
        district,
        subdistrict,
        province,
        zipcode,
        name,
        phone,
        address,
      ];
}
