import 'package:perfectship_app/config/constant.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class SigninRepository {
  Future senddataSignin(
      {required String phone,
      required String password,
      required String ref}) async {
    try {
      Uri url = Uri.parse('${MyConstant().domain}/perfectship/login');
      print(url);
      var body = {"phone": phone, "password": password, "username": ref};
      print(jsonEncode(body));
      final response = await http.post(url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      if (jsonDecode(response.body)['status'] == true) {
        print(jsonDecode(response.body));
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('e = $e');
    }
  }
}
