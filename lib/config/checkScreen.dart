import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:perfectship_app/screen/login.dart';
import 'package:perfectship_app/widget/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

void initialization() async {
  print('ready in 3...');
  await Future.delayed(const Duration(seconds: 1));
  print('ready in 2...');
  await Future.delayed(const Duration(seconds: 1));
  print('ready in 1...');
  await Future.delayed(const Duration(seconds: 1));
  print('go!');
  FlutterNativeSplash.remove();
}

class _CheckScreenState extends State<CheckScreen> {
  Future checkPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? islogin = preferences.getBool('islogin');
    try {
      if (islogin == true) {
        print('on if');
        routeToService(NavigatonBar());
      } else if (islogin == null || islogin == false) {
        routeToService(LoginScreen());
        print('on else');
      }
    } catch (e) {}
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  void initState() {
    checkPreference();
    initialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
