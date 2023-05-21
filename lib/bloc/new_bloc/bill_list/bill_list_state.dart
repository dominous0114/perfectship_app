part of 'bill_list_bloc.dart';

abstract class BillListState extends Equatable {
  const BillListState();

  @override
  List<Object> get props => [];
}

class BillListLoading extends BillListState {}

class BillListLoaded extends BillListState {
  final List<BillListNewModel> billlist;
  final DateTime startdate;
  final DateTime enddate;

  BillListLoaded({
    required this.billlist,
    required this.startdate,
    required this.enddate,
  });

  @override
  List<Object> get props => [billlist, startdate, enddate];

  BillListLoaded copyWith({
    List<BillListNewModel>? billlist,
    DateTime? startdate,
    DateTime? enddate,
  }) {
    return BillListLoaded(
      billlist: billlist ?? this.billlist,
      startdate: startdate ?? this.startdate,
      enddate: enddate ?? this.enddate,
    );
  }
}
