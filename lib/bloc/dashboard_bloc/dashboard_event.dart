part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class DashboardInitialEvent extends DashboardEvent {}

class LoadDashboardEvent extends DashboardEvent {
  final DashboardStatisticModel statistic;
  final DashboardGraphModel? graph;
  final List<DashboardProvinceModel>? provinceModel;

  LoadDashboardEvent(
      {required this.statistic, this.graph, required this.provinceModel});

  @override
  // TODO: implement props
  List<Object?> get props => [statistic, graph, provinceModel];
}

class FilterDateTimeGraphEvent extends DashboardEvent {
  final start_date;
  final end_date;
  FilterDateTimeGraphEvent({
    required this.start_date,
    required this.end_date,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [start_date, end_date];
}
