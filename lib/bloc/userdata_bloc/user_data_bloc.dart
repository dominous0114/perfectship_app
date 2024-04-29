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

import '../../config/constant.dart';
import '../../model/bank_model.dart';
import '../../model/new_model/category_new_model.dart';
import '../../model/new_model/courier_new_model.dart';
import '../../model/new_model/user_data_model.dart';
import '../../repository/new_repository/category_repository.dart';
import '../../repository/new_repository/courier_repoitory.dart';

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
    on<UserdataSelectCategoryEvent>(_onselectCategory);
    on<UserdataSelectCourierEvent>(_onselectCourier);
  }

  void _onLoadGetUserdata(UserDataInitialEvent event, Emitter<UserDataState> emit) async {
    emit(UserDataLoading());
    print('on user bloc');
    await UserDataRepository().getUserData().then((value) async {
      await Bankrepository().getBanks().then((bank) async {
        await CategoryNewRepository().getCategory().then((cate) async {
          await CourierNewRepository().getCourierNew().then((cour) async {
            cour.removeWhere((element) => element.code == 'NoCourier');
            for (var i = 0; i < cour.length; i++) {
              if (cour[i].logo != null) {
                cour[i].logo = cour[i].logo.toString().replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
                cour[i].logoMobile = cour[i].logoMobile.toString().replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
              }
              print(cour[i].code.toString());
              print(cour[i].logo.toString());
            }
            emit(UserDataLoaded(
                category: cate.firstWhere((element) => element.id == value.categoryId, orElse: () {
                  return cate.first;
                }),
                couriers: cour,
                courier: cour.firstWhere((element) => element.code == value.address!.courierCode, orElse: () {
                  return cour.first;
                }),
                categories: cate,
                userdatamodel: value,
                bankModel: bank,
                accountBranchController: TextEditingController(
                  text: value.branchNo,
                ),
                accountNameController: TextEditingController(text: value.accountName),
                accountNoController: TextEditingController(text: value.accountNumber),
                addressController: TextEditingController(text: value.address!.labelAddress),
                bankSelect: value.bankId == 0
                    ? bank.first
                    : bank.firstWhere(
                        (element) => element.id == value.bankId,
                      ),
                districtController: TextEditingController(text: value.address!.district),
                idcardController: TextEditingController(text: value.cardId),
                nameController: TextEditingController(text: value.name),
                provinceController: TextEditingController(text: value.address!.province),
                subDistrictController: TextEditingController(text: value.address!.subDistrict),
                zipcodeController: TextEditingController(text: value.address!.zipcode)));
          });
        });
      });
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

  void _onselectCategory(UserdataSelectCategoryEvent event, Emitter<UserDataState> emit) {
    var state = this.state;
    if (state is UserDataLoaded) {
      emit(state.copyWith(category: event.categoryNewModel));
    }
  }

  void _onselectCourier(UserdataSelectCourierEvent event, Emitter<UserDataState> emit) {
    var state = this.state;
    if (state is UserDataLoaded) {
      emit(state.copyWith(courier: event.courier));
    }
  }

  void _onselctAddress(UserdataSelectAddressEvent event, Emitter<UserDataState> emit) {
    var state = this.state;
    if (state is UserDataLoaded) {
      TextEditingController subdistrict = TextEditingController(text: event.subDistrict);
      TextEditingController district = TextEditingController(text: event.district);
      TextEditingController province = TextEditingController(text: event.province);
      TextEditingController zipcode = TextEditingController(text: event.zipcode);
      emit(state.copyWith(subDistrictController: subdistrict, districtController: district, provinceController: province, zipcodeController: zipcode));
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
