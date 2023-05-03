import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:perfectship_app/widget/allkey.dart';

import '../bloc/dropdown_courier_bloc/dropdown_courier_bloc.dart';
import 'custom_gradient_icon.dart';

class NavigatonBar extends StatefulWidget {
  const NavigatonBar({Key? key}) : super(key: key);

  @override
  State<NavigatonBar> createState() => _NavigatonBarState();
}

class _NavigatonBarState extends State<NavigatonBar> {
  int pageIndex = 0;
  double _previousScrollOffset = 0.0;
  String? token;
  ScrollController? scrollController;
  Timer? _scrollTimer;
  bool _hideBottomNavBar = false;
  List<Widget> pageList = <Widget>[HomeScreen(), OrderListScreen(), CreateOrderScreen(), BillListScreen(), ProfileSreen()];

  Future<dynamic> backgroundHandler(RemoteMessage message) async {
    LocalNotficationService.displaybackground(message);
  }

  void _scrollListener() {
    if (scrollController!.position.userScrollDirection == ScrollDirection.reverse) {
      if (!_hideBottomNavBar) {
        setState(() {
          _hideBottomNavBar = true;
        });
      }
    } else if (scrollController!.position.userScrollDirection == ScrollDirection.forward) {
      if (_hideBottomNavBar) {
        setState(() {
          _hideBottomNavBar = false;
        });
      }
    }
  }

  void gettoken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    token = await firebaseMessaging.getToken();
    print('fcm = $token');
    GetUserDataRepository().updateFcmToken(token!).then((value) {
      print('gettoken val = ${value}');
    });
  }

  Widget _buildIcon(IconData iconData, int index) {
    final isSelected = pageIndex == index;
    final gradient = LinearGradient(
      colors: [Colors.blue, Colors.red],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    if (isSelected) {
      return GradientIcon(iconData: iconData, gradient: gradient);
    } else {
      return Icon(iconData);
    }
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
    context.read<TrackBloc>().add(TrackInitialEvent());
    Allkey.orderScrollController = ScrollController();
    Allkey.homeScrollController = ScrollController();
    Allkey.billScrollController = ScrollController();
    Allkey.orderScrollController.addListener(() {
      if (Allkey.orderScrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _hideBottomNavBar = true;
        });
      }
      if (Allkey.orderScrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _hideBottomNavBar = false;
        });
      }
      _scrollTimer?.cancel();

      // Start a new timer for 2 seconds
      _scrollTimer = Timer(Duration(seconds: 1), () {
        // Show bottom navbar when there's no scrolling for 2 seconds
        setState(() {
          _hideBottomNavBar = false;
        });
      });
    });
    Allkey.billScrollController.addListener(() {
      if (Allkey.billScrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _hideBottomNavBar = true;
        });
      }
      if (Allkey.billScrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _hideBottomNavBar = false;
        });
      }
      _scrollTimer?.cancel();

      // Start a new timer for 2 seconds
      _scrollTimer = Timer(Duration(seconds: 1), () {
        // Show bottom navbar when there's no scrolling for 2 seconds
        setState(() {
          _hideBottomNavBar = false;
        });
      });
    });
    Allkey.homeScrollController.addListener(() {
      if (Allkey.homeScrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _hideBottomNavBar = true;
        });
      }
      if (Allkey.homeScrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _hideBottomNavBar = false;
        });
      }

      // Cancel the previous timer if there's any
      _scrollTimer?.cancel();

      // Start a new timer for 2 seconds
      _scrollTimer = Timer(Duration(seconds: 1), () {
        // Show bottom navbar when there's no scrolling for 2 seconds
        setState(() {
          _hideBottomNavBar = false;
        });
      });
    });
    super.initState();
  }

  ShaderMask _buildGradientBackground() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            Color.fromARGB(255, 43, 166, 223),
            Color.fromARGB(255, 41, 88, 162),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue, // Fallback color
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          // resizeToAvoidBottomInset: false,
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: AnimatedPositioned(
          //   duration: Duration(milliseconds: 300),
          //   bottom: _hideBottomNavBar ? -100.0 : 0.0,
          //   child: SizedBox(
          //     width: 100,
          //     height: 100,
          //     child: Padding(
          //       padding: EdgeInsets.only(top: 30),
          //       child: RawMaterialButton(
          //         elevation: 6.0,
          //         onPressed: () {
          //           setState(() {
          //             pageIndex = 1;
          //           });
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => CreateOrderScreen()),
          //           );
          //         },
          //         shape: CircleBorder(),
          //         fillColor: Colors.transparent,
          //         child: Stack(
          //           children: [
          //             _buildGradientBackground(),
          //             Center(
          //               child: Icon(
          //                 CupertinoIcons.plus_app_fill,
          //                 color: Colors.white,
          //                 size: 40,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          extendBody: true,
          body: pageList[pageIndex],
          // drawer: showDrawer(),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: AnimatedContainer(
              height: _hideBottomNavBar ? 0.0 : 95,
              duration: Duration(milliseconds: 200),
              child: BottomNavigationBar(
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),

                  //selectedItemColor: Colors.blue,
                  backgroundColor: Colors.white,
                  elevation: 4,
                  currentIndex: pageIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) {
                    setState(() {
                      if (value != 2) {
                        pageIndex = value;
                      }
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: _buildIcon(CupertinoIcons.house, 0),
                      label: 'หน้าแรก',
                    ),
                    //BottomNavigationBarItem(icon: Icon(CupertinoIcons.house), label: 'หน้าแรก'),
                    //BottomNavigationBarItem(icon: Icon(null), label: ""),
                    BottomNavigationBarItem(
                      icon: _buildIcon(CupertinoIcons.cube_box, 1),
                      label: 'พัสดุ',
                    ),
                    BottomNavigationBarItem(icon: Icon(null), label: ''),
                    //BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_list_fill), label: 'บิล'),
                    BottomNavigationBarItem(
                      icon: _buildIcon(CupertinoIcons.square_list_fill, 3),
                      label: 'บิล',
                    ),
                    //BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_alt), label: 'โปรไฟล์'),
                    BottomNavigationBarItem(
                      icon: _buildIcon(CupertinoIcons.person_alt, 4),
                      label: 'โปรไฟล์',
                    ),
                  ]),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom: _hideBottomNavBar ? -100.0 : 0.0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: SizedBox(
              width: 90,
              height: 90,
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: RawMaterialButton(
                  elevation: 6.0,
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateOrderScreen()),
                    );
                  },
                  shape: CircleBorder(),
                  fillColor: Colors.transparent,
                  child: Stack(
                    children: [
                      _buildGradientBackground(),
                      Center(
                        child: Icon(
                          CupertinoIcons.plus_app_fill,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
