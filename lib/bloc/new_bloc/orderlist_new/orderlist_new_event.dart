part of 'orderlist_new_bloc.dart';

abstract class OrderlistNewEvent extends Equatable {
  const OrderlistNewEvent();

  @override
  List<Object?> get props => [];
}

class OrderlistNewInitialEvent extends OrderlistNewEvent {}

class OrderlistNewSearchEvent extends OrderlistNewEvent {
  final String keywords;
  OrderlistNewSearchEvent({
    required this.keywords,
  });
  @override
  List<Object> get props => [keywords];
}

class OrderlistNewChangeCourierEvent extends OrderlistNewEvent {
  final CourierNewModel courierNewModel;
  OrderlistNewChangeCourierEvent({
    required this.courierNewModel,
  });
  @override
  List<Object> get props => [courierNewModel];
}

class OrderlistNewChangeStatusEvent extends OrderlistNewEvent {
  final StatusModel status;
  OrderlistNewChangeStatusEvent({
    required this.status,
  });
  @override
  List<Object> get props => [status];
}

class OrderlistNewFilterEvent extends OrderlistNewEvent {}

class OrderlistNewResetEvent extends OrderlistNewEvent {}

class OrderlistNewAddDateRangeEvent extends OrderlistNewEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? focusDate;
  OrderlistNewAddDateRangeEvent({
    this.startDate,
    this.endDate,
    this.focusDate,
  });
  @override
  List<Object?> get props => [startDate, endDate, focusDate];
}
