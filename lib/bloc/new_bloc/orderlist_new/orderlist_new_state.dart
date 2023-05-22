part of 'orderlist_new_bloc.dart';

abstract class OrderlistNewState extends Equatable {
  const OrderlistNewState();

  @override
  List<Object> get props => [];
}

class OrderlistNewLoading extends OrderlistNewState {}

class OrderlistNewLoaded extends OrderlistNewState {
  final List<OrderlistNewModel> orderlist;
  final List<OrderlistNewModel> orderlisttosearch;
  final List<StatusModel> statuses;
  final StatusModel status;
  final List<CourierNewModel> couriers;
  final List<CourierNewModel> courierstosearch;
  final CourierNewModel courier;

  OrderlistNewLoaded({
    required this.orderlist,
    required this.orderlisttosearch,
    required this.statuses,
    required this.status,
    required this.couriers,
    required this.courierstosearch,
    required this.courier,
  });

  @override
  List<Object> get props => [orderlist, statuses, status, couriers, courier, orderlisttosearch, courierstosearch];

  OrderlistNewLoaded copyWith({
    List<OrderlistNewModel>? orderlist,
    List<StatusModel>? statuses,
    StatusModel? status,
    List<CourierNewModel>? couriers,
    CourierNewModel? courier,
    List<OrderlistNewModel>? orderlisttosearch,
    List<CourierNewModel>? courierstosearch,
  }) {
    return OrderlistNewLoaded(
        orderlist: orderlist ?? this.orderlist,
        statuses: statuses ?? this.statuses,
        status: status ?? this.status,
        couriers: couriers ?? this.couriers,
        courier: courier ?? this.courier,
        orderlisttosearch: orderlisttosearch ?? this.orderlisttosearch,
        courierstosearch: courierstosearch ?? this.courierstosearch);
  }
}
