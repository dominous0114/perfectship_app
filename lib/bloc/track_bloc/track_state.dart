part of 'track_bloc.dart';

abstract class TrackState extends Equatable {
  const TrackState();

  @override
  List<Object> get props => [];
}

class TrackLoading extends TrackState {}

class TrackLoaded extends TrackState {
  final List<TrackModel> trackmodel;
  final List<CourierModel> courier;
  final List<OrderStatusModel> ordermodel;
  final CourierModel courierSelected;
  final OrderStatusModel statusSelected;
  TrackLoaded({
    required this.trackmodel,
    required this.courier,
    required this.ordermodel,
    required this.courierSelected,
    required this.statusSelected,
  });
  @override
  List<Object> get props =>
      [trackmodel, courier, courierSelected, ordermodel, statusSelected];
}

class TrackLoadError extends TrackState {
  final String error;
  TrackLoadError({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
