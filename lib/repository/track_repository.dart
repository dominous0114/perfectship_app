import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/track_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TrackRepository {
  SharedPreferences? preferences;

  Future<List<TrackModel>> getTrack(String start, String end, String courier,
      String printing, String order) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var request = http.Request(
        'GET', Uri.parse('${MyConstant().domain}/perfectship/get-track-list'));
    request.body = json.encode({
      "start_date": start,
      "end_date": end,
      "courier_code": courier,
      "print_status": printing,
      "order_status": order
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res)['data'] as List;
      List<TrackModel> address =
          json.map((e) => TrackModel.fromJson(e)).toList();

      return address;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [TrackModel()];
    }
  }
}
