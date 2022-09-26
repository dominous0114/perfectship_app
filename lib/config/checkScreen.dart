import 'package:flutter/material.dart';
import 'package:perfectship_app/screen/login.dart';
import 'package:perfectship_app/widget/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  State<CheckScreen> createState() => _CheckScreenState();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
