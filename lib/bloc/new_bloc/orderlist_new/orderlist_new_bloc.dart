import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectship_app/model/new_model/courier_new_model.dart';
import 'package:perfectship_app/model/new_model/status_model.dart';
import 'package:perfectship_app/repository/new_repository/courier_repoitory.dart';
import 'package:perfectship_app/repository/new_repository/order_reposittory.dart';
import 'package:perfectship_app/repository/new_repository/status_repository.dart';

import '../../../model/new_model/orderlist_new_model.dart';

part 'orderlist_new_event.dart';
part 'orderlist_new_state.dart';

class OrderlistNewBloc extends Bloc<OrderlistNewEvent, OrderlistNewState> {
  OrderlistNewBloc() : super(OrderlistNewLoading()) {
    on<OrderlistNewInitialEvent>(_onInitail);
  }

  void _onInitail(OrderlistNewInitialEvent event, Emitter<OrderlistNewState> emit) async {
    List<OrderlistNewModel> orderlist = await OrderRepository().getOrder('all', 'all');
    List<StatusModel> status = await StatusRepository().getStatus();
    StatusModel allstatus = StatusModel(code: 'all', color: 'primary', id: 'all', name: 'ทั้งหมด');
    List<StatusModel> statuses = [allstatus, ...status];
    List<CourierNewModel> courier = await CourierNewRepository().getCourierAll();
    CourierNewModel allcourier = CourierNewModel(id: 'all', name: 'ทั้งหมด');
    List<CourierNewModel> couriers = [allcourier, ...courier];
  }
}
