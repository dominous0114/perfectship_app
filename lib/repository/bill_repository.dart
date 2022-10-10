import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/bill_detail_mode.dart';
import 'package:perfectship_app/model/bill_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BillRepository {
  SharedPreferences? preferences;
  Future<List<BillModel>> getbill(String start, String end) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var dropffid = preferences!.getString('dropoff_id');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'GET', Uri.parse('${MyConstant().domain}/perfectship/get-bill-list'));
    request.body = json.encode(
        {"dropoff_member_id": dropffid, "start_date": start, "end_date": end});
    print(request.body.toString());
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res)['data'] as List;
      List<BillModel> bill = json.map((e) => BillModel.fromJson(e)).toList();

      return bill;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [BillModel()];
    }
  }

  Future<List<BillDeatilModel>> getBillDetail(String id) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET',
        Uri.parse('${MyConstant().domain}/perfectship/get-bill-detail/$id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res)['data'] as List;
      List<BillDeatilModel> billdetail =
          json.map((e) => BillDeatilModel.fromJson(e)).toList();

      return billdetail;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [BillDeatilModel()];
    }
  }

  // Future getBillforPrint(String id) async {
  //   preferences = await SharedPreferences.getInstance();
  //   var token = preferences!.getString('token');
  //   var headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json'
  //   };
  //   var request = http.Request('GET',
  //       Uri.parse('${MyConstant().domain}/perfectship/get-bill-detail/$id'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print('if');
  //     List lid = [];
  //     var res = await response.stream.bytesToString();
  //     final json = jsonDecode(res)['data'];

  //     print(lid);

  //     return json;
  //   } else {
  //     print('else');
  //     print(response.reasonPhrase);
  //     return 'fail';
  //   }
  // }
}
