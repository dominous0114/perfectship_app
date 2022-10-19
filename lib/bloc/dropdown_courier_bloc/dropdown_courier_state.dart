part of 'dropdown_courier_bloc.dart';

abstract class DropdownCourierState extends Equatable {
  const DropdownCourierState();

  @override
  List<Object?> get props => [];
}

class DropdownCourierLoading extends DropdownCourierState {}

class DropdownCourierLoaded extends DropdownCourierState {
  final CourierModel? couriermodel;
  final ProductCategory? productCategory;
  final List<CourierModel>? courier;
  DropdownCourierLoaded({
    this.couriermodel,
    this.productCategory,
    this.courier,
  });
  @override
  List<Object?> get props => [couriermodel, productCategory];
}

class DropDownCourierLoadError extends DropdownCourierState {
  final String error;
  DropDownCourierLoadError({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
