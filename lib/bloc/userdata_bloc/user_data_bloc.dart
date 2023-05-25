import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:perfectship_app/model/new_model/bank_new_model.dart';
import 'package:perfectship_app/model/src_address_model.dart';
import 'package:perfectship_app/model/usercredit_model.dart';

import 'package:perfectship_app/repository/address_repository.dart';
import 'package:perfectship_app/repository/bank_repository.dart';
import 'package:perfectship_app/repository/new_repository/bank_repository.dart';

import 'package:perfectship_app/repository/new_repository/user_data_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/bank_model.dart';
import '../../model/new_model/user_data_model.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final BankRepository bankRepository;
  final AddressRepository addressRepository;
  UserDataBloc({required this.bankRepository, required this.addressRepository}) : super(UserDataLoading()) {
    on<UserDataInitialEvent>(_onLoadGetUserdata);
    //on<UserdataAfterSendEvent>(_onLoadGetAftersenddata);
    on<UserdataOnselectBank>(_onselectBank);
    on<UserdataSelectAddressEvent>(_onselctAddress);
    on<UserIdcardUploadImageEvent>(_onUploadIdcardImage);
    on<UserBookbankUploadImageEvent>(_onUploadBookbankImage);
  }

  void _onLoadGetUserdata(UserDataInitialEvent event, Emitter<UserDataState> emit) async {
    print('on user bloc');
    await UserDataRepository().getUserData().then((value) async {
      await Bankrepository().getBanks().then((bank) => emit(UserDataLoaded(
          userdatamodel: value,
          bankModel: bank,
          accountBranchController: TextEditingController(
            text: value.branchNo,
          ),
          accountNameController: TextEditingController(text: value.accountName),
          accountNoController: TextEditingController(text: value.accountNumber),
          addressController: TextEditingController(text: value.address!.labelAddress),
          bankSelect: bank.firstWhere((element) => element.id == value.bankId),
          districtController: TextEditingController(text: value.address!.district),
          idcardController: TextEditingController(text: value.cardId),
          nameController: TextEditingController(text: value.name),
          provinceController: TextEditingController(text: value.address!.province),
          subDistrictController: TextEditingController(text: value.address!.subDistrict),
          zipcodeController: TextEditingController(text: value.address!.zipcode))));
    });
    // final rescreit = await getUserDataRepository.getUserCredit(response.userId!);
    // final responsebank = await bankRepository.getBank();

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('accountname', response.accountName!);
    // preferences.setString('accountnumber', response.accountNumber!);
    // preferences.setString('userid', response.userId!.toString());
    //final responsesrcaddress = await addressRepository.getSrcAddress();
  }

  // void _onLoadGetAftersenddata(UserdataAfterSendEvent event, Emitter<UserDataState> emit) async {
  //   emit(UserDataLoading());
  //   final response = await getUserDataRepository.getUser();
  //   final rescreit = await getUserDataRepository.getUserCredit(response.userId!);
  //   final responsebank = await bankRepository.getBank();
  //   final responsesrcaddress = await addressRepository.getSrcAddress();
  //   print('bloc res = ${response.accountName}');
  //   print('rescredit = ${rescreit.credit}');
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('accountname', response.accountName!);
  //   preferences.setString('accountnumber', response.accountNumber!);
  //   preferences.setString('userid', response.userId!.toString());

  //   emit(UserDataLoaded(srcaddressmodel: responsesrcaddress, userdatamodel: response, usercreditmodel: rescreit, bank: responsebank));
  // }

  // void _onLoadgetBankId(GetbankdataEvent event, Emitter<UserDataState> emit) {}

  void _onselectBank(UserdataOnselectBank event, Emitter<UserDataState> emit) {
    var state = this.state;
    if (state is UserDataLoaded) {
      emit(state.copyWith(bankSelect: event.bank));
    }
  }

  void _onselctAddress(UserdataSelectAddressEvent event, Emitter<UserDataState> emit) {
    var state = this.state;
    if (state is UserDataLoaded) {
      TextEditingController subdistrict = TextEditingController(text: event.subDistrict);
      TextEditingController district = TextEditingController(text: event.district);
      TextEditingController province = TextEditingController(text: event.province);
      TextEditingController zipcode = TextEditingController(text: event.zipcode);
      emit(
          state.copyWith(subDistrictController: subdistrict, districtController: district, provinceController: province, zipcodeController: zipcode));
    }
  }

  void _onUploadIdcardImage(UserIdcardUploadImageEvent event, Emitter<UserDataState> emit) {
    var state = this.state;
    if (state is UserDataLoaded) {
      UserDataModel userdata = state.userdatamodel;
      userdata.cardUrl = event.idcardUrl;
      emit(state.copyWith(userdatamodel: userdata));
    }
  }

  void _onUploadBookbankImage(UserBookbankUploadImageEvent event, Emitter<UserDataState> emit) {
    var state = this.state;
    if (state is UserDataLoaded) {
      UserDataModel userdata = state.userdatamodel;
      userdata.bookBankUrl = event.bookbankUrl;
      emit(state.copyWith(userdatamodel: userdata));
    }
  }
}
