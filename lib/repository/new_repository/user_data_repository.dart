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
      print('customer id =$customerid');
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
}
