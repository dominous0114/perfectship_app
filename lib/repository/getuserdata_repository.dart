import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../config/constant.dart';
import '../model/usercredit_model.dart';

class GetUserDataRepository {
  // Future<UserDataModel> getUser() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var token = preferences.getString('token');
  //   var dropoff_id = preferences.getString('dropoff_id');
  //   var request = http.Request('GET', Uri.parse('${MyConstant().domain}/perfectship/get-user-data'));
  //   request.body = json.encode({"dropoff_member_id": dropoff_id});
  //   request.headers.addAll({'Content-Type': 'application/json', 'Authorization': 'Bearer $token'});

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     var res = await response.stream.bytesToString();
  //     final json = jsonDecode(res) as Map;
  //     final newJson = json['data'];
  //     UserDataModel list = UserDataModel.fromJson(newJson);
  //     print(jsonDecode(res));
  //     return list;
  //   } else {
  //     print(response.reasonPhrase);
  //     return UserDataModel();
  //   }
  // }

  Future<UserCreditModel> getUserCredit(int userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var dropoff_id = preferences.getString('dropoff_id');
    var request = http.Request('GET', Uri.parse('${MyConstant().domain}/perfectship/get-user-credit'));
    request.body = json.encode({"user_id": userId});
    request.headers.addAll({'Content-Type': 'application/json', 'Authorization': 'Bearer $token'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as Map;
      final newJson = json['data'];
      UserCreditModel list = UserCreditModel.fromJson(newJson);
      print(jsonDecode(res));
      return list;
    } else {
      print(response.reasonPhrase);
      return UserCreditModel();
    }
  }

  Future updateFcmToken(String fcmtoken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var dropoff_id = preferences.getString('dropoff_id');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${MyConstant().domain}/perfectship/updatefcmtoken'));
    request.body = json.encode({"dropoff_member_id": dropoff_id, "fcm_token": fcmtoken});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('on of');
      var res = await response.stream.bytesToString();
      print('res = $res');
      return jsonDecode(res);
    } else {
      return response.stream.bytesToString();
    }
  }
}
