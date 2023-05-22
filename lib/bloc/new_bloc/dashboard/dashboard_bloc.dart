import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:perfectship_app/repository/new_repository/order_reposittory.dart';

import '../../../model/new_model/dashboard_new_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading()) {
    on<DashboardInitialEvent>(_onInitial);
  }

  void _onInitial(DashboardInitialEvent event, Emitter<DashboardState> emit) async {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime currentDay = DateTime(now.year, now.month, now.day);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String startDate = dateFormat.format(firstDayOfMonth);
    String endDate = dateFormat.format(currentDay);
    await OrderRepository().getDashboard(startDate, endDate).then((value) {
      emit(DashboardLoaded(dashboardNewModel: value));
    });
  }
}
