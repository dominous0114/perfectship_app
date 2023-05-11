import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/new_model/address_dst_new_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/new_model/address_search_new_model.dart';
import 'package:http/http.dart' as http;

import '../../model/new_model/normalize_model.dart';

class AddressNewRepository {
  SharedPreferences? preferences;
  Future<List<AddressSearchNewModel>> getAddress(String keyword) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/utility/search-address'));
    request.body = json.encode({"keyword": keyword});

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as List;
      List<AddressSearchNewModel> address = json.map((e) => AddressSearchNewModel.fromJson(e)).toList();

      return address;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [AddressSearchNewModel()];
    }
  }

  Future<List<AddressDstNewModel>> getDst(String keyword) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    print(token);
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/utility/search-dst'));
    request.body = json.encode({"keyword": keyword, "limit": 10});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as List;
      List<AddressDstNewModel> address = json.map((e) => AddressDstNewModel.fromJson(e)).toList();

      return address;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [AddressDstNewModel()];
    }
  }

  Future<NormalizeModel> getNormalize(String address) async {
    String normalizeText = address.split('\n').join('  \n');
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.Request('POST', Uri.parse('https://app.iship.cloud/api/normalize/address'));
    request.body = json.encode({"address": normalizeText});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as Map<String, dynamic>;
      print('normalize data = $json');

      NormalizeModel list = NormalizeModel.fromJson(json);
      return list;
    } else {
      return NormalizeModel();
    }
  }
}
