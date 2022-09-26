part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressInitialEvent extends AddressEvent {
  @override
  List<Object> get props => [];
}

class AddressSearchEvent extends AddressEvent {
  final String keyword;
  AddressSearchEvent({
    required this.keyword,
  });
  @override
  List<Object> get props => [];
}

class AddAddressEvent extends AddressEvent {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController address;
  final TextEditingController subdistrict;
  final TextEditingController district;
  final TextEditingController province;
  final TextEditingController zipcode;
  final TextEditingController typeahead;

  final BuildContext context;
  AddAddressEvent({
    required this.typeahead,
    required this.name,
    required this.phone,
    required this.address,
    required this.subdistrict,
    required this.district,
    required this.province,
    required this.zipcode,
    required this.context,
  });
  @override
  List<Object> get props => [
        name,
        phone,
        address,
        subdistrict,
        district,
        province,
        zipcode,
        typeahead
      ];
}

class EditAddressEvent extends AddressEvent {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController address;
  final TextEditingController subdistrict;
  final TextEditingController district;
  final TextEditingController province;
  final TextEditingController zipcode;
  final String id;

  final BuildContext context;
  EditAddressEvent({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.subdistrict,
    required this.district,
    required this.province,
    required this.zipcode,
    required this.context,
  });
  @override
  List<Object> get props =>
      [name, phone, address, subdistrict, district, province, zipcode, id];
}

class SetPrimaryAddressEvent extends AddressEvent {
  final String id;
  final BuildContext context;
  SetPrimaryAddressEvent({required this.id, required this.context});
  @override
  List<Object> get props => [id, context];
}

class DeleteAddressEvent extends AddressEvent {
  final String id;
  final BuildContext context;
  DeleteAddressEvent({required this.id, required this.context});
  @override
  List<Object> get props => [id, context];
}
