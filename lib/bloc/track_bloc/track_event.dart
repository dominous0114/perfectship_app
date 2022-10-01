part of 'track_bloc.dart';

abstract class TrackEvent extends Equatable {
  const TrackEvent();

  @override
  List<Object?> get props => [];
}

class TrackInitialEvent extends TrackEvent {
  @override
  List<Object> get props => [];
}

class TrackFilterEvent extends TrackEvent {
  final String start;
  final String end;
  final String courier;
  final String printing;
  final String order;

  TrackFilterEvent({
    required this.start,
    required this.end,
    required this.courier,
    required this.printing,
    required this.order,
  });

  @override
  List<Object> get props => [start, end, courier, printing, order];
}

class TrackSearchEvent extends TrackEvent {
  final String keyword;
  final String start;
  final String end;
  final String courier;
  final String printing;
  final String order;
  TrackSearchEvent({
    required this.keyword,
    required this.start,
    required this.end,
    required this.courier,
    required this.printing,
    required this.order,
  });
  @override
  List<Object> get props => [start, end, courier, printing, order, keyword];
}

class UpdateFilterEvent extends TrackEvent {
  final CourierModel? courierSelected;
  final OrderStatusModel? statusSelected;

  UpdateFilterEvent({this.courierSelected, this.statusSelected});

  @override
  // TODO: implement props
  List<Object?> get props => [courierSelected, statusSelected];
}

class ResetFilterEvent extends TrackEvent {}

class DeleteTrackEvent extends TrackEvent {
  final String courier_code;
  final String refcode;
  final String id;
  final BuildContext context;
  final String start;
  final String end;
  final String courier;
  final String printing;
  final String order;
  final String keyword;

  DeleteTrackEvent({
    required this.courier_code,
    required this.refcode,
    required this.id,
    required this.context,
    required this.start,
    required this.end,
    required this.courier,
    required this.printing,
    required this.order,
    required this.keyword,
  });
  @override
  List<Object> get props => [courier, refcode, id, context];
}
