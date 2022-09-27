part of 'track_bloc.dart';

abstract class TrackEvent extends Equatable {
  const TrackEvent();

  @override
  List<Object> get props => [];
}

class TrackInitialEvent extends TrackEvent {
  final String start;
  final String end;
  final String courier;
  final String printing;
  final String order;
  TrackInitialEvent({
    required this.start,
    required this.end,
    required this.courier,
    required this.printing,
    required this.order,
  });

  @override
  List<Object> get props => [start, end, courier, printing, order];
}
