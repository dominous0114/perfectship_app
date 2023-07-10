import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/new_model/user_data_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserDataRepository {
  SharedPreferences? preferences;
  Future<UserDataModel> getUserData() async {
    try {
      preferences = await SharedPreferences.getInstance();
      var token = preferences!.getString('token');
      var customerid = preferences!.getInt('customerid');
      var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
      var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/user/getdt-user'));
      request.body = json.encode({"customer_id": customerid});
      print('customer id = $customerid');
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        final json = jsonDecode(res) as Map<String, dynamic>;
        print('user data json  $json');

        UserDataModel list = UserDataModel.fromJson(json);
        return list;
      } else {
        return UserDataModel();
      }
    } catch (e) {
      print('user repository exception = =$e');
      return UserDataModel();
    }
  }

  Future updateUser(
      {required int customerid,
      required String name,
      required String cardId,
      required String cardUrl,
      required String bankId,
      required String accountName,
      required String accountNumber,
      required String branchNo,
      required String bookbankUrl,
      required String address,
      required String subDistrict,
      required String district,
      required String province,
      required String zipcode,
      required String categoryid,
      required String couriercode}) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request('POST', Uri.parse('${MyConstant().newDomain}/api/v1/user/update-user-data'));
    request.body = json.encode({
      "customer_id": customerid,
      "name": name,
      "card_id": cardId,
      "card_url": cardUrl,
      "bank_id": bankId,
      "account_name": accountName,
      "account_number": accountNumber,
      "branch_no": branchNo,
      "book_bank_url": bookbankUrl,
      "address": address,
      "sub_district": subDistrict,
      "district": district,
      "province": province,
      "zipcode": zipcode,
      "category_id": categoryid,
      "courier_code": couriercode
    });
    print('edit profile body = ${request.body}');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      print('response = ${jsonDecode(res)}');
      return jsonDecode(res);
    } else {
      var res = await response.stream.bytesToString();
      print(response.reasonPhrase);
      return jsonDecode(res);
    }
  }

  Future uploadImage({required String image, required String type}) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request('POST', Uri.parse('${MyConstant().newDomain}/api/v1/utility/upload'));
    request.bodyFields = {'image': image, 'type': type};
    request.headers.addAll(headers);

    print(request.bodyFields);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('on of');
      var res = await response.stream.bytesToString();
      print('res = $res');
      return res;
    } else {
      return response.stream.bytesToString();
    }
  }
}
