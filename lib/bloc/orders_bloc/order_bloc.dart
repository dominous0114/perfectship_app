import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfectship_app/bloc/address_bloc/address_bloc.dart';
import 'package:perfectship_app/bloc/track_bloc/track_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/repository/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectship_app/widget/fontsize.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  OrderBloc({required this.orderRepository}) : super(OrderLoading()) {
    on<AddOrderEvent>(_onAdd);
  }

  void _onAdd(AddOrderEvent event, Emitter<OrderState> emit) async {
    await orderRepository
        .addOrder(
            courier_code: event.courier_code,
            current_order: event.current_order,
            src_name: event.src_name,
            src_phone: event.src_phone,
            src_district: event.src_district,
            src_amphure: event.src_amphure,
            src_address: event.src_address,
            src_province: event.src_province,
            src_zipcode: event.src_zipcode,
            label_name: event.label_name,
            label_phone: event.label_phone,
            label_address: event.label_address,
            label_zipcode: event.label_zipcode,
            dst_name: event.dst_name,
            dst_phone: event.dst_phone,
            dst_address: event.dst_address,
            dst_district: event.dst_district,
            dst_amphure: event.dst_amphure,
            dst_province: event.dst_province,
            dst_zipcode: event.dst_zipcode,
            account_name: event.account_name,
            account_number: event.account_number,
            account_branch: event.account_branch,
            account_bank: event.account_bank,
            is_insure: event.is_insure,
            product_value: event.product_value,
            cod_amount: event.cod_amount,
            remark: event.remark,
            issave: event.issave)
        .then((value) {
      if (value['status'] == true) {
        event.context.read<TrackBloc>().add(TrackInitialEvent());
        event.context.read<UserDataBloc>().add(UserDataInitialEvent());
        showCupertinoModalPopup(
          context: event.context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                'สร้างรายการสำเร็จ',
                style: Theme.of(event.context).textTheme.headline4!.copyWith(
                    fontSize: PlatformSize(event.context) * 1.2,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                'คุณต้องการสร้างรายการต่อหรือไม่',
                style: Theme.of(event.context).textTheme.headline4!.copyWith(
                    fontSize: PlatformSize(event.context) * 1.1,
                    fontWeight: FontWeight.normal),
              ),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(event.context);
                  },
                  child: const Text('ตกลง'),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(event.context);
                    Navigator.pop(event.context);
                  },
                  child: const Text('ไปหน้าพัสดุ'),
                ),
              ],
            );
          },
        );
      } else {
        Fluttertoast.showToast(msg: value['message']);
      }
      emit(OrderInitial());

      print(value);
    });
  }
}
