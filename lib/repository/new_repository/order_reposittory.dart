import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  SharedPreferences? preferences;
  Future createOrder({
    required String courierCode,
    required int type,
    required String labelName,
    required String labelPhone,
    required String labelAddress,
    required String labelSubDistrict,
    required String labelDistrict,
    required String labelProvince,
    required String labelZipcode,
    required String accountName,
    required String accountNumber,
    required String accountBranch,
    required String accountBank,
    required String dstName,
    required String dstPhone,
    required String dstAddress,
    required String dstSubDistrict,
    required String dstDistrict,
    required String dstProvince,
    required String dstZipcode,
    required int weight,
    required int width,
    required int length,
    required int height,
    required int codAmount,
    required String remark,
    required int isInsured,
    required int productValue,
    required int customerId,
    required int isBulky,
    required int jntPickup,
    required int kerryPickup,
    required int categoryId,
  }) async {
    try {
      var token = preferences!.getString('token');
      var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('${MyConstant().newDomain}/api/v1/order/create-order'));
      request.body = json.encode({
        "courier_code": courierCode,
        "type": type,
        "label_name": labelName,
        "label_phone": labelPhone,
        "label_address": labelAddress,
        "label_sub_district": labelSubDistrict,
        "label_district": labelDistrict,
        "label_province": labelProvince,
        "label_zipcode": labelZipcode,
        "account_name": accountName,
        "account_number": accountNumber,
        "account_branch": accountBranch,
        "account_bank": accountBank,
        "dst_name": dstName,
        "dst_phone": dstPhone,
        "dst_address": dstAddress,
        "dst_sub_district": dstSubDistrict,
        "dst_district": dstDistrict,
        "dst_province": dstProvince,
        "dst_zipcode": dstZipcode,
        "weight": weight,
        "width": width,
        "length": length,
        "height": height,
        "cod_amount": codAmount,
        "remark": remark,
        "is_insured": isInsured,
        "product_value": productValue,
        "customer_id": customerId,
        "is_bulky": isBulky,
        "jnt_pickup": jntPickup,
        "kerry_pickup": kerryPickup,
        "category_id": categoryId
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        return jsonDecode(res);
      } else {
        print(response.reasonPhrase);
        return 'fail';
      }
    } catch (e) {
      print('create order repository exception = $e');
    }
  }
}
