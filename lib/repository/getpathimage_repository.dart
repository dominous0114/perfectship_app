import 'package:http/http.dart' as http;
import 'package:perfectship_app/config/constant.dart';

class ImageRepository {
  //Map<String,dynamic>
  Future getPathImage({required String image, required String type}) async {
    var map = new Map<String, dynamic>();

    Uri url = Uri.parse('https://app.iship.cloud/api/file/uploader');
    map['type'] = type;
    map['image'] = image;
    http.Response response = await http.post(url, body: map);
    return response.body;
  }
}
