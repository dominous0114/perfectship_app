import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';

import 'package:perfectship_app/widget/fontsize.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Shader linearGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Colors.lightBlueAccent.shade100, Colors.lightBlue.shade600]).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100]!,
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset.zero, // shadow direction: bottom right
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: BlocBuilder<UserDataBloc, UserDataState>(builder: ((context, state) {
          if (state is UserDataLoading) {
            return Shimmer.fromColors(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 110),
                  )
                ],
              ),
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
            );
          } else if (state is UserDataLoaded) {
            print('data loaded');
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
                                          String? token = await firebaseMessaging.getToken();
                                          print(token);
                                        },
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage('assets/image/DplusExpress-01.png'),
                                          radius: 50,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  '${state.userdatamodel.name}',
                                  style: Theme.of(context).textTheme.headline4!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: PlatformSize(context) * 1.2,
                                        color: Colors.black,
                                      ),
                                ),
                                Text(
                                  'รหัสลูกค้า : ${state.userdatamodel.id}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontWeight: FontWeight.bold, fontSize: PlatformSize(context) * .8),
                                ),
                                Text(
                                  'เบอร์ : ${state.userdatamodel.phone}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontWeight: FontWeight.bold, fontSize: PlatformSize(context) * .8),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '${state.userdatamodel.address!.address} ${state.userdatamodel.address!.subDistrict} ${state.userdatamodel.address!.district} ${state.userdatamodel.address!.province} ${state.userdatamodel.address!.zipcode}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(fontWeight: FontWeight.bold, fontSize: PlatformSize(context) * .8),
                                    )),
                                  ],
                                )
                                // Row(
                                //   children: [
                                //     Material(
                                //       color: Colors.transparent,
                                //       child: InkWell(
                                //         onTap: () {
                                //           Navigator.push(context, CupertinoPageRoute(
                                //             builder: (context) {
                                //               return EditProfile();
                                //             },
                                //           ));
                                //         },
                                //         child: Container(
                                //           decoration: BoxDecoration(
                                //               borderRadius: BorderRadius.circular(16),
                                //               color: Colors.white,
                                //               boxShadow: [BoxShadow(color: Colors.blue, spreadRadius: 1, offset: Offset(0.2, 0.7))]),
                                //           child: Padding(
                                //             padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                //             child: Row(
                                //               mainAxisSize: MainAxisSize.min,
                                //               children: [
                                //                 Icon(
                                //                   Icons.edit,
                                //                   size: 14,
                                //                 ),
                                //                 SizedBox(
                                //                   width: 3,
                                //                 ),
                                //                 Text(
                                //                   'แก้ไข',
                                //                   style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //     Material(
                                //       color: Colors.transparent,
                                //       child: InkWell(
                                //         onTap: () {
                                //           Navigator.push(
                                //               context,
                                //               CupertinoPageRoute(
                                //                 builder: (context) => ChangePassword(),
                                //               ));
                                //         },
                                //         child: Container(
                                //           decoration: BoxDecoration(
                                //               borderRadius: BorderRadius.circular(16),
                                //               color: Colors.white,
                                //               boxShadow: [BoxShadow(color: Colors.blue, spreadRadius: 1, offset: Offset(0.2, 0.7))]),
                                //           child: Padding(
                                //             padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                //             child: Row(
                                //               mainAxisSize: MainAxisSize.min,
                                //               children: [
                                //                 Icon(
                                //                   Icons.password,
                                //                   size: 14,
                                //                 ),
                                //                 SizedBox(
                                //                   width: 1,
                                //                 ),
                                //                 Text(
                                //                   'แก้ไขรหัสผ่าน',
                                //                   style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),

                        // Column(
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Container(
                        //           height: 30,
                        //           padding: EdgeInsets.symmetric(horizontal: 16),
                        //           decoration: BoxDecoration(
                        //               color: Colors.grey.shade100,
                        //               borderRadius: BorderRadius.circular(10)),
                        //           child: Center(
                        //             child: Text(
                        //               '${state.usercreditmodel.credit} บาท',
                        //               style: Theme.of(context)
                        //                   .textTheme
                        //                   .bodyText1!
                        //                   .copyWith(
                        //                     fontSize:
                        //                         PlatformSize(context) * 1.2,
                        //                     color: Color.fromARGB(
                        //                         255, 41, 88, 162),
                        //                   ),
                        //             ),
                        //           ),
                        //         ),
                        //         Text(
                        //           'เครดิตคงเหลือ',
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .bodyText1!
                        //               .copyWith(
                        //                   fontSize:
                        //                       PlatformSize(context) * 0.9),
                        //         ),
                        //       ],
                        //     ),
                        //     Container(
                        //       height: 5,
                        //       color: Colors.black,
                        //     ),
                        //     Column(
                        //       children: [
                        //         Container(
                        //           height: 30,
                        //           padding: EdgeInsets.symmetric(horizontal: 16),
                        //           decoration: BoxDecoration(
                        //               color: Colors.grey.shade100,
                        //               borderRadius: BorderRadius.circular(10)),
                        //           child: Center(
                        //             child: Text(
                        //               '${state.usercreditmodel.orderAmount} รายการ',
                        //               style: Theme.of(context)
                        //                   .textTheme
                        //                   .bodyText1!
                        //                   .copyWith(
                        //                     fontSize:
                        //                         PlatformSize(context) * 1.2,
                        //                     color: Color.fromARGB(
                        //                         255, 41, 88, 162),
                        //                   ),
                        //             ),
                        //           ),
                        //         ),
                        //         Text(
                        //           'สร้างได้',
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .bodyText1!
                        //               .copyWith(
                        //                   fontSize:
                        //                       PlatformSize(context) * 0.9),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          } else {
            return Container();
          }
        })),
      ),
    );
  }
}
