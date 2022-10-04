import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfectship_app/model/courier_model.dart';
import 'package:perfectship_app/model/orderstatus_model.dart';
import 'package:perfectship_app/model/track_model.dart';
import 'package:perfectship_app/repository/courier_repository.dart';
import 'package:perfectship_app/repository/order_repository.dart';
import 'package:perfectship_app/repository/track_repository.dart';

import '../../widget/fontsize.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final TrackRepository trackRepository;
  final CourierRepository courierRepository;
  final OrderRepository orderRepository;
  List<CourierModel> couriers = [];
  List<OrderStatusModel> orderstatus = [];
  TrackBloc(
      {required this.trackRepository,
      required this.courierRepository,
      required this.orderRepository})
      : super(TrackLoading()) {
    on<TrackInitialEvent>(_onLoadGetTrack);
    on<UpdateFilterEvent>(_onUpdateFilter);
    on<TrackFilterEvent>(_onFilterTrack);
    on<ResetFilterEvent>(_onResetFilter);
    on<TrackSearchEvent>(_onSearch);
    on<DeleteTrackEvent>(_onDelete);
  }

  void _onLoadGetTrack(
      TrackInitialEvent event, Emitter<TrackState> emit) async {
    DateTime _startDate = DateTime.now().subtract(Duration(days: 7));
    DateTime _endDate = DateTime.now();
    String initfirst = DateFormat('yyyy-MM-dd').format(_startDate);
    String initend = DateFormat('yyyy-MM-dd').format(_endDate);
    var orderstatusres = await orderRepository.getOrderStatus();
    var courierres = await courierRepository.getCourier();
    courierres.removeWhere((element) => element.id == 1);
    couriers = [
      CourierModel(
        id: 0,
        name: 'ทั้งหมด',
        sorting: 0,
        notifyPickup: 1,
        normalPrices: '',
        codFee: '0.00',
        insuredFee: 0,
        codMode: 0,
        code: 'all',
        logo: '',
        logoMobile: '',
        maximumCod: 99999999,
        createdCount: 0,
        createdCodCount: 0,
        status: 0,
        createdAt: '',
        updatedAt: '',
      ),
      ...courierres
    ];

    orderstatus = [
      OrderStatusModel(
          id: 'all',
          color: '',
          colorCode: '',
          createdAt: '',
          icon: '',
          name: 'ทั้งหมด',
          statusCode: 'all',
          updatedAt: ''),
      ...orderstatusres
    ];
    await trackRepository
        .getTrack(initfirst, initend, 'all', 'all', 'all')
        .then((value) {
      emit(TrackLoaded(
          statusSelected: orderstatus.first,
          ordermodel: orderstatus,
          trackmodel: value,
          courier: couriers,
          courierSelected: couriers.first));
    });
  }

  void _onFilterTrack(TrackFilterEvent event, Emitter<TrackState> emit) async {
    await trackRepository
        .getTrack(
            event.start, event.end, event.courier, event.printing, event.order)
        .then((value) {
      final state = this.state;
      if (state is TrackLoaded) {
        emit(TrackLoaded(
            statusSelected: state.statusSelected,
            ordermodel: orderstatus,
            trackmodel: value,
            courier: couriers,
            courierSelected: state.courierSelected));
      }
    });
  }

  void _onUpdateFilter(UpdateFilterEvent event, Emitter<TrackState> emit) {
    final state = this.state;
    if (state is TrackLoaded) {
      emit(TrackLoaded(
          trackmodel: state.trackmodel,
          courier: state.courier,
          ordermodel: state.ordermodel,
          courierSelected: event.courierSelected ?? state.courierSelected,
          statusSelected: event.statusSelected ?? state.statusSelected));
    }
  }

  void _onResetFilter(ResetFilterEvent event, Emitter<TrackState> emit) {
    final state = this.state;
    if (state is TrackLoaded) {
      emit(TrackLoaded(
          trackmodel: state.trackmodel,
          courier: state.courier,
          ordermodel: state.ordermodel,
          courierSelected: state.courier.first,
          statusSelected: state.ordermodel.first));
    }
  }

  void _onSearch(TrackSearchEvent event, Emitter<TrackState> emit) async {
    final state = this.state;
    if (state is TrackLoaded) {
      await trackRepository
          .getTrack(event.start, event.end, event.courier, event.printing,
              event.order)
          .then((value) {
        value.retainWhere((element) =>
            element.dstName
                .toString()
                .toLowerCase()
                .contains(event.keyword.toLowerCase()) ||
            element.dstAddress
                .toString()
                .toLowerCase()
                .contains(event.keyword.toLowerCase()) ||
            element.dstPhone
                .toString()
                .toLowerCase()
                .contains(event.keyword.toLowerCase()) ||
            element.trackNo
                .toString()
                .toLowerCase()
                .contains(event.keyword.toLowerCase()));
        emit(TrackLoaded(
            trackmodel: value,
            courier: state.courier,
            ordermodel: state.ordermodel,
            courierSelected: state.courierSelected,
            statusSelected: state.statusSelected));
      });
    }
  }

  void _onDelete(DeleteTrackEvent event, Emitter<TrackState> emit) async {
    final state = this.state;
    if (state is TrackLoaded) {
      emit(TrackLoading());
      await trackRepository
          .candelTrack(courier: event.courier_code, refcode: event.refcode)
          .whenComplete(() async {
        await trackRepository.deleteTrack(id: event.id).then((value) async {
          await trackRepository
              .getTrack(event.start, event.end, event.courier, event.printing,
                  event.order)
              .then((value) {
            value.retainWhere((element) =>
                element.dstName
                    .toString()
                    .toLowerCase()
                    .contains(event.keyword.toLowerCase()) ||
                element.dstAddress
                    .toString()
                    .toLowerCase()
                    .contains(event.keyword.toLowerCase()) ||
                element.dstPhone
                    .toString()
                    .toLowerCase()
                    .contains(event.keyword.toLowerCase()) ||
                element.trackNo
                    .toString()
                    .toLowerCase()
                    .contains(event.keyword.toLowerCase()));
            emit(TrackLoaded(
                trackmodel: value,
                courier: state.courier,
                ordermodel: state.ordermodel,
                courierSelected: state.courierSelected,
                statusSelected: state.statusSelected));
          });
          print('on then');
          Fluttertoast.showToast(msg: value['message']);
          print('after loaded');
          Navigator.pop(event.context);
        });
      });
    }
  }
}
