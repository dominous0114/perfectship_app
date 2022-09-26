import 'dart:convert';

import 'package:perfectship_app/model/courier_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constant.dart';
import 'package:http/http.dart' as http;

class CourierRepository {
  SharedPreferences? preferences;
  Future<List<CourierModel>> getCourier() async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    Uri url = Uri.parse('${MyConstant().domain}/app/get-courier-mobile');

    http.Response response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    final json = jsonDecode(response.body) as List;
    List<CourierModel> courier =
        json.map((e) => CourierModel.fromJson(e)).toList();
    return courier;
  }
}
