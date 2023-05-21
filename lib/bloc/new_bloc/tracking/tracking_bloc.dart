import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectship_app/repository/new_repository/order_reposittory.dart';

import '../../../model/new_model/tracking_list_model.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  TrackingBloc() : super(TrackingLoading()) {
    on<TrackingInitialEvent>(_onGetTracking);
  }

  void _onGetTracking(TrackingInitialEvent event, Emitter<TrackingState> emit) async {
    await OrderRepository().getTrack(event.track).then((value) {
      emit(TrackingLoaded(track: value));
    });
  }
}
