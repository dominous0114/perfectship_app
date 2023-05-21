part of 'tracking_bloc.dart';

abstract class TrackingState extends Equatable {
  const TrackingState();

  @override
  List<Object> get props => [];
}

class TrackingLoading extends TrackingState {}

class TrackingLoaded extends TrackingState {
  final TrackingListModel track;
  TrackingLoaded({
    required this.track,
  });
  @override
  List<Object> get props => [track];
}
