import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectship_app/bloc/address_bloc/address_bloc.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/customindicator.dart';
import 'package:perfectship_app/widget/fontsize.dart';
import 'package:perfectship_app/widget/gettextfield.dart';
import 'package:perfectship_app/widget/searchAddressHelperDelegate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/keyboard_overlay.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);
  static const String routeName = '/addaddress';

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => AddAddressScreen());
  }

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

final _namecontroller = TextEditingController();
final _phonecontroller = TextEditingController();
final _addresscontroller = TextEditingController();
final _provinceController = TextEditingController();
final _districtController = TextEditingController();
final _subdistrictController = TextEditingController();
final _zipcodeController = TextEditingController();
final _typeaheadcontroller = TextEditingController();
final _formKey = GlobalKey<FormState>();
final FocusNode _nodephone = FocusNode();
final FocusNode _nodezipcode = FocusNode();

class _AddAddressScreenState extends State<AddAddressScreen> {
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
    _nodezipcode.addListener(() {
      bool hasFocus = _nodezipcode.hasFocus;
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
    return Scaffold(
      appBar: CustomAppBar(
        title: 'เพิ่มที่อยู่ใหม่',
        backArrow: true,
        onPressArrow: () {
          _namecontroller.clear();
          _phonecontroller.clear();
          _addresscontroller.clear();
          _districtController.clear();
          _provinceController.clear();
          _subdistrictController.clear();
          _zipcodeController.clear();
          _typeaheadcontroller.clear();
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)]),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.search,
                          color: Color.fromARGB(255, 41, 88, 162),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ตัวช่วยค้นหาที่อยู่ (ตำบล / อำเภอ / จังหวัด / รหัสไปรษณีย์)',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 41, 88, 162),
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetTextField(
                      textInputType: TextInputType.none,
                      onTap: () {
                        showSearch(
                            context: context,
                            delegate: SearchAddressDelegate(
                                provincecontroller: _provinceController,
                                amphurecontroller: _districtController,
                                districtcontroller: _subdistrictController,
                                zipcodecontroller: _zipcodeController,
                                typeaheadcontroller: _typeaheadcontroller));
                      },
                      controller: _typeaheadcontroller,
                      title: 'ค้นหาตำบล/ อำเภอ/ จังหวัด/ รหัสไปรษณีย์',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.person_alt_circle,
                          color: Color.fromARGB(255, 41, 88, 162),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ชื่อผู้ส่ง',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 41, 88, 162),
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                      title: 'นายทดสอบ ระบบ',
                      textInputAction: TextInputAction.next,
                      controller: _namecontroller,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.phone,
                          color: Color.fromARGB(255, 41, 88, 162),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'เบอร์โทร',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 41, 88, 162),
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                      title: '092xxxxxxx',
                      textInputType: TextInputType.phone,
                      controller: _phonecontroller,
                      focusNode: _nodephone,
                      textInputAction: TextInputAction.next,
                      maxLength: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.house_alt,
                          color: Color.fromARGB(255, 41, 88, 162),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'เลขที่ ',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 41, 88, 162),
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                      title: '57/11',
                      textInputAction: TextInputAction.next,
                      controller: _addresscontroller,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location,
                          color: Color.fromARGB(255, 41, 88, 162),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ตำบล / แขวง',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 41, 88, 162),
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                      title: 'สายไหม',
                      controller: _subdistrictController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location,
                          color: Color.fromARGB(255, 41, 88, 162),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'อำเภอ / เขต',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 41, 88, 162),
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                      title: 'สายไหม',
                      controller: _districtController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location,
                          color: Color.fromARGB(255, 41, 88, 162),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'จังหวัด',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 41, 88, 162),
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                      title: 'กรุงเทพ',
                      controller: _provinceController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.envelope_circle,
                          color: Color.fromARGB(255, 41, 88, 162),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'รหัสไปรษณีย์',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 41, 88, 162),
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetTextField(
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                      title: '10210',
                      controller: _zipcodeController,
                      focusNode: _nodezipcode,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        if (state is AddressLoading) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: CupertinoButton(
                                  color: Color.fromARGB(255, 41, 88, 162),
                                  onPressed: () {},
                                  child:
                                      CustomProgessIndicator(Colors.white, 20)),
                            ),
                          );
                        } else if (state is AddressLoaded) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: CupertinoButton(
                                color: Color.fromARGB(255, 41, 88, 162),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    print('object');
                                    context.read<AddressBloc>().add(
                                        AddAddressEvent(
                                            name: _namecontroller,
                                            phone: _phonecontroller,
                                            address: _addresscontroller,
                                            subdistrict: _subdistrictController,
                                            district: _districtController,
                                            province: _provinceController,
                                            zipcode: _zipcodeController,
                                            typeahead: _typeaheadcontroller,
                                            context: context));
                                  }
                                },
                                child: Text('บันทึกข้อมูล',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: PlatformSize(context),
                                            fontWeight: FontWeight.bold)),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
