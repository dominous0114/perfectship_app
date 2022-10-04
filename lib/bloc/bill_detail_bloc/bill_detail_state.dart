part of 'bill_detail_bloc.dart';

abstract class BillDetailState extends Equatable {
  const BillDetailState();

  @override
  List<Object> get props => [];
}

class BillDetailLoading extends BillDetailState {}

class BillDeatilLoaded extends BillDetailState {
  final List<BillDeatilModel> billdetailmodel;
  BillDeatilLoaded({
    required this.billdetailmodel,
  });

  @override
  // TODO: implement props
  List<Object> get props => [billdetailmodel];
}

class billDetailLoadError extends BillDetailState {
  final String error;
  billDetailLoadError({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
