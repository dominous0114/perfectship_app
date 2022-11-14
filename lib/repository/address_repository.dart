import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/address_model.dart';
import 'package:perfectship_app/model/addressfromphone_model.dart';
import 'package:perfectship_app/model/src_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/normalize_model.dart';

class AddressRepository {
  SharedPreferences? preferences;

  Future<List<AddressModel>> getAddress() async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var dropoff_id = int.parse(preferences!.getString('dropoff_id')!);
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${MyConstant().domain}/perfectship/get-user-address'));
    request.body = json.encode({"dropoff_member_id": dropoff_id});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      print('resaddress  = $res');
      final json = jsonDecode(res)['data'] as List;
      List<AddressModel> address = json.map((e) => AddressModel.fromJson(e)).toList();

      return address;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [AddressModel()];
    }
  }

  Future<SrcAddressModel> getSrcAddress() async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var userid = preferences!.getString('userid');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${MyConstant().domain}/perfectship/get-src-address'));
    request.body = json.encode({"user_id": userid});
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as Map;
      final newJson = json['data'];
      print(json['data']['id']);
      SrcAddressModel list = SrcAddressModel.fromJson(newJson);
      return list;
    } else {
      return SrcAddressModel();
    }
  }

  Future normalizeAddress(String address) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    Uri url = Uri.parse('${MyConstant().domain}/normalize/address');

    final body = {"address": address};
    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: body);

    final json = jsonDecode(response.body);
    final normalize = Normalize.fromJson(json);
    if (json['status'] == true) {
      return json;
    }
    return json;
  }

  Future addAddress(
      {required String name,
      required String phone,
      required String address,
      required String subdistrict,
      required String district,
      required String province,
      required String zipcode}) async {
    print('onrepo');
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var dropoffId = preferences!.getString('dropoff_id');
    var userId = preferences!.getString('userid');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${MyConstant().domain}/perfectship/add-address'));
    request.body = json.encode({
      "dropoff_member_id": dropoffId,
      "user_id": userId,
      "name": name,
      "phone": phone,
      "address": address,
      "sub_district": subdistrict,
      "district": district,
      "province": province,
      "zipcode": zipcode
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('on of');
      var res = await response.stream.bytesToString();
      print(res);
      return jsonDecode(res);
    } else {
      return response.stream.bytesToString();
    }
  }

  Future editAddress(
      {required String name,
      required String phone,
      required String address,
      required String subdistrict,
      required String district,
      required String province,
      required String zipcode,
      required String id}) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${MyConstant().domain}/perfectship/update-address/$id'));
    request.body = json.encode({
      "name": name,
      "phone": phone,
      "address": address,
      "sub_district": subdistrict,
      "district": district,
      "province": province,
      "zipcode": zipcode
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('on of');
      var res = await response.stream.bytesToString();
      print(res);
      return jsonDecode(res);
    } else {
      return response.stream.bytesToString();
    }
  }

  Future setPrimaryAddress({required String id}) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${MyConstant().domain}/perfectship/set-primary-address/$id'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('on of');
      var res = await response.stream.bytesToString();
      print(res);
      return jsonDecode(res);
    } else {
      return response.stream.bytesToString();
    }
  }

  Future deleteAddress({required String id}) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${MyConstant().domain}/perfectship/delete-address/$id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('on of');
      var res = await response.stream.bytesToString();
      print(res);
      return jsonDecode(res);
    } else {
      return response.stream.bytesToString();
    }
  }

  Future<List<AddressfromphoneModel>> searchAddressphone() async {
    var token = preferences!.getString('token');
    var userid = preferences!.getString('userid');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${MyConstant().domain}/perfectship/search-dst-address'));
    request.body = json.encode({"user_id": userid});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      print('resaddress  = $res');
      final json = jsonDecode(res)['data'] as List;
      List<AddressfromphoneModel> addressphone = json.map((e) => AddressfromphoneModel.fromJson(e)).toList();

      return addressphone;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [];
    }
  }
}
