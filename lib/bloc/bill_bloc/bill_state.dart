part of 'bill_bloc.dart';

abstract class BillState extends Equatable {
  const BillState();

  @override
  List<Object> get props => [];
}

class BillLoading extends BillState {}

class BillLoaded extends BillState {
  final List<BillModel> billmodel;
  BillLoaded({
    required this.billmodel,
  });
  @override
  List<Object> get props => [billmodel];
}

class billLoadError extends BillState {
  final String error;
  billLoadError({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
