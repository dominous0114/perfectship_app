import 'package:flutter/material.dart';
import 'package:perfectship_app/model/address_model.dart';
import 'package:perfectship_app/model/bank_model.dart';
import 'package:perfectship_app/model/userdata_model.dart';
import 'package:perfectship_app/screen/createorder/selectaddress_oncreate/address_on_create_screen.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/add_address_screen.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/edit_address_screen.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/senderaddress_screen.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/verifybank_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case VerifyBankScreen.routeName:
        return VerifyBankScreen.route(
            userdatamodel: settings.arguments as UserDataModel);
      case SenderAddressScreen.routeName:
        return SenderAddressScreen.route();
      case AddAddressScreen.routeName:
        return AddAddressScreen.route();
      case EditAddressScreen.routeName:
        return EditAddressScreen.route(
            addressModel: settings.arguments as AddressModel);
      case AddressOnCreateScreen.routeName:
        return AddressOnCreateScreen.route();
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
