part of 'user_data_bloc.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

class UserDataInitialEvent extends UserDataEvent {
  @override
  List<Object> get props => [];
}

class UserdataAfterSendEvent extends UserDataEvent {
  @override
  List<Object> get props => [];
}

// class GetbankdataEvent extends UserDataEvent {
//   final int bankId;
//   GetbankdataEvent({
//     required this.bankId,
//   });
//   @override
//   List<Object> get props => [bankId];
// }
