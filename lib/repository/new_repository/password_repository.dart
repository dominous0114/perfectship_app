import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PasswordRepository {
  SharedPreferences? preferences;
  Future updatePassword(String oldpass, String newpass, String confirempass) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var customerid = preferences!.getInt('customerid');
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.Request('POST', Uri.parse('${MyConstant().newDomain}/api/v1/user/update-password'));
    request.body = json.encode({
      "old_password": oldpass,
      "password": newpass,
      "cf_password": confirempass,
      "customer_id": customerid,
    });
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
}
