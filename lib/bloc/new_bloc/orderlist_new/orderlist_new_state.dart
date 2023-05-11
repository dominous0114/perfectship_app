part of 'orderlist_new_bloc.dart';

abstract class OrderlistNewState extends Equatable {
  const OrderlistNewState();

  @override
  List<Object> get props => [];
}

class OrderlistNewLoading extends OrderlistNewState {}

class OrderlistNewLoaded extends OrderlistNewState {
  final List<OrderlistNewModel> orderlist;
  final List<StatusModel> statuses;
  final StatusModel status;
  final List<CourierNewModel> couriers;
  final CourierNewModel courier;

  OrderlistNewLoaded({
    required this.orderlist,
    required this.statuses,
    required this.status,
    required this.couriers,
    required this.courier,
  });

  @override
  List<Object> get props => [orderlist, statuses, status, couriers, courier];

  OrderlistNewLoaded copyWith({
    List<OrderlistNewModel>? orderlist,
    List<StatusModel>? statuses,
    StatusModel? status,
    List<CourierNewModel>? couriers,
    CourierNewModel? courier,
  }) {
    return OrderlistNewLoaded(
      orderlist: orderlist ?? this.orderlist,
      statuses: statuses ?? this.statuses,
      status: status ?? this.status,
      couriers: couriers ?? this.couriers,
      courier: courier ?? this.courier,
    );
  }
}
