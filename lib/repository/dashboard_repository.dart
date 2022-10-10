import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/dashboard_graph_model.dart';
import 'package:perfectship_app/model/dashboard_province_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/dashboard_statistic_model.dart';

class DashboardRepository {
  SharedPreferences? preferences;
  Future<DashboardGraphModel> getgraph(String start, String end) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var dropffid = preferences!.getString('dropoff_id');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${MyConstant().domain}/perfectship/dashboard-shipping-graph'));
    request.body = json.encode(
        {"dropoff_member_id": dropffid, "start_date": start, "end_date": end});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as Map;
      final newJson = json['data'];
      DashboardGraphModel list = DashboardGraphModel.fromJson(newJson);
      print(jsonDecode(res));
      return list;
    } else {
      print(response.reasonPhrase);
      return DashboardGraphModel();
    }
  }

  Future<List<DashboardProvinceModel>> getTopProvince() async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var dropffid = preferences!.getString('dropoff_id');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET',
        Uri.parse('${MyConstant().domain}/perfectship/dashboard-top-province'));
    request.body = json.encode({"dropoff_member_id": dropffid});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res)['data'] as List;
      List<DashboardProvinceModel> province =
          json.map((e) => DashboardProvinceModel.fromJson(e)).toList();

      return province;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [DashboardProvinceModel()];
    }
  }

  Future<DashboardStatisticModel> getStatic() async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var dropffid = preferences!.getString('dropoff_id');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET',
        Uri.parse('${MyConstant().domain}/perfectship/dashboard-static'));
    request.body = json.encode({"dropoff_member_id": dropffid});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as Map;
      final newJson = json['data'];
      DashboardStatisticModel list = DashboardStatisticModel.fromJson(newJson);
      print(jsonDecode(res));
      return list;
    } else {
      print(response.reasonPhrase);
      return DashboardStatisticModel();
    }
  }
}
