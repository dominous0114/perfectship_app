import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfectship_app/model/address_model.dart';
import 'package:perfectship_app/model/addressfromphone_model.dart';
import 'package:perfectship_app/repository/address_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressrepository;
  AddressBloc({required this.addressrepository}) : super(AddressLoading()) {
    on<AddressInitialEvent>(_onLoadGetAddress);
    on<AddressSearchEvent>(_onSearch);
    on<AddAddressEvent>(_onAdd);
    on<EditAddressEvent>(_onEdit);
    on<SetPrimaryAddressEvent>(_onSetPrimary);
    on<DeleteAddressEvent>(_onDelete);
    on<AddressFromphoneEvent>(_ongetAddressfromphone);
    on<AddressFromphoneSearchEvent>(_onSearchphone);
  }

  void _onLoadGetAddress(
      AddressInitialEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    await addressrepository.getAddress().then((value) {
      emit(AddressLoaded(addressmodel: value));
    });
  }

  void _onSearch(AddressSearchEvent event, Emitter<AddressState> emit) async {
    await addressrepository.getAddress().then((value) {
      List<AddressModel> list = value.toList();
      list.retainWhere((element) =>
          element.name.toString().toLowerCase().contains(event.keyword) ||
          element.address.toString().toLowerCase().contains(event.keyword) ||
          element.phone.toString().toLowerCase().contains(event.keyword) ||
          element.subDistrict
              .toString()
              .toLowerCase()
              .contains(event.keyword) ||
          element.district.toString().toLowerCase().contains(event.keyword) ||
          element.province.toString().toLowerCase().contains(event.keyword) ||
          element.zipcode.toString().toLowerCase().contains(event.keyword));
      emit(AddressLoaded(addressmodel: list));
    });
  }

  void _onSearchphone(
      AddressFromphoneSearchEvent event, Emitter<AddressState> emit) async {
    await addressrepository.searchAddressphone().then((value) {
      List<AddressfromphoneModel> list = value.toList();
      list.retainWhere((element) =>
          element.phone.toString().toLowerCase().contains(event.keyword));
      emit(AddressFromphoneLoaded(addressphonemodel: list.toSet().toList()));
    });
  }

  void _onAdd(AddAddressEvent event, Emitter<AddressState> emit) async {
    print('on add bloc');
    emit(AddressLoading());
    await addressrepository
        .addAddress(
            name: event.name.text,
            phone: event.phone.text,
            address: event.address.text,
            subdistrict: event.subdistrict.text,
            district: event.district.text,
            province: event.province.text,
            zipcode: event.zipcode.text)
        .then((value) {
      event.typeahead.clear();
      event.name.clear();
      event.phone.clear();
      event.address.clear();
      event.subdistrict.clear();
      event.district.clear();
      event.province.clear();
      event.zipcode.clear();
      Fluttertoast.showToast(msg: value['message']);

      Navigator.pop(event.context);
      event.context.read<AddressBloc>().add(AddressInitialEvent());
    });
  }

  void _onEdit(EditAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    await addressrepository
        .editAddress(
            name: event.name.text,
            phone: event.phone.text,
            address: event.address.text,
            subdistrict: event.subdistrict.text,
            district: event.district.text,
            province: event.province.text,
            zipcode: event.zipcode.text,
            id: event.id)
        .then((value) {
      Fluttertoast.showToast(msg: value['message']);

      Navigator.pop(event.context);
      event.context.read<AddressBloc>().add(AddressInitialEvent());
    });
  }

  void _onSetPrimary(
      SetPrimaryAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    await addressrepository.setPrimaryAddress(id: event.id).then((value) {
      Fluttertoast.showToast(msg: value['message']);

      Navigator.pop(event.context);
      event.context.read<AddressBloc>().add(AddressInitialEvent());
    });
  }

  void _onDelete(DeleteAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    await addressrepository.deleteAddress(id: event.id).then((value) {
      Fluttertoast.showToast(msg: value['message']);
      Navigator.pop(event.context);
      event.context.read<AddressBloc>().add(AddressInitialEvent());
    });
  }

  void _ongetAddressfromphone(
      AddressFromphoneEvent event, Emitter<AddressState> emit) async {
    var response = await addressrepository.searchAddressphone();

    emit(AddressFromphoneLoaded(addressphonemodel: response));
  }

  // void _onClear() {
  //   final state = this.state;
  //   if (state is AddressLoaded) {
  //     emit(AddressLoaded(addressmodel: addressmodel))
  //   } else {
  //   }
  // }
}
