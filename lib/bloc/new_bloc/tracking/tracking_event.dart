part of 'tracking_bloc.dart';

abstract class TrackingEvent extends Equatable {
  const TrackingEvent();

  @override
  List<Object> get props => [];
}

class TrackingInitialEvent extends TrackingEvent {
  final String track;
  TrackingInitialEvent({
    required this.track,
  });
  @override
  List<Object> get props => [];
}
