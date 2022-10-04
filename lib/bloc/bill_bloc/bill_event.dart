part of 'bill_bloc.dart';

abstract class BillEvent extends Equatable {
  const BillEvent();

  @override
  List<Object> get props => [];
}

class BillInitialEvent extends BillEvent {}

class BillFilterDateEvent extends BillEvent {
  final String start;
  final String end;
  BillFilterDateEvent({
    required this.start,
    required this.end,
  });
  @override
  List<Object> get props => [start, end];
}

class BillFilterSearchEvent extends BillEvent {
  final String start;
  final String end;
  final String keyword;
  BillFilterSearchEvent({
    required this.start,
    required this.end,
    required this.keyword,
  });
  @override
  List<Object> get props => [start, end, keyword];
}
