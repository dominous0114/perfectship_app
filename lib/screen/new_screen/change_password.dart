import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:perfectship_app/repository/new_repository/password_repository.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';

import '../../widget/gettextfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  bool visibleOldpass = true;
  bool visiblenewpass = true;
  bool visibleCofirmnewpass = true;
  TextEditingController oldpassController = TextEditingController();
  TextEditingController newpassController = TextEditingController();
  TextEditingController confirmNewpassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
          ),
        ),
        title: Text(
          'เปลี่นนรหัสผ่าน',
          style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black54)]
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: <Color>[
              //     Color.fromARGB(200, 43, 166, 223).withAlpha(255),
              //     Color.fromARGB(180, 41, 88, 162).withAlpha(162),
              //   ],
              // ),
              //color: Color.fromARGB(200, 43, 166, 223),
              ),
        ),
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.black45, blurRadius: 0.5),
                    ],
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'รหัสผ่าน\nเดิม : ',
                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: GetTextField(
                              controller: oldpassController,
                              visible: visibleOldpass,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'กรุณากรอกข้อมูล';
                                } else {
                                  return null;
                                }
                              },
                              preIcon: Icons.lock_open_sharp,
                              visiblePress: () {
                                setState(() {
                                  visibleOldpass = !visibleOldpass;
                                });
                              },
                              sufIcon: visibleOldpass ? Icons.visibility : Icons.visibility_off,
                              enableIconPrefix: true,
                              title: 'รหัสผ่านเดิม',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.black45, blurRadius: 0.5),
                    ],
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'รหัสผ่านใหม่ : ',
                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: GetTextField(
                              controller: newpassController,
                              visible: visiblenewpass,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'กรุณากรอกข้อมูล';
                                } else {
                                  return null;
                                }
                              },
                              preIcon: Icons.lock_outline_rounded,
                              visiblePress: () {
                                setState(() {
                                  visiblenewpass = !visiblenewpass;
                                });
                              },
                              sufIcon: visiblenewpass ? Icons.visibility : Icons.visibility_off,
                              enableIconPrefix: true,
                              title: 'รหัสผ่านใหม่',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'ยืนยันรหัสผ่านใหม่ : ',
                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: GetTextField(
                              visible: visibleCofirmnewpass,
                              controller: confirmNewpassController,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'กรุณากรอกข้อมูล';
                                } else {
                                  return null;
                                }
                              },
                              preIcon: Icons.lock,
                              visiblePress: () {
                                setState(() {
                                  visibleCofirmnewpass = !visibleCofirmnewpass;
                                });
                              },
                              sufIcon: visibleCofirmnewpass ? Icons.visibility : Icons.visibility_off,
                              enableIconPrefix: true,
                              title: 'รหัสผ่านใหม่',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    loadingDialog(context);
                    PasswordRepository().updatePassword(oldpassController.text, newpassController.text, confirmNewpassController.text).then((value) {
                      if (value['status'] == true) {
                        Navigator.pop(context);
                        correctDialog(context, value['message']);
                        oldpassController.clear();
                        newpassController.clear();
                        confirmNewpassController.clear();
                      } else {
                        Navigator.pop(context);
                        responseDialog(context, value['message']);
                      }
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'บันทึก',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void responseDialog(BuildContext context, String msg) {
    Dialogs.materialDialog(
        color: Colors.white,
        msg: msg,
        title: 'แจ้งเตือนจากระบบ',
        lottieBuilder: Lottie.asset(
          'assets/lottie/97670-tomato-error.json',
          fit: BoxFit.contain,
        ),
        customView: Container(),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'ปิด',
            iconData: Icons.close,
            color: Colors.blue,
            textStyle: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            iconColor: Colors.white,
          ),
        ]);
  }

  void loadingDialog(BuildContext context) {
    Dialogs.materialDialog(
      barrierDismissible: false,
      color: Colors.white,
      title: 'กำลังดำเนินการ กรุณารอสักครู่..',
      lottieBuilder: Lottie.asset(
        'assets/lottie/7996-rocket-fast.json',
        frameRate: FrameRate(60),
      ),
      customView: Container(),
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      context: context,
    );
  }

  void correctDialog(BuildContext context, String msg) {
    Dialogs.materialDialog(
        color: Colors.white,
        msg: msg,
        title: 'เปลี่ยนรหัสผ่านสำเร็จสำเร็จ!!',
        lottieBuilder: Lottie.asset(
          'assets/lottie/correct.json',
          fit: BoxFit.contain,
        ),
        customView: Container(),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            text: 'ปิด',
            iconData: Icons.close,
            color: Colors.blue,
            textStyle: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            iconColor: Colors.white,
          ),
        ]);
  }
}
