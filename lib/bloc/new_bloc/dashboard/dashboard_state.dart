part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardNewModel dashboardNewModel;
  final DateTime startDate;
  final DateTime endDate;
  DashboardLoaded({
    required this.dashboardNewModel,
    required this.startDate,
    required this.endDate,
  });
  @override
  List<Object> get props => [dashboardNewModel];

  DashboardLoaded copyWith({
    DashboardNewModel? dashboardNewModel,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return DashboardLoaded(
      dashboardNewModel: dashboardNewModel ?? this.dashboardNewModel,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
