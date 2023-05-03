import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:perfectship_app/model/bank_model.dart';
import 'package:perfectship_app/repository/bank_repository.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/fontsize.dart';
import 'package:perfectship_app/widget/gettextfield.dart';

import '../../../bloc/userdata_bloc/user_data_bloc.dart';
import '../../../config/keyboard_overlay.dart';
import '../../../repository/getpathimage_repository.dart';

class VerifyBankScreen extends StatefulWidget {
  //final UserDataModel userdatamodel;
  const VerifyBankScreen({Key? key}) : super(key: key);
  static const String routeName = '/verifybank';

  static Route route() {
    return PageRouteBuilder(settings: const RouteSettings(name: routeName), pageBuilder: (_, __, ___) => VerifyBankScreen());
  }

  @override
  State<VerifyBankScreen> createState() => _VerifyBankScreenState();
}

class _VerifyBankScreenState extends State<VerifyBankScreen> {
  final TextEditingController _banknameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final FocusNode _branchnode = FocusNode();
  final FocusNode _accountnode = FocusNode();
  XFile? _imageFile;
  String path = '';
  final _formKey = GlobalKey<FormState>();
  selectImage(int choose) async {
    if (choose == 0) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = image;
        final byte = File(_imageFile!.path).readAsBytesSync();
        String base64Image = "data:image/png;base64," + base64Encode(byte);
        ImageRepository().getPathImage(image: base64Image, type: 'perfectship-app_bookbank').then((value) {
          setState(() {
            path = value;
            print('path = $path');
          });
        });
      });
    } else {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      //CameraOverlay();
      setState(() {
        _imageFile = photo;
        final byte = File(_imageFile!.path).readAsBytesSync();
        String base64Image = "data:image/png;base64," + base64Encode(byte);
        ImageRepository().getPathImage(image: base64Image, type: 'perfectship-app_bookbank').then((value) {
          setState(() {
            path = value;
            print(path);
          });
        });
      });
    }
  }

  late List<Banks> bank = [];
  Banks? _banks;

  // Future getBanks() async {
  //   BankRepository().getBank().then((value) {
  //     setState(() {
  //       bank = value;
  //       _banks = bank.firstWhere((element) => element.id == widget.userdatamodel.bankId);
  //     });
  //   });
  // }

  void _onDropDownItemSelected(Banks newSelectedBank) {
    setState(() {
      _banks = newSelectedBank;
      print('bankid = ${_banks!.id}');
    });
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.camera_on_rectangle, color: Colors.black54),
            SizedBox(
              width: 5,
            ),
            Text(
              'เลือกแหล่งที่มาของภาพ',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            onPressed: () {
              selectImage(1);
              Navigator.pop(context);
            },
            child: const Text(
              'กล้องถ่ายภาพ',
              style: TextStyle(fontSize: 18),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              selectImage(0);
              Navigator.pop(context);
            },
            child: const Text(
              'แกลเลอรี่',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as delete or exit and turns
          /// the action's text color to red.

          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'ยกเลิก',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  void _selectImage() {
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
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(84, 131, 128, 113),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_enhance_outlined,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'เลือกแหล่งที่มาภาพ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: PlatformSize(context)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black38,
                        height: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          selectImage(1);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'กล้องถ่ายภาพ',
                                  style: TextStyle(fontSize: PlatformSize(context)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectImage(0);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'แกลเลอรี่',
                                  style: TextStyle(fontSize: PlatformSize(context)),
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

  @override
  void initState() {
    // getBanks();
    // _accountController.text = widget.userdatamodel.accountNumber!;
    // _banknameController.text = widget.userdatamodel.accountName!;
    // _branchController.text = widget.userdatamodel.branchNo!;
    // path = widget.userdatamodel.bookBankUrl;
    // _branchnode.addListener(() {
    //   bool hasFocus = _branchnode.hasFocus;
    //   if (hasFocus) {
    //     Platform.isAndroid ? null : KeyboardOverlay.showOverlay(context);
    //   } else {
    //     KeyboardOverlay.removeOverlay();
    //   }
    // });
    // _accountnode.addListener(() {
    //   bool hasFocus = _accountnode.hasFocus;
    //   if (hasFocus) {
    //     Platform.isAndroid ? null : KeyboardOverlay.showOverlay(context);
    //   } else {
    //     KeyboardOverlay.removeOverlay();
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: CustomAppBar(
            title: 'ยืนยันบัญชีธนาคาร',
            backArrow: true,
            onPressArrow: () {
              Navigator.pop(context);
            }),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 1)]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 43, 166, 223),
                          Color.fromARGB(180, 41, 88, 162),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.0, 0.8],
                        tileMode: TileMode.clamp,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.creditcard,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'ข้อมูลบัญชีธนาคาร',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: Colors.white, fontSize: PlatformSize(context) * 1.2, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              path == ''
                                  ? Platform.isIOS
                                      ? _showActionSheet(context)
                                      : _selectImage()
                                  : null;
                            },
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.all(Radius.circular(8))),
                              height: 250,
                              child: Center(
                                child: path == ''
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.photo_on_rectangle,
                                            color: Colors.black54,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'ภาพสมุดบัญชี',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(color: Colors.black54, fontSize: PlatformSize(context) * 1.2, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: path,
                                            fit: BoxFit.fitHeight,
                                            progressIndicatorBuilder: (context, url, progress) => Center(
                                              child: CircularProgressIndicator(
                                                value: progress.progress,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // Platform.isIOS
                                              //     ? _showActionSheet(context)
                                              _selectImage();
                                            },
                                            child: Card(
                                              color: Colors.white70,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'เลือกรูปใหม่',
                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: PlatformSize(context)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.bank,
                              size: 20,
                              color: Color.fromARGB(255, 41, 88, 162),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'ธนาคาร',
                              style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Material(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField2(
                                    validator: (value) {
                                      if (value == null) {
                                        return 'กรุณาเลือกธนาคาร';
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '--โปรดเลือกธนาคาร--',
                                            style: TextStyle(
                                              fontSize: PlatformSize(context),
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: _banks,
                                    items: bank
                                        .map((item) => DropdownMenuItem<Banks>(
                                              value: item,
                                              child: Text(
                                                item.name,
                                                style: TextStyle(
                                                  fontSize: PlatformSize(context),
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _onDropDownItemSelected(value! as Banks);
                                      });
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      errorStyle: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                                      //Add isDense true and zero Padding.
                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2, color: Colors.amber),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      //Add more decoration as you want here
                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.black45,
                                      size: 20,
                                    ),
                                    iconSize: 30,
                                    buttonHeight: 45,
                                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      border: Border.all(width: 0.1, color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    dropdownMaxHeight: 250,
                                    scrollbarAlwaysShow: true,
                                    scrollbarThickness: 6,
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.person_alt_circle,
                              color: Color.fromARGB(255, 41, 88, 162),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'ชื่อบัญชี',
                              style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GetTextField(
                          textInputAction: TextInputAction.next,
                          controller: _banknameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกข้อมูล';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: Colors.white, boxShadow: [
                              BoxShadow(color: Colors.grey),
                            ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          //decoration: BoxDecoration(color: Colors.red),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.numbers_rounded,
                                                    color: Color.fromARGB(255, 41, 88, 162),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'รหัสสาขา',
                                                    style: Theme.of(context).textTheme.headline3!.copyWith(
                                                        fontWeight: FontWeight.bold, color: Colors.black54, fontSize: PlatformSize(context)),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                                  child: Material(
                                                      child: GetTextField(
                                                    textInputAction: TextInputAction.next,
                                                    focusNode: _branchnode,
                                                    controller: _branchController,
                                                    textInputType: TextInputType.number,
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'กรุณากรอกข้อมูล';
                                                      }
                                                      return null;
                                                    },
                                                  ))),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Container(
                                          //decoration: BoxDecoration(color: Colors.red),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.credit_card,
                                                    color: Color.fromARGB(255, 41, 88, 162),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'เลขบัญชี',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3!
                                                        .copyWith(fontWeight: FontWeight.bold, fontSize: PlatformSize(context)),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                                  child: Material(
                                                      child: GetTextField(
                                                    focusNode: _accountnode,
                                                    textInputAction: TextInputAction.done,
                                                    controller: _accountController,
                                                    textInputType: TextInputType.number,
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'กรุณากรอกข้อมูล';
                                                      }
                                                      return null;
                                                    },
                                                  ))),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: CupertinoButton(
                              color: Color.fromARGB(255, 41, 88, 162),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BankRepository()
                                      .updatebank(_banks!.id, _branchController.text, path, _banknameController.text, _accountController.text)
                                      .then((value) {
                                    if (value['status'] == true) {
                                      context.read<UserDataBloc>().add(UserDataInitialEvent());
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(msg: '${value['message']}');
                                    } else if (value['status'] == false) {
                                      Fluttertoast.showToast(msg: '${value['message']}');
                                    }
                                  });
                                }
                              },
                              child: Text('ยืนยันบัญชี',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.white, fontSize: PlatformSize(context), fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
