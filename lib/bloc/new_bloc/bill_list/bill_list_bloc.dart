import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:perfectship_app/model/new_model/bill_list_new_model.dart';

import '../../../repository/new_repository/bill_repository.dart';

part 'bill_list_event.dart';
part 'bill_list_state.dart';

class BillListBloc extends Bloc<BillListEvent, BillListState> {
  BillListBloc() : super(BillListLoading()) {
    on<BillListInitialEvent>(_onInit);
    on<BillListFilterDateEvent>(_onFilterDate);
    on<BillListSearchEvent>(_onSearch);
  }

  void _onInit(BillListInitialEvent event, Emitter<BillListState> emit) async {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime currentDay = DateTime(now.year, now.month, now.day);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String startDate = dateFormat.format(firstDayOfMonth);
    String endDate = dateFormat.format(currentDay);

    try {
      final value = await BillNewRepository().getBill(startDate, endDate);
      print('bill val = $value');
      emit(BillListLoaded(billlist: value, enddate: currentDay, startdate: firstDayOfMonth));
      print('emit');
    } catch (error) {
      //emit(BillListError(message: 'An error occurred while loading bills.'));
      // ตรวจสอบและจัดการข้อผิดพลาดตามที่คุณต้องการทำ
      // เช่น emit สถานะข้อผิดพลาดพร้อมกับข้อความของข้อผิดพลาด
      print('Error: $error');
    }
  }

  void _onFilterDate(BillListFilterDateEvent event, Emitter<BillListState> emit) async {
    var state = this.state;
    if (state is BillListLoaded) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      String startDate = dateFormat.format(event.start);
      String endDate = dateFormat.format(event.end);
      await BillNewRepository().getBill(startDate, endDate).then((value) {
        emit(BillListLoaded(billlist: value, enddate: event.end, startdate: event.start));
      });
    }
  }

  void _onSearch(BillListSearchEvent event, Emitter<BillListState> emit) async {
    var state = this.state;
    if (state is BillListLoaded) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      String startDate = dateFormat.format(state.startdate);
      String endDate = dateFormat.format(state.enddate);
      await BillNewRepository().getBill(startDate, endDate).then((value) {
        value.retainWhere((element) => element.code.toString().toLowerCase().contains(event.keyword.toLowerCase()));
        emit(state.copyWith(billlist: value));
      });
    }
  }
}
