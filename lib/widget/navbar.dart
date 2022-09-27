import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectship_app/bloc/address_bloc/address_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/screen/billlist/billlist_screen.dart';
import 'package:perfectship_app/screen/createorder/createorder.dart';
import 'package:perfectship_app/screen/home/homescreen.dart';
import 'package:perfectship_app/screen/orderlist/orderlist_screen.dart';
import 'package:perfectship_app/screen/profile/profile_screen.dart';

class NavigatonBar extends StatefulWidget {
  const NavigatonBar({Key? key}) : super(key: key);

  @override
  State<NavigatonBar> createState() => _NavigatonBarState();
}

class _NavigatonBarState extends State<NavigatonBar> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    HomeScreen(),
    OrderListScreen(),
    CreateOrderScreen(),
    BillListScreen(),
    ProfileSreen()
  ];

  @override
  void initState() {
    context.read<UserDataBloc>().add(UserDataInitialEvent());
    context.read<AddressBloc>().add(AddressInitialEvent());
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
            child: Icon(CupertinoIcons.add),
            backgroundColor: Color.fromARGB(255, 123, 189, 255),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateOrderScreen()));
            },
          ),
        ),
      ),
      extendBody: true,
      body: pageList[pageIndex],
      // drawer: showDrawer(),
      bottomNavigationBar: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [
              Color.fromARGB(200, 43, 166, 223),
              Color.fromARGB(180, 41, 88, 162),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.8],
            tileMode: TileMode.clamp,
          ).createShader(bounds);
        },
        child: BottomAppBar(
          //color: Color.fromARGB(231, 43, 49, 134),
          //shape: CircularNotchedRectangle(),
          //notchMargin: 12,
          // ← carves notch for FAB in BottomAppBar

          child: BottomNavigationBar(
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              selectedItemColor: Colors.black,
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
                    icon: Icon(CupertinoIcons.square_list), label: 'พัสดุ'),
                BottomNavigationBarItem(icon: Icon(null), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.square_list_fill), label: 'บิล'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_alt), label: 'โปรไฟล์'),
              ]),
        ),
      ),
    );
  }
}
