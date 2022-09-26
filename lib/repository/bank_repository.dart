import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/bank_model.dart';
import 'package:http/http.dart' as http;

class BankRepository {
  SharedPreferences? sharePrefs;
  Future<List<Banks>> getBank() async {
    sharePrefs = await SharedPreferences.getInstance();
    var token = sharePrefs!.getString('token');
    Uri url = Uri.parse('${MyConstant().domain}/app/get-bank');

    http.Response response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    final json = jsonDecode(response.body) as List;
    List<Banks> bank = json.map((e) => Banks.fromJson(e)).toList();
    return bank;
  }

  Future updatebank(int bank_id, String branch_no, String bankurl,
      String account_name, String account_number) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var dropoff_id = int.parse(preferences.getString('dropoff_id')!);
    // var account_name = preferences.getString('accountname');
    // var account_number = preferences.getString('accountnumber');

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('${MyConstant().domain}/perfectship/update-account-bank'));
    request.body = json.encode({
      "dropoff_member_id": dropoff_id,
      "bank_id": bank_id,
      "branch_no": "$branch_no",
      "account_name": "$account_name",
      "account_number": "$account_number",
      "book_bank_url": "$bankurl"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print('request = ${request.body}');
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      return jsonDecode(res);
    } else {
      print('else');
      print(response.reasonPhrase);
      return response.reasonPhrase;
    }
  }
}
