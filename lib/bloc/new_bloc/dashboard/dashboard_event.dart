part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardInitialEvent extends DashboardEvent {}

class DashboardfilterEvent extends DashboardEvent {
  final DateTime startDate;
  final DateTime endDate;
  DashboardfilterEvent({
    required this.startDate,
    required this.endDate,
  });
  @override
  List<Object> get props => [startDate, endDate];
}
