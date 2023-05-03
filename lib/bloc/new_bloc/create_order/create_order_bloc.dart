import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc() : super(CreateOrderInitial()) {
    on<CreateOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
