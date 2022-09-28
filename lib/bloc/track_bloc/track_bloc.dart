import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectship_app/model/track_model.dart';
import 'package:perfectship_app/repository/track_repository.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final TrackRepository trackRepository;
  TrackBloc({required this.trackRepository}) : super(TrackLoading()) {
    on<TrackInitialEvent>(_onLoadGetTrack);
  }

  void _onLoadGetTrack(
      TrackInitialEvent event, Emitter<TrackState> emit) async {
    await trackRepository
        .getTrack(
            event.start, event.end, event.courier, event.printing, event.order)
        .then((value) {
      emit(TrackLoaded(trackmodel: value));
    });
  }
}
