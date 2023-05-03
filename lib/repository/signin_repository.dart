import 'package:perfectship_app/config/constant.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class SigninRepository {
  Future senddataSignin({required String phone, required String password, required String ref}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('${MyConstant().newDomain}/api/v1/login'));
      print(request);
      request.body = json.encode({"phone": phone, "password": password, "username": ref});
      request.headers.addAll(headers);
      print(request.body);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        print('if');
        return jsonDecode(res);
      } else {
        print('else');
        print(response.reasonPhrase);
        return 'auth fail';
      }
    } catch (e) {
      print('e = $e');
    }
  }
}
