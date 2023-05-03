import 'package:flutter/material.dart';
import 'package:perfectship_app/model/address_model.dart';
import 'package:perfectship_app/model/bank_model.dart';

import 'package:perfectship_app/screen/billlist/bill_detail_screen.dart';
import 'package:perfectship_app/screen/billlist/pdf_bill_screen.dart';
import 'package:perfectship_app/screen/createorder/pdf_order_screen.dart';
import 'package:perfectship_app/screen/createorder/selectaddress_oncreate/address_on_create_screen.dart';
import 'package:perfectship_app/screen/home/notification_screen.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/add_address_screen.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/edit_address_screen.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/senderaddress_screen.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/setting_shipping_screen.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/verifybank_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case VerifyBankScreen.routeName:
      //   return VerifyBankScreen.route(
      //       userdatamodel: settings.arguments as UserDataModel);
      case SenderAddressScreen.routeName:
        return SenderAddressScreen.route();
      case AddAddressScreen.routeName:
        return AddAddressScreen.route();
      case EditAddressScreen.routeName:
        return EditAddressScreen.route(addressModel: settings.arguments as AddressModel);
      case AddressOnCreateScreen.routeName:
        return AddressOnCreateScreen.route();
      case BillDetailScreen.routeName:
        return BillDetailScreen.route(list: settings.arguments as List);
      case PdfOrderScreen.routeName:
        return PdfOrderScreen.route(pdfData: settings.arguments as String);
      case NotificationScreen.routeName:
        return NotificationScreen.route();
      case SettingShippingScreen.routeName:
        return SettingShippingScreen.route();
      case PdfBillScreen.routeName:
        return PdfBillScreen.route(pdfData: settings.arguments as String);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
            ));
  }
}
