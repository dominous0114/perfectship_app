import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/new_model/bank_new_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Bankrepository {
  SharedPreferences? preferences;

  Future<List<BankModel>> getBanks() async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/utility/get-bank'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as List;
      List<BankModel> bank = json.map((e) => BankModel.fromJson(e)).toList();

      return bank;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [BankModel()];
    }
  }
}
