import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/new_model/status_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StatusRepository {
  SharedPreferences? preferences;
  Future<List<StatusModel>> getStatus() async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('${MyConstant().domain}/api/v1/utility/get-shipping-status'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as List;
      List<StatusModel> status = json.map((e) => StatusModel.fromJson(e)).toList();

      return status;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [StatusModel()];
    }
  }
}
