part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardNewModel dashboardNewModel;
  DashboardLoaded({
    required this.dashboardNewModel,
  });

  @override
  List<Object> get props => [dashboardNewModel];
}
