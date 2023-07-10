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

class UserdataOnselectBank extends UserDataEvent {
  final BankModel bank;
  UserdataOnselectBank({
    required this.bank,
  });
  @override
  List<Object> get props => [bank];
}

class UserdataSelectAddressEvent extends UserDataEvent {
  final String subDistrict;
  final String district;
  final String province;
  final String zipcode;
  UserdataSelectAddressEvent({
    required this.subDistrict,
    required this.district,
    required this.province,
    required this.zipcode,
  });
  @override
  List<Object> get props => [subDistrict, district, province, zipcode];
}

class UserIdcardUploadImageEvent extends UserDataEvent {
  final String idcardUrl;
  UserIdcardUploadImageEvent({
    required this.idcardUrl,
  });
  @override
  List<Object> get props => [idcardUrl];
}

class UserBookbankUploadImageEvent extends UserDataEvent {
  final String bookbankUrl;
  UserBookbankUploadImageEvent({
    required this.bookbankUrl,
  });
  @override
  List<Object> get props => [bookbankUrl];
}

class UserdataSelectCategoryEvent extends UserDataEvent {
  final CategoryNewModel categoryNewModel;
  UserdataSelectCategoryEvent({
    required this.categoryNewModel,
  });
}

class UserdataSelectCourierEvent extends UserDataEvent {
  final CourierNewModel courier;
  UserdataSelectCourierEvent({
    required this.courier,
  });
}

// class GetbankdataEvent extends UserDataEvent {
//   final int bankId;
//   GetbankdataEvent({
//     required this.bankId,
//   });
//   @override
//   List<Object> get props => [bankId];
// }
