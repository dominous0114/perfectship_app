import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/repository/getuserdata_repository.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../widget/fontsize.dart';
import '../../widget/fontsizemenu.dart';
import '../login.dart';

class ProfileSreen extends StatefulWidget {
  const ProfileSreen({Key? key}) : super(key: key);

  @override
  State<ProfileSreen> createState() => _ProfileSreenState();
}

class _ProfileSreenState extends State<ProfileSreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        title: Text(
          'โปรไฟล์',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: PlatformSize(context) * 1.2,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(200, 43, 166, 223),
                Color.fromARGB(180, 41, 88, 162),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: [0.0, 0.8],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Profile(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/senderaddress');
              },
              child: Container(
                height: 60,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100]!,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                            2, 6), // shadow direction: bottom right
                      )
                    ],
                    border: Border.all(color: Colors.grey.shade50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(
                      CupertinoIcons.location_solid,
                      color: Color.fromARGB(255, 41, 88, 162),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomTextAutoSizeforMenu(
                        text: 'ที่อยู่ผู้ส่ง', bold: true, enable: true),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 41, 88, 162),
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<UserDataBloc, UserDataState>(
              builder: (context, state) {
                if (state is UserDataLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(color: Colors.black54, blurRadius: 1)
                        ], borderRadius: BorderRadius.all(Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is UserDataLoaded) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/verifybank',
                          arguments: state.userdatamodel);
                    },
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2.5),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 25),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[100]!,
                              blurRadius: 5.0,
                              spreadRadius: 0.0,
                              offset: const Offset(
                                  2, 6), // shadow direction: bottom right
                            )
                          ],
                          border: Border.all(color: Colors.grey.shade50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            CupertinoIcons.creditcard,
                            color: Color.fromARGB(255, 41, 88, 162),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomTextAutoSizeforMenu(
                              text: 'ยืนยันบัญชีธนาคาร',
                              bold: true,
                              enable: true),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 41, 88, 162),
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settingshipping');
              },
              child: Container(
                height: 60,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100]!,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                            2, 6), // shadow direction: bottom right
                      )
                    ],
                    border: Border.all(color: Colors.grey.shade50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(
                      CupertinoIcons.cube_box,
                      color: Color.fromARGB(255, 41, 88, 162),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomTextAutoSizeforMenu(
                        text: 'ตั้งค่าการส่งพัสดุ', bold: true, enable: true),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 41, 88, 162),
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await GetUserDataRepository().updateFcmToken('');
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.remove('token');
                preferences.remove('dropoff_id');
                preferences.remove('dropoff_name');
                preferences.remove('islogin');
                preferences.remove('accountname');
                preferences.remove('accountnumber');
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                );
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              },
              child: Container(
                height: 60,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100]!,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                            2, 6), // shadow direction: bottom right
                      )
                    ],
                    border: Border.all(color: Colors.grey.shade50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Color.fromARGB(255, 41, 88, 162),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomTextAutoSizeforMenu(
                        text: 'ออกจากระบบ', bold: true, enable: true),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 41, 88, 162),
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
