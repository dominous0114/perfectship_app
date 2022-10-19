part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AddOrderEvent extends OrderEvent {
  final String courier_code;
  final String current_order;
  final String src_name;
  final String src_phone;
  final String src_district;
  final String src_amphure;
  final String src_address;
  final String src_province;
  final String src_zipcode;
  final String label_name;
  final String label_phone;
  final String label_address;
  final String label_zipcode;
  final String dst_name;
  final String dst_phone;
  final String dst_address;
  final String dst_district;
  final String dst_amphure;
  final String dst_province;
  final String dst_zipcode;
  final String account_name;
  final String account_number;
  final String account_branch;
  final String account_bank;
  final String is_insure;
  final String product_value;
  final String cod_amount;
  final String remark;
  final String issave;
  final int category;
  final BuildContext context;
  AddOrderEvent(
      {required this.courier_code,
      required this.current_order,
      required this.src_name,
      required this.src_phone,
      required this.src_district,
      required this.src_amphure,
      required this.src_address,
      required this.src_province,
      required this.src_zipcode,
      required this.label_name,
      required this.label_phone,
      required this.label_address,
      required this.label_zipcode,
      required this.dst_name,
      required this.dst_phone,
      required this.dst_address,
      required this.dst_district,
      required this.dst_amphure,
      required this.dst_province,
      required this.dst_zipcode,
      required this.account_name,
      required this.account_number,
      required this.account_branch,
      required this.account_bank,
      required this.is_insure,
      required this.product_value,
      required this.cod_amount,
      required this.remark,
      required this.context,
      required this.issave,
      required this.category});

  @override
  List<Object> get props => [
        courier_code,
        current_order,
        src_name,
        src_phone,
        src_district,
        src_amphure,
        src_address,
        src_province,
        src_zipcode,
        label_name,
        label_phone,
        label_address,
        label_zipcode,
        dst_name,
        dst_phone,
        dst_address,
        dst_district,
        dst_amphure,
        dst_province,
        dst_zipcode,
        account_name,
        account_number,
        account_branch,
        account_bank,
        is_insure,
        product_value,
        cod_amount,
        remark,
        issave
      ];
}
