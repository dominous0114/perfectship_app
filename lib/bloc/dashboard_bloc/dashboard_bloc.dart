import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../model/dashboard_graph_model.dart';
import '../../model/dashboard_province_model.dart';
import '../../model/dashboard_statistic_model.dart';
import '../../repository/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository;
  DashboardBloc({required this.dashboardRepository})
      : super(DashboardLoading()) {
    on<DashboardInitialEvent>(_onGetDashboard);
    on<LoadDashboardEvent>(_onDasboardload);
    on<FilterDateTimeGraphEvent>(_onFilter);
  }

  void _onGetDashboard(
      DashboardInitialEvent event, Emitter<DashboardState> emit) async {
    DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
    DateTime _endDate = DateTime.now();
    String initfirst = DateFormat('yyyy-MM-dd').format(_startDate);
    String initend = DateFormat('yyyy-MM-dd').format(_endDate);
    await dashboardRepository.getgraph(initfirst, initend).then((valuegraph) {
      dashboardRepository.getStatic().then((valuestatic) {
        dashboardRepository.getTopProvince().then((valueprovince) {
          add(LoadDashboardEvent(
              statistic: valuestatic,
              provinceModel: valueprovince,
              graph: valuegraph));
        });
      });
    });
  }

  void _onDasboardload(
      LoadDashboardEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoaded(
        statistic: event.statistic,
        graph: event.graph,
        provinceModel: event.provinceModel));
  }

  void _onFilter(FilterDateTimeGraphEvent event, Emitter<DashboardState> emit) {
    final state = this.state;
    if (state is DashboardLoaded) {
      dashboardRepository
          .getgraph(event.start_date, event.end_date)
          .then((value) {
        add(LoadDashboardEvent(
            statistic: state.statistic,
            provinceModel: state.provinceModel,
            graph: value));
      });
    }
  }
}
