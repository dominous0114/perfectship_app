part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardStatisticModel statistic;
  final DashboardGraphModel? graph;
  final List<DashboardProvinceModel>? provinceModel;
  DashboardLoaded({
    required this.statistic,
    this.graph,
    this.provinceModel,
  });

  @override
  List<Object?> get props => [statistic, graph, provinceModel];
}

class DashboardLoadError extends DashboardState {
  final String error;
  DashboardLoadError({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
