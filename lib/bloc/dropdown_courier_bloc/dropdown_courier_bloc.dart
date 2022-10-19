import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfectship_app/bloc/bill_bloc/bill_bloc.dart';
import 'package:perfectship_app/model/courier_model.dart';
import 'package:perfectship_app/model/productcategory_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/courier_repository.dart';

part 'dropdown_courier_event.dart';
part 'dropdown_courier_state.dart';

class DropdownCourierBloc
    extends Bloc<DropdownCourierEvent, DropdownCourierState> {
  DropdownCourierBloc() : super(DropdownCourierLoading()) {
    on<DropdownCourierIniitialEvent>(_onGetDropdown);
    on<DropDropdownCourierSelectCourierEvent>(_onSelectCourier);
    on<DropDropdownCourierSelectCategoryEvent>(_onSelectCategory);
  }

  void _onGetDropdown(DropdownCourierIniitialEvent event,
      Emitter<DropdownCourierState> emit) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    CourierModel? _courier;
    ProductCategory? _productCategory;
    String? courcode;
    int? procatid;

    // CourierModel courier;
    // ProductCategory productCategory;

    List<CourierModel> val = [];
    await CourierRepository().getCourier().then((value) {
      val = value;
      val.removeWhere((element) => element.id == 1);
    });
    courcode = preferences.getString('initshipping');
    procatid = preferences.getInt('initcat');
    if (courcode == null || procatid == null) {
      emit(DropdownCourierLoaded(
        courier: val,
      ));
    } else {
      _courier = val.firstWhere((element) => element.code == courcode);
      _productCategory = ProductCategory.category
          .firstWhere((element) => element.id == procatid);
      emit(DropdownCourierLoaded(
          courier: val,
          couriermodel: _courier,
          productCategory: _productCategory));
    }
  }

  void _onSelectCourier(DropDropdownCourierSelectCourierEvent event,
      Emitter<DropdownCourierState> emit) {
    List<CourierModel> val = [];
    final state = this.state;
    if (state is DropdownCourierLoaded) {
      CourierRepository().getCourier().then((value) {
        val = value;
        val.removeWhere((element) => element.id == 1);
      });
      print('bloc cour = ${event.couriermodel}');
      emit(DropdownCourierLoaded(
          couriermodel: event.couriermodel,
          productCategory: state.productCategory,
          courier: state.courier));
    }
  }

  void _onSelectCategory(DropDropdownCourierSelectCategoryEvent event,
      Emitter<DropdownCourierState> emit) {
    final state = this.state;
    if (state is DropdownCourierLoaded) {
      print('bloc cat = ${event.productCategory}');
      emit(DropdownCourierLoaded(
          couriermodel: state.couriermodel,
          productCategory: event.productCategory,
          courier: state.courier));
    }
  }
}
