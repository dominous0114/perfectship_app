import 'package:flutter/material.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';

import '../../widget/gettextfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'เปลี่ยนรหัสผ่าน',
        backArrow: true,
        onPressArrow: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
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
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'กรุณากรอกข้อมูล';
                              } else {
                                return null;
                              }
                            },
                            textInputType: TextInputType.none,
                            preIcon: Icons.map_rounded,
                            enableIconPrefix: true,
                            title: 'จังหวัด',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
