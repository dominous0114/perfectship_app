import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/new_model/courier_new_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CourierNewRepository {
  SharedPreferences? preferences;
  Future<List<CourierNewModel>> getCourierNew() async {
    preferences = await SharedPreferences.getInstance();
    var token = await preferences!.getString('token');
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/utility/get-courier'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as List;
      List<CourierNewModel> courier = json.map((e) => CourierNewModel.fromJson(e)).toList();

      return courier;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [CourierNewModel()];
    }
  }

  Future<List<CourierNewModel>> getCourierAll() async {
    preferences = await SharedPreferences.getInstance();
    var token = await preferences!.getString('token');
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/utility/get-courier-all'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as List;
      List<CourierNewModel> courier = json.map((e) => CourierNewModel.fromJson(e)).toList();

      return courier;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [CourierNewModel()];
    }
  }
}
