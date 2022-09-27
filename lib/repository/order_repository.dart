import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../config/constant.dart';

class OrderRepository {
  SharedPreferences? preferences;
  Future addOrder(
      {required String courier_code,
      required String current_order,
      required String src_name,
      required String src_phone,
      required String src_district,
      required String src_amphure,
      required String src_address,
      required String src_province,
      required String src_zipcode,
      required String label_name,
      required String label_phone,
      required String label_address,
      required String label_zipcode,
      required String dst_name,
      required String dst_phone,
      required String dst_address,
      required String dst_district,
      required String dst_amphure,
      required String dst_province,
      required String dst_zipcode,
      required String account_name,
      required String account_number,
      required String account_branch,
      required String account_bank,
      required String is_insure,
      required String product_value,
      required String cod_amount,
      required String remark,
      required String issave}) async {
    double weight;
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var dropoffId = preferences!.getString('dropoff_id');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    if (courier_code == 'FlashExpressC') {
      weight = 5100;
    } else {
      weight = 1;
    }

    print('weight = $weight');

    var request =
        http.Request('POST', Uri.parse('${MyConstant().domain}/create_order'));
    request.body = json.encode({
      "courier_code": courier_code,
      "current_order": current_order,
      "dropoff_member_id": dropoffId,
      "order_type": "3",
      "src_name": src_name,
      "src_phone": src_phone,
      "src_address": src_address,
      "src_district": src_district,
      "src_amphure": src_address,
      "src_province": src_province,
      "src_zipcode": src_zipcode,
      "use_onlabel": 1,
      "label_name": label_name,
      "label_phone": label_phone,
      "label_address": label_address,
      "label_zipcode": label_zipcode,
      "dst_name": dst_name,
      "dst_phone": dst_phone,
      "dst_address": dst_address,
      "dst_district": dst_district,
      "dst_amphure": dst_amphure,
      "dst_province": dst_province,
      "dst_zipcode": dst_zipcode,
      "account_name": account_name,
      "account_number": account_number,
      "account_branch": account_branch,
      "account_bank": account_bank,
      "weight": weight,
      "width": "1",
      "length": "1",
      "height": "1",
      "is_insured": is_insure,
      "product_value": product_value,
      "cod_amount": cod_amount,
      "remark": remark,
      "save_dst_address": issave
    });
    request.headers.addAll(headers);
    print(request.body);
    print(account_number);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('on of');
      var res = await response.stream.bytesToString();
      print('res = $res');
      return jsonDecode(res);
    } else {
      return response.stream.bytesToString();
    }
  }
}
