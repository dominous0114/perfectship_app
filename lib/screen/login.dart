import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfectship_app/repository/signin_repository.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/add_address_screen.dart';
import 'package:perfectship_app/widget/fontsize.dart';
import 'package:perfectship_app/widget/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/customindicator.dart';
import '../widget/fadeaimation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _nodelink = FocusNode();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.blue.shade200, Colors.white, Colors.blue])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Container(
                      //color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //color: Colors.green,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image.asset(
                                //   'assets/logo/im_sent.png',
                                //   scale: 3,
                                // ),
                                Image.asset(
                                  'assets/image/perfect-ship-logo.png',
                                  scale: 4,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            1.4,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.rocket,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        ' Welcome to Perfect Ship!',
                                        style: TextStyle(
                                            fontSize:
                                                PlatformSize(context) * 1.5,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     systemAlertLang(context, 'detail',
                                  //         Icons.abc, Colors.red);
                                  //   },
                                  //   child: context.locale.toString() == 'th'
                                  //       ? Image.asset(
                                  //           'icons/flags/png/th.png',
                                  //           package: 'country_icons',
                                  //           scale: 3,
                                  //         )
                                  //       : Image.asset(
                                  //           'icons/flags/png/us.png',
                                  //           package: 'country_icons',
                                  //           scale: 3,
                                  //         ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          FadeAnimation(
                              1.8,
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(75, 27, 123, 225),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade200))),
                                      child: TextFormField(
                                        maxLength: 10,
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ครบถ้วน';
                                          }
                                          return null;
                                        },
                                        controller: _phonecontroller,
                                        style: TextStyle(
                                            fontSize: PlatformSize(context)),
                                        decoration: InputDecoration(
                                            errorStyle: TextStyle(
                                                fontSize: PlatformSize(context),
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                            labelText: 'เบอร์โทร',
                                            labelStyle: TextStyle(
                                                fontSize:
                                                    PlatformSize(context)),
                                            border: InputBorder.none,
                                            prefixIcon: Icon(Icons.phone)),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade200))),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ครบถ้วน';
                                          }
                                          return null;
                                        },
                                        obscureText: obsecure,
                                        controller: _passwordcontroller,
                                        style: TextStyle(
                                            fontSize: PlatformSize(context)),
                                        decoration: InputDecoration(
                                            errorStyle: TextStyle(
                                                fontSize: PlatformSize(context),
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                            labelText: 'รหัสผ่าน',
                                            labelStyle: TextStyle(
                                                fontSize:
                                                    PlatformSize(context)),
                                            border: InputBorder.none,
                                            prefixIcon: Icon(Icons.lock),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    obsecure = !obsecure;
                                                  });
                                                },
                                                icon: obsecure == true
                                                    ? Icon(Icons.visibility)
                                                    : Icon(
                                                        Icons.visibility_off))),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade200))),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ครบถ้วน';
                                          }
                                          return null;
                                        },
                                        controller: _refcontroller,
                                        keyboardType: TextInputType.url,
                                        style: TextStyle(
                                            fontSize: PlatformSize(context)),
                                        decoration: InputDecoration(
                                            hintText: 'IS000',
                                            errorStyle: TextStyle(
                                                fontSize: PlatformSize(context),
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                            hintStyle: TextStyle(
                                                fontSize: PlatformSize(context),
                                                color: Colors.grey.shade300),
                                            labelText: 'รหัสอ้างอิง',
                                            labelStyle: TextStyle(
                                                fontSize:
                                                    PlatformSize(context)),
                                            border: InputBorder.none,
                                            prefixIcon:
                                                Icon(CupertinoIcons.ticket)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 45,
                          ),
                          FadeAnimation(
                              2.2,
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    SigninRepository()
                                        .senddataSignin(
                                            phone: _phonecontroller.text,
                                            password: _passwordcontroller.text,
                                            ref: _refcontroller.text)
                                        .then((value) async {
                                      if (value['status'] == true) {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        preferences.setString(
                                            'token', value['data']['token']);
                                        preferences.setString(
                                            'dropoff_id',
                                            value['data']['dropoff_member_id']
                                                .toString());
                                        preferences.setString(
                                            'dropoff_name',
                                            value['data']
                                                ['dropoff_member_name']);
                                        preferences.setBool('islogin', true);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NavigatonBar()));
                                      } else if (value['status'] == false) {
                                        Fluttertoast.showToast(
                                            msg: value['message']);
                                      }
                                    });
                                  }
                                  //SigninRepository().test();

                                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navbar()));
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blue.shade400),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      loginload == false
                                          ? Icon(
                                              Icons.login_outlined,
                                              color: Colors.white,
                                              size: 20,
                                            )
                                          : CustomProgessIndicator(
                                              Colors.white, 15),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
