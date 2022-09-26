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
