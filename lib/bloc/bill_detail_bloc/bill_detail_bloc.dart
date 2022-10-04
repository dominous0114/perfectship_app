import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectship_app/model/bill_detail_mode.dart';
import 'package:perfectship_app/repository/bill_repository.dart';

part 'bill_detail_event.dart';
part 'bill_detail_state.dart';

class BillDetailBloc extends Bloc<BillDetailEvent, BillDetailState> {
  final BillRepository billRepository;
  BillDetailBloc({required this.billRepository}) : super(BillDetailLoading()) {
    on<BillDetailInitialEvent>(_onGetbillDetail);
    on<BillDetailSearchEvent>(_onSearch);
  }

  void _onGetbillDetail(
      BillDetailInitialEvent event, Emitter<BillDetailState> emit) async {
    emit(BillDetailLoading());
    var resbill = await billRepository.getBillDetail(event.id);
    emit(BillDeatilLoaded(billdetailmodel: resbill));
  }

  void _onSearch(
      BillDetailSearchEvent event, Emitter<BillDetailState> emit) async {
    await billRepository.getBillDetail(event.id).then((value) {
      List<BillDeatilModel> list = value.toList();
      list.retainWhere((element) =>
          element.trackNo.toString().toLowerCase().contains(event.keyword) ||
          element.dstName.toString().toLowerCase().contains(event.keyword) ||
          element.price.toString().toLowerCase().contains(event.keyword) ||
          element.codAmount.toString().toLowerCase().contains(event.keyword) ||
          element.codFee.toString().toLowerCase().contains(event.keyword) ||
          element.productQty.toString().toLowerCase().contains(event.keyword) ||
          element.totalPrice.toString().toLowerCase().contains(event.keyword));
      emit(BillDeatilLoaded(billdetailmodel: list));
    });
  }
}
