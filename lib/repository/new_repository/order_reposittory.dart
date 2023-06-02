import 'dart:convert';

import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/model/new_model/dashboard_new_model.dart';
import 'package:perfectship_app/model/new_model/orderlist_new_model.dart';
import 'package:perfectship_app/model/new_model/tracking_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  SharedPreferences? preferences;
  Future createOrder(
      {required String courierCode,
      required int type,
      required String labelName,
      required String labelPhone,
      required String labelAddress,
      required String labelSubDistrict,
      required String labelDistrict,
      required String labelProvince,
      required String labelZipcode,
      required String accountName,
      required String accountNumber,
      required String accountBranch,
      required String accountBank,
      required String dstName,
      required String dstPhone,
      required String dstAddress,
      required String dstSubDistrict,
      required String dstDistrict,
      required String dstProvince,
      required String dstZipcode,
      required double weight,
      required double width,
      required double length,
      required double height,
      required double codAmount,
      required String remark,
      required int isInsured,
      required double productValue,
      required int customerId,
      required int isBulky,
      required int jntPickup,
      required int kerryPickup,
      required int categoryId,
      required int saveDstAddress}) async {
    try {
      print('on create repo');
      preferences = await SharedPreferences.getInstance();
      var token = preferences!.getString('token');
      var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('${MyConstant().newDomain}/api/v1/order/create-order'));
      request.body = json.encode({
        "courier_code": courierCode,
        "type": type,
        "label_name": labelName,
        "label_phone": labelPhone,
        "label_address": labelAddress,
        "label_sub_district": labelSubDistrict,
        "label_district": labelDistrict,
        "label_province": labelProvince,
        "label_zipcode": labelZipcode,
        "account_name": accountName,
        "account_number": accountNumber,
        "account_branch": accountBranch,
        "account_bank": accountBank,
        "dst_name": dstName,
        "dst_phone": dstPhone,
        "dst_address": dstAddress,
        "dst_sub_district": dstSubDistrict,
        "dst_district": dstDistrict,
        "dst_province": dstProvince,
        "dst_zipcode": dstZipcode,
        "weight": weight,
        "width": width,
        "length": length,
        "height": height,
        "cod_amount": codAmount,
        "remark": remark,
        "is_insured": isInsured,
        "product_value": productValue,
        "customer_id": customerId,
        "is_bulky": isBulky,
        "jnt_pickup": jntPickup,
        "kerry_pickup": kerryPickup,
        "category_id": categoryId,
        "save_dst_address": saveDstAddress
      });
      print(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        print('response = ${jsonDecode(res)}');
        return jsonDecode(res);
      } else {
        var res = await response.stream.bytesToString();
        print(response.reasonPhrase);
        return jsonDecode(res);
      }
    } catch (e, stackTrace) {
      print('create order repository exception = $e');
      print(stackTrace);
    }
  }

  Future<List<OrderlistNewModel>> getOrder(dynamic couriercode, dynamic status) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var customerid = preferences!.getInt('customerid');
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/order/get-order-list'));
    request.body = json.encode({"customer_id": customerid, "courier_code": couriercode, "status_id": status});
    request.headers.addAll(headers);
    print(request.body);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('if');
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as List;
      List<OrderlistNewModel> order = json.map((e) => OrderlistNewModel.fromJson(e)).toList();

      return order;
    } else {
      print('else');
      print(response.reasonPhrase);
      return [OrderlistNewModel()];
    }
  }

  Future<TrackingListModel> getTrack(String tracking) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/tracking'));
    request.body = json.encode({"tracking": tracking});

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as Map<String, dynamic>;
      final newJson = json['data'];

      // Extract trace_logs field
      final traceLogsJson = newJson['trace_logs'];
      List<TraceLogs> traceLogs = (traceLogsJson as List).map((item) => TraceLogs.fromJson(item)).toList();

      TrackingListModel list = TrackingListModel.fromJson(newJson);
      list.traceLogs = traceLogs; // Assign trace_logs to the TrackingListModel

      // print(jsonDecode(res));
      return list;
    } else {
      print(response.reasonPhrase);
      return TrackingListModel();
    }
  }

  Future<DashboardNewModel> getDashboard(String start, String end) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var customerid = preferences!.getInt('customerid');
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('${MyConstant().newDomain}/api/v1/utility/gatdt-dashboard'));
    request.body = json.encode({"customer_id": customerid, "start_date": "2023-05-01", "end_date": "2023-05-30"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      final json = jsonDecode(res) as Map<String, dynamic>;
      final newJson = json;

      DashboardNewModel list = DashboardNewModel.fromJson(newJson);

      // print(jsonDecode(res));
      return list;
    } else {
      print(response.reasonPhrase);
      return DashboardNewModel();
    }
  }

  Future cancelOrder({required String trackNo, required String refCode, required String courierCode}) async {
    preferences = await SharedPreferences.getInstance();
    var token = preferences!.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request('POST', Uri.parse('${MyConstant().newDomain}/api/v1/order/cancel-order'));
    request.body = json.encode({"track_no": trackNo, "ref_code": refCode, "courier_code": courierCode});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      print('response = ${jsonDecode(res)}');
      return jsonDecode(res);
    } else {
      var res = await response.stream.bytesToString();
      print(response.reasonPhrase);
      return jsonDecode(res);
    }
  }
}
