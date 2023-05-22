import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectship_app/model/new_model/courier_new_model.dart';
import 'package:perfectship_app/model/new_model/status_model.dart';
import 'package:perfectship_app/repository/new_repository/courier_repoitory.dart';
import 'package:perfectship_app/repository/new_repository/order_reposittory.dart';
import 'package:perfectship_app/repository/new_repository/status_repository.dart';

import '../../../config/constant.dart';
import '../../../model/new_model/orderlist_new_model.dart';

part 'orderlist_new_event.dart';
part 'orderlist_new_state.dart';

class OrderlistNewBloc extends Bloc<OrderlistNewEvent, OrderlistNewState> {
  OrderlistNewBloc() : super(OrderlistNewLoading()) {
    on<OrderlistNewInitialEvent>(_onInitail);
    on<OrderlistNewSearchEvent>(_onSearch);
    on<OrderlistNewChangeCourierEvent>(_onChangeCourier);
    on<OrderlistNewChangeStatusEvent>(_onChangeStatus);
    on<OrderlistNewFilterEvent>(_onFilter);
    on<OrderlistNewResetEvent>(_onReset);
  }

  void _onInitail(OrderlistNewInitialEvent event, Emitter<OrderlistNewState> emit) async {
    List<OrderlistNewModel> orderlist = await OrderRepository().getOrder('all', 'all');
    List<StatusModel> status = await StatusRepository().getStatus();
    StatusModel allstatus = StatusModel(code: 'all', color: 'primary', id: 'all', name: 'ทั้งหมด');
    List<StatusModel> statuses = [allstatus, ...status];
    List<CourierNewModel> courier = await CourierNewRepository().getCourierAll();
    courier.removeAt(0);
    CourierNewModel allcourier = CourierNewModel(id: 'all', name: 'ทั้งหมด', code: 'all');
    List<CourierNewModel> couriers = [allcourier, ...courier];
    List<OrderlistNewModel> ordermap = orderlist;
    for (var i = 0; i < ordermap.length; i++) {
      ordermap[i].logo = couriers
          .firstWhere((element) => element.code == ordermap[i].courierCode)
          .logo
          .toString()
          .replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
      ordermap[i].logoMobile = couriers
          .firstWhere((element) => element.code == ordermap[i].courierCode)
          .logoMobile
          .toString()
          .replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
    }

    for (var i = 0; i < couriers.length; i++) {
      if (couriers[i].logo != null) {
        print('on if');
        couriers[i].logo = couriers[i].logo.toString().replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
        couriers[i].logoMobile = couriers[i].logoMobile.toString().replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
      }
      print(couriers[i].logo.toString());
    }

    ordermap.sort(
      (a, b) => b.createdAt!.compareTo(a.createdAt!),
    );
    print('emit');
    emit(OrderlistNewLoaded(
        orderlist: ordermap,
        statuses: statuses,
        status: statuses.first,
        couriers: couriers,
        courier: couriers.first,
        orderlisttosearch: ordermap,
        courierstosearch: couriers));
  }

  void _onSearch(OrderlistNewSearchEvent event, Emitter<OrderlistNewState> emit) async {
    var state = this.state;
    if (state is OrderlistNewLoaded) {
      print(state.orderlisttosearch.length);
      List<OrderlistNewModel> orders = List.from(state.orderlisttosearch); // Create a new list

      List<CourierNewModel> courier = List.from(state.courierstosearch);
      for (var i = 0; i < orders.length; i++) {
        orders[i].logo = courier
            .firstWhere((element) => element.code == orders[i].courierCode)
            .logo
            .toString()
            .replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
        orders[i].logoMobile = courier
            .firstWhere((element) => element.code == orders[i].courierCode)
            .logoMobile
            .toString()
            .replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
      }
      orders.sort(
        (a, b) => b.createdAt!.compareTo(a.createdAt!),
      );

      orders.retainWhere((element) =>
          element.dstName.toString().toLowerCase().contains(event.keywords.toLowerCase()) ||
          element.dstAddress.toString().toLowerCase().contains(event.keywords.toLowerCase()) ||
          element.dstPhone.toString().toLowerCase().contains(event.keywords.toLowerCase()) ||
          element.trackNo.toString().toLowerCase().contains(event.keywords.toLowerCase()));
      print('order ${orders.length}');
      print('list to search ${state.orderlisttosearch.length}');
      print('list ${state.orderlist.length}');
      emit(state.copyWith(orderlist: orders)); // Emit the modified state with the new list
    }
  }

  void _onChangeCourier(OrderlistNewChangeCourierEvent event, Emitter<OrderlistNewState> emit) {
    var state = this.state;
    if (state is OrderlistNewLoaded) {
      emit(state.copyWith(courier: event.courierNewModel));
    }
  }

  void _onChangeStatus(OrderlistNewChangeStatusEvent event, Emitter<OrderlistNewState> emit) {
    var state = this.state;
    if (state is OrderlistNewLoaded) {
      emit(state.copyWith(status: event.status));
    }
  }

  void _onFilter(OrderlistNewFilterEvent event, Emitter<OrderlistNewState> emit) async {
    var state = this.state;
    if (state is OrderlistNewLoaded) {
      List<OrderlistNewModel> orderlist = await OrderRepository().getOrder(state.courier.code.toString(), state.status.id);
      List<CourierNewModel> courier = await CourierNewRepository().getCourierAll();

      for (var i = 0; i < orderlist.length; i++) {
        orderlist[i].logo = courier
            .firstWhere((element) => element.code == orderlist[i].courierCode)
            .logo
            .toString()
            .replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
        orderlist[i].logoMobile = courier
            .firstWhere((element) => element.code == orderlist[i].courierCode)
            .logoMobile
            .toString()
            .replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
      }

      orderlist.sort(
        (a, b) => b.createdAt!.compareTo(a.createdAt!),
      );
      emit(state.copyWith(orderlist: orderlist));
    }
  }

  void _onReset(OrderlistNewResetEvent event, Emitter<OrderlistNewState> emit) async {
    var state = this.state;
    if (state is OrderlistNewLoaded) {
      add(OrderlistNewInitialEvent());
    }
  }
}
