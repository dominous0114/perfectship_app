import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:perfectship_app/bloc/new_bloc/create_order/create_order_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/model/new_model/bank_new_model.dart';
import 'package:perfectship_app/repository/new_repository/user_data_repository.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import '../../model/new_model/address_search_new_model.dart';
import '../../widget/fontsize.dart';
import '../../widget/gettextfield.dart';
import '../createorder/new_widget/search_address_delegate.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  FocusNode searchFocus = FocusNode();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String idpath = '';
  String bookbankpath = '';
  bool idloading = false;
  bool bookbankloading = false;

  void _selectImage(String type) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        )),
        context: context,
        builder: (context) {
          return SafeArea(
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Container(
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          type == 'idcard' ? selectImageId(1) : selectImageBank(1);
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'กล้องถ่ายภาพ',
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          type == 'idcard' ? selectImageId(0) : selectImageBank(0);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade300,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'แกลเลอรี่',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  selectImageId(int choose) async {
    if (choose == 0) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1000, maxHeight: 500);
      setState(() {
        _imageFile = image;
        final byte = File(_imageFile!.path).readAsBytesSync();
        String base64Image = "data:image/png;base64," + base64Encode(byte);
        idloading = true;
        UserDataRepository().uploadImage(image: base64Image, type: 'idcard').then((value) {
          setState(() {
            idloading = false;
            idpath = value;
            context.read<UserDataBloc>().add(UserIdcardUploadImageEvent(idcardUrl: value));
            print('VALUE > $value');
            print('PATH > $idpath');
          });
        });
      });
    } else {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera, maxWidth: 1000, maxHeight: 500);
      //CameraOverlay();
      setState(() {
        idloading = true;
        _imageFile = photo;
        final byte = File(_imageFile!.path).readAsBytesSync();
        String base64Image = "data:image/png;base64," + base64Encode(byte);
        UserDataRepository().uploadImage(image: base64Image, type: 'idcard').then((value) {
          setState(() {
            idloading = false;
            idpath = value;
            context.read<UserDataBloc>().add(UserIdcardUploadImageEvent(idcardUrl: value));
          });
        });
      });
    }
  }

  selectImageBank(int choose) async {
    if (choose == 0) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1000, maxHeight: 500);
      setState(() {
        bookbankloading = true;
        _imageFile = image;
        final byte = File(_imageFile!.path).readAsBytesSync();
        String base64Image = "data:image/png;base64," + base64Encode(byte);
        UserDataRepository().uploadImage(image: base64Image, type: 'bookbank').then((value) {
          setState(() {
            bookbankloading = false;
            idpath = value;
            context.read<UserDataBloc>().add(UserBookbankUploadImageEvent(bookbankUrl: value));
            print('VALUE > $value');
            print('PATH > $idpath');
          });
        });
      });
    } else {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera, maxWidth: 1000, maxHeight: 500);
      //CameraOverlay();
      setState(() {
        bookbankloading = true;
        _imageFile = photo;
        final byte = File(_imageFile!.path).readAsBytesSync();
        String base64Image = "data:image/png;base64," + base64Encode(byte);
        UserDataRepository().uploadImage(image: base64Image, type: 'bookbank').then((value) {
          setState(() {
            bookbankloading = false;
            idpath = value;
            context.read<UserDataBloc>().add(UserBookbankUploadImageEvent(bookbankUrl: value));
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(200, 43, 166, 223),
              Color.fromARGB(180, 12, 13, 14),
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
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 60,
                  elevation: 0,
                  title: Text(
                    'แก้ไขข้อมูลผู้ส่ง',
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
                body: BlocBuilder<UserDataBloc, UserDataState>(
                  builder: (context, state) {
                    if (state is UserDataLoading) {
                      return LoadingShimmer();
                    } else if (state is UserDataLoaded) {
                      return Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 1)]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'ชื่อผู้ส่ง : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                controller: state.nameController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (v) {
                                                  //context.read<CreateOrderBloc>().add(OnAddressChangeEvent(address: v));
                                                },
                                                preIcon: CupertinoIcons.person_alt_circle,
                                                enableIconPrefix: true,
                                                title: 'คุณ เฟอร์เฟคชิพ',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'บัตรประชาชน : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                textInputType: TextInputType.numberWithOptions(),
                                                maxLength: 13,
                                                controller: state.idcardController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (v) {
                                                  //context.read<CreateOrderBloc>().add(OnAddressChangeEvent(address: v));
                                                },
                                                preIcon: Icons.credit_card,
                                                enableIconPrefix: true,
                                                title: '1234567891234',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'ภาพบัตรประชาชน : ',
                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        idloading == true
                                            ? Container(
                                                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                                                height: 120,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Lottie.asset(
                                                          'assets/lottie/7996-rocket-fast.json',
                                                          width: 50,
                                                          height: 50,
                                                          frameRate: FrameRate(60),
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text('กำลังอัพโหลดภาพ..')
                                                      ],
                                                    ),
                                                  ],
                                                ))
                                            : state.userdatamodel.cardUrl == null || state.userdatamodel.cardUrl == ''
                                                ? GestureDetector(
                                                    onTap: () {
                                                      _selectImage('idcard');
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                                                      height: 120,
                                                      child: idloading == true
                                                          ? Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                  Icons.camera_alt_outlined,
                                                                  color: Colors.blue,
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text('อัพโหลดภาพ')
                                                              ],
                                                            )
                                                          : Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                  Icons.camera_alt_outlined,
                                                                  color: Colors.blue,
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text('อัพโหลดภาพ')
                                                              ],
                                                            ),
                                                    ),
                                                  )
                                                : Stack(
                                                    alignment: Alignment.bottomRight,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                                                        height: 120,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pushNamed(context, '/photo-widget',
                                                                      arguments: state.userdatamodel.cardUrl);
                                                                },
                                                                child: Image.network(state.userdatamodel.cardUrl))
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 5, bottom: 5),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _selectImage('idcard');
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                color: Colors.white.withOpacity(0.9),
                                                                borderRadius: BorderRadius.circular(8),
                                                                boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 0.5)],
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text('เลือกภาพใหม่'),
                                                              )),
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
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  '   ข้อมูลบัญชี',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 1)]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'ธนาคาร : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField2<BankModel>(
                                                  validator: (v) {
                                                    if (v == null) {
                                                      return 'กรุณาเลือกธนาคาร';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  hint: Text(
                                                    '    เลือกธนาคาร',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(color: Colors.black45, fontWeight: FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  buttonHeight: 50,
                                                  dropdownDecoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14),
                                                    boxShadow: [
                                                      BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                                    ],
                                                  ),
                                                  buttonDecoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.black54),
                                                  ),
                                                  dropdownElevation: 8,
                                                  scrollbarRadius: const Radius.circular(40),
                                                  dropdownMaxHeight: 400,
                                                  scrollbarThickness: 6,
                                                  scrollbarAlwaysShow: true,
                                                  offset: const Offset(0, -20),
                                                  selectedItemHighlightColor: Colors.blue.shade50.withOpacity(.4),
                                                  items: state.bankModel.map<DropdownMenuItem<BankModel>>((e) {
                                                    return DropdownMenuItem(
                                                        value: e,
                                                        child: Container(
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  e.name ?? '',
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .headline5!
                                                                      .copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    //ontext.read<CreateOrderBloc>().add(OrderSelectFuze(value: value!));
                                                    //  _onDropDownItemSelected(value!);
                                                    print(value!.name);
                                                    // context.read<CreateOrderBloc>().add(SelectCourierEvent(courier: value));
                                                    // print(state.customerId);

                                                    context.read<UserDataBloc>().add(UserdataOnselectBank(bank: value));
                                                  },
                                                  value: state.bankSelect,
                                                  buttonPadding: EdgeInsets.all(0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'ชื่อบัญชี : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                controller: state.accountNameController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (v) {
                                                  //context.read<CreateOrderBloc>().add(OnAddressChangeEvent(address: v));
                                                },
                                                preIcon: Icons.credit_card,
                                                enableIconPrefix: true,
                                                title: 'ชื่อบัญชี',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'เลขบัญชี : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                textInputType: TextInputType.numberWithOptions(),
                                                controller: state.accountNoController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (v) {
                                                  //context.read<CreateOrderBloc>().add(OnAddressChangeEvent(address: v));
                                                },
                                                preIcon: Icons.onetwothree_sharp,
                                                enableIconPrefix: true,
                                                title: 'เลขบัญชี',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'รหัสสาขา : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                controller: state.accountBranchController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (v) {
                                                  //context.read<CreateOrderBloc>().add(OnAddressChangeEvent(address: v));
                                                },
                                                preIcon: Icons.account_balance,
                                                enableIconPrefix: true,
                                                title: 'รหัสสาขา',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'ภาพสมุดบัญชี : ',
                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        bookbankloading == true
                                            ? Container(
                                                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                                                height: 120,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Lottie.asset(
                                                          'assets/lottie/7996-rocket-fast.json',
                                                          width: 50,
                                                          height: 50,
                                                          frameRate: FrameRate(60),
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text('กำลังอัพโหลดภาพ..')
                                                      ],
                                                    ),
                                                  ],
                                                ))
                                            : state.userdatamodel.bookBankUrl == null || state.userdatamodel.bookBankUrl == ''
                                                ? GestureDetector(
                                                    onTap: () {
                                                      _selectImage('bookbank');
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                                                      height: 120,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.camera_alt_outlined,
                                                            color: Colors.blue,
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text('อัพโหลดภาพ')
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Stack(
                                                    alignment: Alignment.bottomRight,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                                                        height: 120,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pushNamed(context, '/photo-widget',
                                                                      arguments: state.userdatamodel.bookBankUrl);
                                                                },
                                                                child: Image.network(state.userdatamodel.bookBankUrl))
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 5, bottom: 5),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _selectImage('bookbank');
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white.withOpacity(0.9),
                                                                  borderRadius: BorderRadius.circular(8),
                                                                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 0.5)]),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text('เลือกภาพใหม่'),
                                                              )),
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
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  '   ข้อมูลที่อยู่',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 1)]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('ค้นหาที่อยู่', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        GetTextField(
                                          focusNode: searchFocus,
                                          onTap: () async {
                                            searchFocus.unfocus();
                                            // searchFocusNode.unfocus();
                                            AddressSearchNewModel address = await showSearch(context: context, delegate: SearcgAddressNewDelegate());
                                            print(address.amphure);
                                            context.read<UserDataBloc>().add(UserdataSelectAddressEvent(
                                                subDistrict: address.district!,
                                                district: address.amphure!,
                                                province: address.province!,
                                                zipcode: address.zipcode!));
                                            // context.read<CreateOrderBloc>().add(SelectAddressManulEvent(addressSearchNewModel: address));
                                            // districtController.text = address.amphure!;
                                            // subdistrictController.text = address.district!;
                                            // provinceController.text = address.province!;
                                            // zipcodeController.text = address.zipcode!;
                                          },
                                          textInputType: TextInputType.none,
                                          preIcon: Icons.search,
                                          enableIconPrefix: true,
                                          title: 'ค้นหา จังหวัด ตำบล อำเภอ',
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'บ้านเลขที่ : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                controller: state.addressController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (v) {
                                                  //context.read<CreateOrderBloc>().add(OnAddressChangeEvent(address: v));
                                                },
                                                //controller: addressController,
                                                preIcon: CupertinoIcons.envelope,
                                                enableIconPrefix: true,
                                                title: 'บ้านเลขที่9/8 ซอย7 หมู่6',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'ตำบล : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                controller: state.subDistrictController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                //controller: subdistrictController,
                                                preIcon: CupertinoIcons.house,
                                                textInputType: TextInputType.none,
                                                enableIconPrefix: true,
                                                title: 'ตำบล',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'อำเภอ : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                controller: state.districtController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                //controller: districtController,
                                                textInputType: TextInputType.none,
                                                preIcon: CupertinoIcons.house_fill,
                                                enableIconPrefix: true,
                                                title: 'อำเภอ',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'จังหวัด : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                controller: state.provinceController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                //controller: provinceController,
                                                textInputType: TextInputType.none,
                                                preIcon: Icons.map_rounded,
                                                enableIconPrefix: true,
                                                title: 'จังหวัด',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'รหัสไปรษณีย์ : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                controller: state.zipcodeController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                //controller: zipcodeController,
                                                textInputType: TextInputType.none,
                                                preIcon: CupertinoIcons.envelope_open,
                                                enableIconPrefix: true,
                                                title: 'รหัสไปรษณีย์',
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
                                      UserDataRepository()
                                          .updateUser(
                                              customerid: state.userdatamodel.id!,
                                              name: state.nameController.text,
                                              cardId: state.idcardController.text,
                                              cardUrl: state.userdatamodel.cardUrl,
                                              bankId: state.bankSelect.id.toString(),
                                              accountName: state.accountNameController.text,
                                              accountNumber: state.accountNoController.text,
                                              branchNo: state.accountBranchController.text,
                                              bookbankUrl: state.userdatamodel.bookBankUrl,
                                              address: state.addressController.text,
                                              subDistrict: state.subDistrictController.text,
                                              district: state.districtController.text,
                                              province: state.provinceController.text,
                                              zipcode: state.zipcodeController.text)
                                          .then((value) {
                                        if (value['status'] == true) {
                                          Navigator.pop(context);
                                          correctDialog(context, value['message']);
                                          context.read<UserDataBloc>().add(UserDataInitialEvent());
                                          context.read<CreateOrderBloc>().add(OnEditSrcDataEvent(
                                              name: state.nameController.text,
                                              subDistrict: state.subDistrictController.text,
                                              district: state.districtController.text,
                                              province: state.provinceController.text,
                                              zipcode: state.zipcodeController.text));
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
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text('มีบางอย่างผิกพลาด'),
                      );
                    }
                  },
                ),
              ),
            )));
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
      title: 'กำลังแก้ไข กรุณารอสักครู่..',
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
        title: 'แก้ไขสำเร็จ!!',
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
