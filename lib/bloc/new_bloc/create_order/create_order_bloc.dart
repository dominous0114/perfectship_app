import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/courier_model.dart';
import 'package:perfectship_app/model/new_model/category_new_model.dart';
import 'package:perfectship_app/repository/new_repository/category_repository.dart';
import 'package:perfectship_app/repository/new_repository/courier_repoitory.dart';
import 'package:perfectship_app/repository/new_repository/user_data_repository.dart';

import '../../../model/new_model/address_search_new_model.dart';
import '../../../model/new_model/courier_new_model.dart';
import '../../../model/new_model/user_data_model.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc() : super(CreateOrderInitial()) {
    on<CreateOrderInitialEvent>(_onInitial);
    on<SelectCourierEvent>(_onSelectCourier);
    on<SelectAddressManulEvent>(_onSelectAddressManualEvent);
    on<OnAddressChangeEvent>(_onChageAdress);
    on<SelectCategoryEvent>(_onSelectCategory);
    on<OnSrcAddressChangeEvent>(_onSelectSrcAddress);
  }

  Future<void> _onInitial(CreateOrderInitialEvent event, Emitter<CreateOrderState> emit) async {
    UserDataModel userdata = await UserDataRepository().getUserData();
    List<CourierNewModel> couriers = await CourierNewRepository().getCourierAll();

    List<CourierNewModel> courierActive = await CourierNewRepository().getCourierNew();
    for (var i = 0; i < courierActive.length; i++) {
      if (courierActive[i].logo != null) {
        print('on if');
        courierActive[i].logo = courierActive[i].logo.toString().replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
        courierActive[i].logoMobile = courierActive[i].logoMobile.toString().replaceAll(RegExp(r'../../..'), '${MyConstant().newDomain}');
      }
      print(courierActive[i].logo.toString());
    }
    List<CourierNewModel> courierMerge = [couriers.first, ...courierActive];

    CourierNewModel courier = couriers.firstWhere(
      (element) => element.code == userdata.address!.courierCode,
      orElse: () => CourierNewModel(),
    );

    List<CategoryNewModel> categories = await CategoryNewRepository().getCategory();
    print('user id = ${userdata.address!.userId!}');
    emit(CreateOrderData(
        courierCode: courier.code ?? '',
        courierImg: courier.logo ?? '',
        courierImgMobile: courier.logoMobile ?? '',
        courierNewModels: courierActive,
        courierNewModel: CourierNewModel(),
        categories: categories,
        category: categories.first,
        type: 2,
        labelName: userdata.address!.labelName!,
        labelPhone: userdata.address!.labelPhone!,
        labelAddress: userdata.address!.labelAddress!,
        labelSubDistrict: userdata.address!.labelSubDistrict!,
        labelDistrict: userdata.address!.labelDistrict!,
        labelProvince: userdata.address!.labelProvince!,
        labelZipcode: userdata.address!.labelZipcode!,
        accountName: userdata.accountName!,
        accountNumber: userdata.accountNumber!,
        accountBranch: userdata.branchNo!,
        accountBank: userdata.bankName!,
        dstName: '',
        dstPhone: '',
        dstAddress: '',
        dstSubDistrict: '',
        dstDistrict: '',
        dstProvince: '',
        dstZipcode: '',
        weight: 0,
        width: 0,
        length: 0,
        height: 0,
        codAmount: 0,
        remark: '',
        isInsured: 0,
        productValue: 0,
        customerId: userdata.id!,
        isBulky: 0,
        jntPickup: 6,
        kerryPickup: 1,
        categoryId: categories.first.id,
        srcaddressController: TextEditingController(text: userdata.address!.labelAddress),
        srcdistrictController: TextEditingController(text: userdata.address!.labelDistrict),
        srcnameController: TextEditingController(text: userdata.address!.labelName),
        srcphoneController: TextEditingController(text: userdata.address!.labelPhone),
        srcprovinceController: TextEditingController(text: userdata.address!.labelProvince),
        srcsubDistrictController: TextEditingController(text: userdata.address!.labelSubDistrict),
        srczipcodeController: TextEditingController(text: userdata.address!.labelZipcode)));
    print('after = ${userdata.address!.userId!}');
  }

  void _onSelectCourier(SelectCourierEvent event, Emitter<CreateOrderState> emit) async {
    var state = this.state;
    if (state is CreateOrderData) {
      if (event.courier.name.toString().contains('Bulky')) {
        print('blky condition');
        emit(state.copyWith(courierNewModel: event.courier, isBulky: 1));
        print(state.isBulky);
      } else {
        print('on select event');
        emit(state.copyWith(courierNewModel: event.courier));
      }
    }
  }

  void _onSelectAddressManualEvent(SelectAddressManulEvent event, Emitter<CreateOrderState> emit) async {
    var state = this.state;
    if (state is CreateOrderData) {
      print('on select address');
      emit(state.copyWith(
          dstDistrict: event.addressSearchNewModel.amphure,
          dstSubDistrict: event.addressSearchNewModel.district,
          dstProvince: event.addressSearchNewModel.province,
          dstZipcode: event.addressSearchNewModel.zipcode));
    }
  }

  void _onChageAdress(OnAddressChangeEvent event, Emitter<CreateOrderState> emit) async {
    var state = this.state;
    if (state is CreateOrderData) {
      emit(state.copyWith(
        dstAddress: event.address,
      ));
    }
  }

  void _onSelectCategory(SelectCategoryEvent event, Emitter<CreateOrderState> emit) {
    var state = this.state;
    if (state is CreateOrderData) {
      emit(state.copyWith(category: event.category, categoryId: event.category.id));
    }
  }

  void _onSelectSrcAddress(OnSrcAddressChangeEvent event, Emitter<CreateOrderState> emit) {
    var state = this.state;
    if (state is CreateOrderData) {
      emit(state.copyWith(
          srcsubDistrictController: TextEditingController(text: event.subDistrict),
          srcdistrictController: TextEditingController(text: event.district),
          srcprovinceController: TextEditingController(text: event.province),
          srczipcodeController: TextEditingController(text: event.zipcode)));
    }
  }
}
