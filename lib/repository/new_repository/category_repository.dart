import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/new_model/category_new_model.dart';
import 'package:http/http.dart' as http;

class CategoryNewRepository {
  SharedPreferences? preferences;

  Future<List<CategoryNewModel>> getCategory() async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/utility/get-categories'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as List;
      List<CategoryNewModel> category = json.map((e) => CategoryNewModel.fromJson(e)).toList();

      return category;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [CategoryNewModel()];
    }
  }
}
