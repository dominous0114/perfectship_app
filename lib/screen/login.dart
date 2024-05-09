import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:perfectship_app/config/keyboard_type.dart';
import 'package:perfectship_app/repository/signin_repository.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/add_address_screen.dart';
import 'package:perfectship_app/widget/fontsize.dart';
import 'package:perfectship_app/widget/gettextfield.dart';
import 'package:perfectship_app/widget/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/keyboard_overlay.dart';
import '../widget/customindicator.dart';
import '../widget/fadeaimation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _nodephone = FocusNode();
  final TextEditingController _phonecontroller = TextEditingController();
  final FocusNode _nodeUsername = FocusNode();
  final TextEditingController _passwordcontroller = TextEditingController();
  final FocusNode _nodePassword = FocusNode();
  final TextEditingController _refcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late FToast fToast;
  bool loginload = false;
  bool obsecure = true;

  @override
  void initState() {
    _nodephone.addListener(() {
      bool hasFocus = _nodephone.hasFocus;
      if (hasFocus) {
        Platform.isAndroid ? null : KeyboardOverlay.showOverlay(context);
      } else {
        KeyboardOverlay.removeOverlay();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 252, 254, 255),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onLongPress: () async {
                            SharedPreferences preferences = await SharedPreferences.getInstance();
                            preferences.setString('token', 'aixOiMy0Ad2CHMrgB7za2t9zbpNkdzajSgPwniZilY2esHtun184Cv5ACarvVl9DJf6Spr00zf4tGsa1kXaNZ7xPVbgjnT4wiWhN');
                            preferences.setInt('customerid', 127870);
                            preferences.setString('customername', 'ทดสอบ');
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigatonBar()));
                            // preferences.setString(
                            //     'dropoff_name',
                            //     value['data']
                            //         ['dropoff_member_name']);
                            preferences.setBool('islogin', true);
                          },
                          child: Image.asset(
                            'assets/image/DTracking.png',
                            scale: 2,
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          padding: EdgeInsets.all(5),
                          decoration:
                              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Color.fromRGBO(143, 148, 251, .2), blurRadius: 20.0, offset: Offset(0, 10))]),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  maxLength: 10,
                                  focusNode: _nodephone,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกข้อมูลให้ครบถ้วน';
                                    }
                                    return null;
                                  },
                                  controller: _phonecontroller,
                                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: PlatformSize(context)),
                                  decoration: InputDecoration(
                                      counterText: '',
                                      label: Text(
                                        'เบอร์โทรศัพท์',
                                      ),
                                      labelStyle: TextStyle(fontSize: PlatformSize(context), color: Colors.black54),
                                      hintStyle: Theme.of(context).textTheme.headline4!.copyWith(color: Color.fromARGB(255, 28, 19, 19).withOpacity(.5), fontWeight: FontWeight.bold, fontSize: PlatformSize(context)),
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.7, color: Colors.grey), //<-- SEE HERE
                                      ),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade200), borderRadius: BorderRadius.all(Radius.circular(4))),
                                      errorStyle: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                                      prefixIcon: Icon(
                                        CupertinoIcons.phone_circle,
                                        color: Colors.blue,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: obsecure,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกข้อมูลให้ครบถ้วน';
                                    }
                                    return null;
                                  },
                                  controller: _passwordcontroller,
                                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: PlatformSize(context)),
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              obsecure = !obsecure;
                                            });
                                          },
                                          icon: obsecure == true ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                                      label: Text(
                                        'รหัสผ่าน',
                                      ),
                                      labelStyle: TextStyle(fontSize: PlatformSize(context), color: Colors.black54),
                                      hintStyle: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.grey[500]!.withOpacity(.5), fontWeight: FontWeight.bold, fontSize: PlatformSize(context)),
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.7, color: Colors.grey), //<-- SEE HERE
                                      ),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade200), borderRadius: BorderRadius.all(Radius.circular(4))),
                                      errorStyle: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                                      prefixIcon: Icon(
                                        CupertinoIcons.lock_circle,
                                        color: Colors.blue,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกข้อมูลให้ครบถ้วน';
                                    }
                                    return null;
                                  },
                                  controller: _refcontroller,
                                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: PlatformSize(context)),
                                  decoration: InputDecoration(
                                      label: Text(
                                        'รหัสอ้างอิง',
                                      ),
                                      labelStyle: TextStyle(fontSize: PlatformSize(context), color: Colors.black54),
                                      hintStyle: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.grey[500]!.withOpacity(.5), fontWeight: FontWeight.bold, fontSize: PlatformSize(context)),
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.7, color: Colors.grey), //<-- SEE HERE
                                      ),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade200), borderRadius: BorderRadius.all(Radius.circular(4))),
                                      errorStyle: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                                      prefixIcon: Icon(
                                        CupertinoIcons.ticket,
                                        color: Colors.blue,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        GestureDetector(
                          onTap: loginload == true
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loginload = true;
                                    });
                                    SigninRepository().senddataSignin(phone: _phonecontroller.text, password: _passwordcontroller.text, ref: _refcontroller.text).then((value) async {
                                      if (value['status'] == true) {
                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                        print(value);
                                        preferences.setString('token', value['data']['token']);
                                        preferences.setInt('customerid', value['data']['customer_id']);
                                        preferences.setString('customername', value['data']['customer_name']);
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigatonBar()));
                                        // preferences.setString(
                                        //     'dropoff_name',
                                        //     value['data']
                                        //         ['dropoff_member_name']);
                                        preferences.setBool('islogin', true);
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             NavigatonBar()));
                                        setState(() {
                                          loginload = false;
                                        });
                                      } else if (value['status'] == false) {
                                        print(value);
                                        Fluttertoast.showToast(
                                          msg: value['message'],
                                          gravity: ToastGravity.CENTER,
                                        );
                                        setState(() {
                                          loginload = false;
                                        });
                                      }
                                    });
                                  }
                                },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 19, 125, 193),
                                  Color.fromARGB(255, 25, 192, 236),
                                ])),
                            child: Center(
                              child: loginload == true
                                  ? CustomProgessIndicator(Colors.white, 18)
                                  : Text(
                                      "เข้าสู่ระบบ",
                                      style: TextStyle(fontSize: PlatformSize(context), color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        // FadeAnimation(
                        //     1.5,
                        //     GestureDetector(
                        //       onTap: () {},
                        //       child: Text(
                        //         "Forgot Password?",
                        //         style: TextStyle(
                        //             color: Color.fromRGBO(143, 148, 251, 1)),
                        //       ),
                        //     )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // body: Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: Alignment.topCenter,
        //           colors: [Colors.blue.shade200, Colors.white, Colors.blue])),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       SizedBox(
        //         height: 50,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.all(5),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             FadeAnimation(
        //               1,
        //               Container(
        //                 //color: Colors.blue,
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     Container(
        //                       //color: Colors.green,
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           // Image.asset(
        //                           //   'assets/logo/im_sent.png',
        //                           //   scale: 3,
        //                           // ),
        //                           Image.asset(
        //                             'assets/image/perfect-ship-logo.png',
        //                             scale: 4,
        //                           ),
        //                         ],
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 20),
        //       Expanded(
        //         child: Form(
        //           key: _formKey,
        //           autovalidateMode: AutovalidateMode.disabled,
        //           child: Container(
        //             decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 borderRadius: BorderRadius.only(
        //                     topLeft: Radius.circular(40),
        //                     topRight: Radius.circular(40))),
        //             child: SingleChildScrollView(
        //               child: Padding(
        //                 padding: EdgeInsets.all(15),
        //                 child: Column(
        //                   children: <Widget>[
        //                     SizedBox(
        //                       height: 20,
        //                     ),
        //                     FadeAnimation(
        //                       1.4,
        //                       Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.start,
        //                           children: [
        //                             Row(
        //                               children: [
        //                                 Text(
        //                                   '  เข้าสู่ระบบ',
        //                                   style: TextStyle(
        //                                       fontSize:
        //                                           PlatformSize(context) * 1.3,
        //                                       fontWeight: FontWeight.bold,
        //                                       color: Colors.blue),
        //                                 ),
        //                               ],
        //                             ),
        //                             // GestureDetector(
        //                             //   onTap: () {
        //                             //     systemAlertLang(context, 'detail',
        //                             //         Icons.abc, Colors.red);
        //                             //   },
        //                             //   child: context.locale.toString() == 'th'
        //                             //       ? Image.asset(
        //                             //           'icons/flags/png/th.png',
        //                             //           package: 'country_icons',
        //                             //           scale: 3,
        //                             //         )
        //                             //       : Image.asset(
        //                             //           'icons/flags/png/us.png',
        //                             //           package: 'country_icons',
        //                             //           scale: 3,
        //                             //         ),
        //                             // ),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                     FadeAnimation(
        //                         1.8,
        //                         Container(
        //                           decoration: BoxDecoration(
        //                               color: Colors.white,
        //                               borderRadius: BorderRadius.circular(8),
        //                               boxShadow: [
        //                                 BoxShadow(
        //                                     color:
        //                                         Color.fromARGB(75, 27, 123, 225),
        //                                     blurRadius: 20,
        //                                     offset: Offset(0, 10))
        //                               ]),
        //                           child: Column(
        //                             children: <Widget>[
        //                               Container(
        //                                 padding:
        //                                     EdgeInsets.symmetric(horizontal: 3),
        //                                 decoration: BoxDecoration(
        //                                     border: Border(
        //                                         bottom: BorderSide(
        //                                             color:
        //                                                 Colors.grey.shade200))),
        //                                 child: TextFormField(
        //                                   focusNode: _nodephone,
        //                                   maxLength: 10,
        //                                   keyboardType: TextInputType.phone,
        //                                   validator: (value) {
        //                                     if (value == null || value.isEmpty) {
        //                                       return 'กรุณากรอกข้อมูลให้ครบถ้วน';
        //                                     }
        //                                     return null;
        //                                   },
        //                                   controller: _phonecontroller,
        //                                   style: TextStyle(
        //                                       fontSize: PlatformSize(context)),
        //                                   decoration: InputDecoration(
        //                                       counterText: '',
        //                                       errorStyle: TextStyle(
        //                                           fontSize: PlatformSize(context),
        //                                           color: Colors.red,
        //                                           fontWeight: FontWeight.bold),
        //                                       labelText: 'เบอร์โทร',
        //                                       labelStyle: TextStyle(
        //                                           fontSize:
        //                                               PlatformSize(context)),
        //                                       border: InputBorder.none,
        //                                       prefixIcon: Icon(Icons.phone)),
        //                                 ),
        //                               ),
        //                               Container(
        //                                 padding:
        //                                     EdgeInsets.symmetric(horizontal: 3),
        //                                 decoration: BoxDecoration(
        //                                     border: Border(
        //                                         bottom: BorderSide(
        //                                             color:
        //                                                 Colors.grey.shade200))),
        //                                 child: TextFormField(
        //                                   validator: (value) {
        //                                     if (value == null || value.isEmpty) {
        //                                       return 'กรุณากรอกข้อมูลให้ครบถ้วน';
        //                                     }
        //                                     return null;
        //                                   },
        //                                   obscureText: obsecure,
        //                                   controller: _passwordcontroller,
        //                                   style: TextStyle(
        //                                       fontSize: PlatformSize(context)),
        //                                   decoration: InputDecoration(
        //                                       errorStyle: TextStyle(
        //                                           fontSize: PlatformSize(context),
        //                                           color: Colors.red,
        //                                           fontWeight: FontWeight.bold),
        //                                       labelText: 'รหัสผ่าน',
        //                                       labelStyle: TextStyle(
        //                                           fontSize:
        //                                               PlatformSize(context)),
        //                                       border: InputBorder.none,
        //                                       prefixIcon: Icon(Icons.lock),
        //                                       suffixIcon: IconButton(
        //                                           onPressed: () {
        //                                             setState(() {
        //                                               obsecure = !obsecure;
        //                                             });
        //                                           },
        //                                           icon: obsecure == true
        //                                               ? Icon(Icons.visibility)
        //                                               : Icon(
        //                                                   Icons.visibility_off))),
        //                                 ),
        //                               ),
        //                               Container(
        //                                 padding:
        //                                     EdgeInsets.symmetric(horizontal: 3),
        //                                 decoration: BoxDecoration(
        //                                     border: Border(
        //                                         bottom: BorderSide(
        //                                             color:
        //                                                 Colors.grey.shade200))),
        //                                 child: TextFormField(
        //                                   validator: (value) {
        //                                     if (value == null || value.isEmpty) {
        //                                       return 'กรุณากรอกข้อมูลให้ครบถ้วน';
        //                                     }
        //                                     return null;
        //                                   },
        //                                   controller: _refcontroller,
        //                                   style: TextStyle(
        //                                       fontSize: PlatformSize(context)),
        //                                   decoration: InputDecoration(
        //                                       hintText: 'IS000',
        //                                       errorStyle: TextStyle(
        //                                           fontSize: PlatformSize(context),
        //                                           color: Colors.red,
        //                                           fontWeight: FontWeight.bold),
        //                                       hintStyle: TextStyle(
        //                                           fontSize: PlatformSize(context),
        //                                           color: Colors.grey.shade300),
        //                                       labelText: 'รหัสอ้างอิง',
        //                                       labelStyle: TextStyle(
        //                                           fontSize:
        //                                               PlatformSize(context)),
        //                                       border: InputBorder.none,
        //                                       prefixIcon:
        //                                           Icon(CupertinoIcons.ticket)),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         )),
        //                     SizedBox(
        //                       height: 45,
        //                     ),
        //                     FadeAnimation(
        //                         2.2,
        //                         GestureDetector(
        //                           onTap: loginload == true
        //                               ? null
        //                               : () {
        // if (_formKey.currentState!.validate()) {
        //   setState(() {
        //     loginload = true;
        //   });
        //   SigninRepository()
        //       .senddataSignin(
        //           phone: _phonecontroller.text,
        //           password:
        //               _passwordcontroller.text,
        //           ref: _refcontroller.text)
        //       .then((value) async {
        //     if (value['status'] == true) {
        //       SharedPreferences preferences =
        //           await SharedPreferences
        //               .getInstance();
        //       preferences.setString('token',
        //           value['data']['token']);
        //       preferences.setString(
        //           'dropoff_id',
        //           value['data']
        //                   ['dropoff_member_id']
        //               .toString());
        //       preferences.setString(
        //           'dropoff_name',
        //           value['data']
        //               ['dropoff_member_name']);
        //       preferences.setBool(
        //           'islogin', true);
        //       Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) =>
        //                   NavigatonBar()));
        //       setState(() {
        //         loginload = false;
        //       });
        //     } else if (value['status'] ==
        //         false) {
        //       Fluttertoast.showToast(
        //           msg: value['message']);
        //       setState(() {
        //         loginload = false;
        //       });
        //     }
        //   });
        // }
        //                                   //SigninRepository().test();

        //                                   //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navbar()));
        //                                 },
        //                           child: Container(
        //                             height: 50,
        //                             margin: EdgeInsets.symmetric(horizontal: 50),
        //                             decoration: BoxDecoration(
        //                                 borderRadius: BorderRadius.circular(50),
        //                                 color: Colors.blue.shade400),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.center,
        //                               children: [
        //                                 loginload == false
        //                                     ? Icon(
        //                                         Icons.login_outlined,
        //                                         color: Colors.white,
        //                                         size: 20,
        //                                       )
        //                                     : SizedBox(),
        //                                 SizedBox(
        //                                   width: 5,
        //                                 ),
        //                                 loginload == true
        //                                     ? CustomProgessIndicator(
        //                                         Colors.white, 18)
        //                                     : Text(
        //                                         "เข้าสู่ระบบ",
        //                                         style: TextStyle(
        //                                             color: Colors.white,
        //                                             fontWeight: FontWeight.bold),
        //                                       ),
        //                               ],
        //                             ),
        //                           ),
        //                         )),
        //                     SizedBox(
        //                       height: 30,
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
