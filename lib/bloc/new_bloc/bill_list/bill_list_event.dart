part of 'bill_list_bloc.dart';

abstract class BillListEvent extends Equatable {
  const BillListEvent();

  @override
  List<Object> get props => [];
}

class BillListInitialEvent extends BillListEvent {
  @override
  List<Object> get props => [];
}

class BillListFilterDateEvent extends BillListEvent {
  final DateTime start;
  final DateTime end;
  BillListFilterDateEvent({
    required this.start,
    required this.end,
  });
  @override
  List<Object> get props => [start, end];
}

class BillListSearchEvent extends BillListEvent {
  final String keyword;
  BillListSearchEvent({
    required this.keyword,
  });
  @override
  List<Object> get props => [keyword];
}
