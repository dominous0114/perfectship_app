import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perfectship_app/bloc/dropdown_courier_bloc/dropdown_courier_bloc.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/courier_model.dart';
import '../../../model/productcategory_model.dart';
import '../../../repository/courier_repository.dart';
import '../../../widget/fontsize.dart';

class SettingShippingScreen extends StatefulWidget {
  const SettingShippingScreen({Key? key}) : super(key: key);
  static const String routeName = '/settingshipping';

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => SettingShippingScreen());
  }

  @override
  State<SettingShippingScreen> createState() => _SettingShippingScreenState();
}

class _SettingShippingScreenState extends State<SettingShippingScreen> {
  final _formKey = GlobalKey<FormState>();
  late List<CourierModel> courier = [];
  CourierModel? _courier;
  ProductCategory? _productCategory;
  int? initpush;
  String? courcode;
  int? procatid;
  String selected = "";
  List checkListItems = [
    {
      "id": 0,
      "value": false,
      "title": "ถามทุกครั้ง",
    },
    {
      "id": 1,
      "value": false,
      "title": "ไปหน้าพัสดุทันที",
    },
    {
      "id": 2,
      "value": false,
      "title": "อยู่หน้ารายการ",
    },
  ];
  Future getCourier() async {
    CourierRepository().getCourier().then((value) {
      setState(() {
        courier = value;
        courier.removeWhere((element) => element.id == 1);
        getinitsetting();
      });
    });
  }

  void _onDropDownItemSelected(CourierModel newSelected) {
    setState(() {
      _courier = newSelected;
      print('courierid = ${_courier!.code}');
    });
  }

  void getinitsetting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    courcode = preferences.getString('initshipping');
    procatid = preferences.getInt('initcat');
    initpush = preferences.getInt('initpush');
    if (initpush == null) {
      initpush = 0;
      checkListItems[0]["value"] = true;
    } else {
      checkListItems[initpush!]["value"] = true;
    }

    _courier = courier.firstWhere((element) => element.code == courcode);

    _productCategory = ProductCategory.category
        .firstWhere((element) => element.id == procatid);
  }

  void _onDropDownItemSelectedCategory(ProductCategory newSelected) {
    setState(() {
      _productCategory = newSelected;
      print('categoryid = ${_productCategory!.id}');
    });
  }

  @override
  void initState() {
    getCourier();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'ตั้งค่าการส่งพัสดุ',
          backArrow: true,
          onPressArrow: () {
            Navigator.pop(context);
          }),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 1, color: Colors.grey)],
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  topRight: Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.truck,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'ข้อมูลการจัดส่งเริ่มต้น',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: PlatformSize(context) * 1.1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'ขนส่ง',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 41, 88, 162)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Material(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField2(
                                    validator: (value) {
                                      if (value == null) {
                                        return 'กรุณาเลือกขนส่ง';
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
                                            '--โปรดเลือกขนส่ง--',
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
                                    value: _courier,
                                    items: courier
                                        .map((item) =>
                                            DropdownMenuItem<CourierModel>(
                                              value: item,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      child: Image.network(
                                                          '${item.logoMobile}'),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      item.name!,
                                                      style: TextStyle(
                                                        fontSize: PlatformSize(
                                                            context),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _onDropDownItemSelected(
                                            value! as CourierModel);
                                      });
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      errorStyle: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                      //Add isDense true and zero Padding.
                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      //Add more decoration as you want here
                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                    ),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.white,
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.black45,
                                      size: 20,
                                    ),
                                    iconSize: 30,
                                    buttonHeight: 45,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      border: Border.all(width: 0.1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    dropdownMaxHeight: 250,
                                    scrollbarAlwaysShow: true,
                                    scrollbarThickness: 6,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'ประเภทพัสดุ',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 41, 88, 162)),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5, left: 4, right: 4),
                          child: Material(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField2(
                                    validator: (value) {
                                      if (value == null) {
                                        return 'กรุณาเลือกประเภทพัสดุ';
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
                                            '--โปรดเลือกประเภทพัสดุ--',
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
                                    value: _productCategory,
                                    items: ProductCategory.category
                                        .map((item) =>
                                            DropdownMenuItem<ProductCategory>(
                                              value: item,
                                              child: Text(
                                                item.name,
                                                style: TextStyle(
                                                  fontSize:
                                                      PlatformSize(context),
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      _onDropDownItemSelectedCategory(
                                          value as ProductCategory);
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      errorStyle: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                      //Add isDense true and zero Padding.
                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      //Add more decoration as you want here
                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                    ),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.white,
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.black45,
                                      size: 20,
                                    ),
                                    iconSize: 30,
                                    buttonHeight: 45,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      border: Border.all(width: 0.1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    dropdownMaxHeight: 250,
                                    scrollbarAlwaysShow: true,
                                    scrollbarThickness: 6,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 1, color: Colors.grey)],
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                topRight: Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.notification_important,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'การเปลี่ยนหน้าหลังจากการสร้างรายการ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: PlatformSize(context) * 1.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: List.generate(
                          checkListItems.length,
                          (index) => CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: Text(
                              checkListItems[index]["title"],
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            value: checkListItems[index]["value"],
                            onChanged: checkListItems[index]["value"] == true
                                ? (value) {}
                                : (value) {
                                    setState(() {
                                      for (var element in checkListItems) {
                                        if (element["value"] == true) {
                                          element["value"] = false;
                                        }
                                      }
                                      checkListItems[index]["value"] = value;
                                      initpush = checkListItems[index]["id"];
                                      print(initpush);
                                      // selected =
                                      //     "${checkListItems[index]["id"]}, ${checkListItems[index]["title"]}, ${checkListItems[index]["value"]}";
                                    });
                                  },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoButton(
                    color: Color.fromARGB(255, 41, 88, 162),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString('initshipping', _courier!.code!);
                        preferences.setInt('initcat', _productCategory!.id);
                        preferences.setInt('initpush', initpush!);
                        Fluttertoast.showToast(msg: 'บันทึกการตั้งค่าสำเร็จ');
                        Navigator.pop(context);
                        context
                            .read<DropdownCourierBloc>()
                            .add(DropdownCourierIniitialEvent());
                      }
                    },
                    child: Text('บันทึกการตั้งค่า',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.white,
                            fontSize: PlatformSize(context),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
