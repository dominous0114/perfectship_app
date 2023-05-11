part of 'orderlist_new_bloc.dart';

abstract class OrderlistNewEvent extends Equatable {
  const OrderlistNewEvent();

  @override
  List<Object> get props => [];
}

class OrderlistNewInitialEvent extends OrderlistNewEvent {}
