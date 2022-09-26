import 'package:dio/dio.dart';

import '../model/search_model.dart';

class SearchAddressHelperRepository {
  Future<List<Search>> getProvince(String query) async {
    var params = {"keyword": query};
    String url = "https://app-uat.iship.cloud/api/search-address";

    final response = await Dio().get(url, queryParameters: params);
    final List search = response.data;
    if (response.statusCode == 200) {
      return search.map((e) => Search.fromJson(e)).toList();
    } else {
      throw Exception();
    }
  }
}
