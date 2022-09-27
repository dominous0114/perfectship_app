part of 'track_bloc.dart';

abstract class TrackState extends Equatable {
  const TrackState();

  @override
  List<Object> get props => [];
}

class TrackLoading extends TrackState {}

class TrackLoaded extends TrackState {
  final List<TrackModel> trackmodel;
  TrackLoaded({
    required this.trackmodel,
  });
  @override
  List<Object> get props => [trackmodel];
}
