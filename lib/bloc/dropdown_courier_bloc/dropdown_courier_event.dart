part of 'dropdown_courier_bloc.dart';

abstract class DropdownCourierEvent extends Equatable {
  const DropdownCourierEvent();

  @override
  List<Object> get props => [];
}

class DropdownCourierIniitialEvent extends DropdownCourierEvent {
  // final CourierModel couriermodel;
  // final ProductCategory productCategory;
  // DropdownCourierIniitialEvent({
  //   required this.couriermodel,
  //   required this.productCategory,
  // });
  // @override
  // List<Object> get props => [couriermodel, productCategory];
}

class DropDropdownCourierSelectCourierEvent extends DropdownCourierEvent {
  final CourierModel couriermodel;
  DropDropdownCourierSelectCourierEvent({
    required this.couriermodel,
  });

  @override
  List<Object> get props => [couriermodel];
}

class DropDropdownCourierSelectCategoryEvent extends DropdownCourierEvent {
  final ProductCategory productCategory;
  DropDropdownCourierSelectCategoryEvent({
    required this.productCategory,
  });
  @override
  List<Object> get props => [productCategory];
}
