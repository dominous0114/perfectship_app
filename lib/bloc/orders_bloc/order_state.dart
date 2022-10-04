part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {}

class OrderInitial extends OrderState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OrderLoadError extends OrderState {
  final String error;
  OrderLoadError({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
