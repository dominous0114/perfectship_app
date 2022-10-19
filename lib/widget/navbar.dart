import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectship_app/bloc/address_bloc/address_bloc.dart';
import 'package:perfectship_app/bloc/track_bloc/track_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/config/localnoti_service.dart';
import 'package:perfectship_app/repository/getuserdata_repository.dart';
import 'package:perfectship_app/screen/billlist/billlist_screen.dart';
import 'package:perfectship_app/screen/createorder/createorder.dart';
import 'package:perfectship_app/screen/home/homescreen.dart';
import 'package:perfectship_app/screen/orderlist/orderlist_screen.dart';
import 'package:perfectship_app/screen/profile/profile_screen.dart';

import '../bloc/dropdown_courier_bloc/dropdown_courier_bloc.dart';

class NavigatonBar extends StatefulWidget {
  const NavigatonBar({Key? key}) : super(key: key);

  @override
  State<NavigatonBar> createState() => _NavigatonBarState();
}

class _NavigatonBarState extends State<NavigatonBar> {
  int pageIndex = 0;
  String? token;
  List<Widget> pageList = <Widget>[
    HomeScreen(),
    OrderListScreen(),
    CreateOrderScreen(),
    BillListScreen(),
    ProfileSreen()
  ];

  Future<dynamic> backgroundHandler(RemoteMessage message) async {
    LocalNotficationService.displaybackground(message);
  }

  void gettoken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    token = await firebaseMessaging.getToken();
    GetUserDataRepository().updateFcmToken(token!).then((value) {
      print('gettoken val = ${value}');
    });
  }

  @override
  void initState() {
    print('init navbar');
    LocalNotficationService.initialize(context);
    // FirebaseMessaging.instance.getInitialMessage().then((value) {
    //   print('on init');
    //   Navigator.pushNamed(context, '/notification');
    // });
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotficationService.display(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('on open');
      // Navigator.pushNamed(context, '/notification');

      // setState(() {
      //   print('index = ${event.data['index']}');
      //   pageIndex = int.parse(event.data['index']);
      // });
    });

    // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    gettoken();
    super.initState();
    context.read<UserDataBloc>().add(UserDataInitialEvent());
    context.read<AddressBloc>().add(AddressInitialEvent());
    context.read<DropdownCourierBloc>().add(DropdownCourierIniitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 100,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: FloatingActionButton(
            shape: CircleBorder(),
            child: Icon(
              CupertinoIcons.plus_app_fill,
              size: 40,
            ),
            backgroundColor: Color.fromARGB(255, 123, 189, 255),
            onPressed: () {
              setState(() {
                // LocalNotficationService.testdisplay('test');
                pageIndex = 1;
              });

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateOrderScreen()));
            },
          ),
        ),
      ),
      extendBody: true,
      body: pageList[pageIndex],
      // drawer: showDrawer(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 49, 107, 200),
              Color.fromARGB(255, 99, 198, 244),
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: [0.0, 0.8],
            tileMode: TileMode.clamp,
          ),
        ),
        child: BottomNavigationBar(
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            selectedItemColor: Colors.white,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: pageIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              setState(() {
                pageIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house),
                label: 'หน้าแรก',
              ),
              //BottomNavigationBarItem(icon: Icon(null), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.cube_box_fill), label: 'พัสดุ'),
              BottomNavigationBarItem(icon: Icon(null), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.square_list_fill), label: 'บิล'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_alt), label: 'โปรไฟล์'),
            ]),
      ),
    );
  }
}
