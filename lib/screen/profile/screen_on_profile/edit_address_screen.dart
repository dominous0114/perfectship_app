import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectship_app/bloc/address_bloc/address_bloc.dart';
import 'package:perfectship_app/model/address_model.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/customindicator.dart';

import '../../../config/keyboard_overlay.dart';
import '../../../widget/fontsize.dart';
import '../../../widget/gettextfield.dart';
import '../../../widget/searchAddressHelperDelegate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({Key? key, required this.addressModel})
      : super(key: key);
  static const String routeName = '/editaddress';
  final AddressModel addressModel;

  static Route route({required AddressModel addressModel}) {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => EditAddressScreen(
              addressModel: addressModel,
            ));
  }

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

TextEditingController namecontroller = TextEditingController();
TextEditingController phonecontroller = TextEditingController();
TextEditingController addresscontroller = TextEditingController();
TextEditingController provinceController = TextEditingController();
TextEditingController districtController = TextEditingController();
TextEditingController subdistrictController = TextEditingController();
TextEditingController zipcodeController = TextEditingController();
TextEditingController typeaheadcontroller = TextEditingController();
final _formKey = GlobalKey<FormState>();
final FocusNode _nodephone = FocusNode();
final FocusNode _nodezipcode = FocusNode();

class _EditAddressScreenState extends State<EditAddressScreen> {
  @override
  void initState() {
    namecontroller.text = widget.addressModel.name!;
    phonecontroller.text = widget.addressModel.phone!;
    addresscontroller.text = widget.addressModel.address!;
    provinceController.text = widget.addressModel.province!;
    districtController.text = widget.addressModel.district!;
    subdistrictController.text = widget.addressModel.subDistrict!;
    zipcodeController.text = widget.addressModel.zipcode!;
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
        title: 'แก้ไขที่อยู่',
        backArrow: true,
        onPressArrow: () {
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
                          color: Colors.blue.shade400,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ตัวช่วยค้นหาที่อยู่ (ตำบล / อำเภอ / จังหวัด / รหัสไปรษณีย์)',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: PlatformSize(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade300),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetTextField(
                      onTap: () {
                        showSearch(
                            context: context,
                            delegate: SearchAddressDelegate(
                                provincecontroller: provinceController,
                                amphurecontroller: districtController,
                                districtcontroller: subdistrictController,
                                zipcodecontroller: zipcodeController,
                                typeaheadcontroller: typeaheadcontroller));
                      },
                      controller: typeaheadcontroller,
                      title: 'ค้นหาตำบล/ อำเภอ/ จังหวัด/ รหัสไปรษณีย์',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.person_alt_circle,
                          color: Colors.blue.shade400,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ชื่อผู้ส่ง',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: PlatformSize(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade300),
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
                      controller: namecontroller,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.phone,
                          color: Colors.blue.shade400,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'เบอร์โทร',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: PlatformSize(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade300),
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
                      textInputAction: TextInputAction.next,
                      focusNode: _nodephone,
                      controller: phonecontroller,
                      maxLength: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.house_alt,
                          color: Colors.blue.shade400,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'เลขที่ ',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: PlatformSize(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade300),
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
                      controller: addresscontroller,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location,
                          color: Colors.blue.shade400,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ตำบล / แขวง',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: PlatformSize(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade300),
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
                      controller: subdistrictController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location,
                          color: Colors.blue.shade300,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'อำเภอ / เขต',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: PlatformSize(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade300),
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
                      controller: districtController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location,
                          color: Colors.blue.shade300,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'จังหวัด',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: PlatformSize(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade300),
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
                      controller: provinceController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.envelope_circle,
                          color: Colors.blue.shade400,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'รหัสไปรษณีย์',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: PlatformSize(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade300),
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
                      focusNode: _nodezipcode,
                      textInputAction: TextInputAction.done,
                      controller: zipcodeController,
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
                                  color: Colors.blue.shade300,
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
                                color: Colors.blue.shade300,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AddressBloc>().add(
                                        EditAddressEvent(
                                            id: widget.addressModel.id
                                                .toString(),
                                            name: namecontroller,
                                            phone: phonecontroller,
                                            address: addresscontroller,
                                            subdistrict: subdistrictController,
                                            district: districtController,
                                            province: provinceController,
                                            zipcode: zipcodeController,
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
