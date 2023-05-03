import 'package:flutter/material.dart';

import '../../widget/fontsize.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: SafeArea(
            maintainBottomViewPadding: true,
            bottom: false,
            top: false,
            child: Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [],
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        pinned: false,
                        toolbarHeight: 60,
                        elevation: 0,
                        title: Text(
                          'รายการพัสดุ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: PlatformSize(context) * 1.2, fontWeight: FontWeight.bold, color: Colors.white),
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
                    ],
                  )),
            )));
  }
}
