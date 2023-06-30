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
  final DateTime startDate;
  final DateTime endDate;
  final DateTime focusDate;

  OrderlistNewLoaded({
    required this.orderlist,
    required this.orderlisttosearch,
    required this.statuses,
    required this.status,
    required this.couriers,
    required this.courierstosearch,
    required this.courier,
    required this.startDate,
    required this.endDate,
    required this.focusDate,
  });

  @override
  List<Object> get props => [
        orderlist,
        statuses,
        status,
        couriers,
        courier,
        orderlisttosearch,
        courierstosearch,
        startDate,
        endDate,
        focusDate,
      ];

  OrderlistNewLoaded copyWith({
    List<OrderlistNewModel>? orderlist,
    List<OrderlistNewModel>? orderlisttosearch,
    List<StatusModel>? statuses,
    StatusModel? status,
    List<CourierNewModel>? couriers,
    List<CourierNewModel>? courierstosearch,
    CourierNewModel? courier,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? focusDate,
  }) {
    return OrderlistNewLoaded(
      orderlist: orderlist ?? this.orderlist,
      orderlisttosearch: orderlisttosearch ?? this.orderlisttosearch,
      statuses: statuses ?? this.statuses,
      status: status ?? this.status,
      couriers: couriers ?? this.couriers,
      courierstosearch: courierstosearch ?? this.courierstosearch,
      courier: courier ?? this.courier,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      focusDate: focusDate ?? this.focusDate,
    );
  }
}
