import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/new_model/bill_list_new_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BillNewRepository {
  SharedPreferences? preferences;

  Future<List<BillListNewModel>> getBill(String start, String end) async {
    try {
      print('new bill repo');
      preferences = await SharedPreferences.getInstance();
      var token = preferences!.getString('token');
      var customerid = preferences!.getInt('customerid');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/order/get-bill-list'));
      request.body = json.encode({
        "customer_id": customerid,
        "start_date": start,
        "end_date": end,
      });
      request.headers.addAll(headers);

      print(request.body);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print('if');
        var res = await response.stream.bytesToString();
        final json = jsonDecode(res)['data'] as List;
        List<BillListNewModel> bill = json.map((e) => BillListNewModel.fromJson(e)).toList();
        print(bill.toString());
        return bill;
      } else {
        print('else');
        print(response.reasonPhrase);
        return [BillListNewModel()];
      }
    } catch (e) {
      print('bill list exception = $e');
      return [BillListNewModel()];
    }
  }
}
