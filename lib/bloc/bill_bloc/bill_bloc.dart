import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectship_app/model/bill_model.dart';
import 'package:perfectship_app/repository/bill_repository.dart';

part 'bill_event.dart';
part 'bill_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  final BillRepository billRepository;
  BillBloc({required this.billRepository}) : super(BillLoading()) {
    on<BillInitialEvent>(_onGetbill);
    on<BillFilterDateEvent>(_onFilterdate);
    on<BillFilterSearchEvent>(_onFilterSearch);
  }

  void _onGetbill(BillInitialEvent event, Emitter<BillState> emit) async {
    DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
    DateTime _endDate = DateTime.now();
    String initfirst = DateFormat('yyyy-MM-dd').format(_startDate);
    String initend = DateFormat('yyyy-MM-dd').format(_endDate);
    var resbill = await billRepository.getbill(initfirst, initend);
    emit(BillLoaded(billmodel: resbill));
  }

  void _onFilterdate(BillFilterDateEvent event, Emitter<BillState> emit) async {
    var resbill = await billRepository.getbill(event.start, event.end);
    emit(BillLoaded(billmodel: resbill));
  }

  void _onFilterSearch(
      BillFilterSearchEvent event, Emitter<BillState> emit) async {
    await billRepository.getbill(event.start, event.end).then((value) {
      List<BillModel> list = value.toList();
      list.retainWhere((element) =>
          element.code.toString().toLowerCase().contains(event.keyword) ||
          element.customerName
              .toString()
              .toLowerCase()
              .contains(event.keyword) ||
          element.customerPhone
              .toString()
              .toLowerCase()
              .contains(event.keyword) ||
          element.totalAmount.toString().toLowerCase().contains(event.keyword));
      emit(BillLoaded(billmodel: list));
    });
  }
}
