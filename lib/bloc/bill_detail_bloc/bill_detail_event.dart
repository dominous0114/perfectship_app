part of 'bill_detail_bloc.dart';

abstract class BillDetailEvent extends Equatable {
  const BillDetailEvent();

  @override
  List<Object> get props => [];
}

class BillDetailInitialEvent extends BillDetailEvent {
  final String id;
  BillDetailInitialEvent({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}

class BillDetailSearchEvent extends BillDetailEvent {
  final String id;
  final String keyword;
  BillDetailSearchEvent({
    required this.id,
    required this.keyword,
  });
  @override
  List<Object> get props => [id, keyword];
}
