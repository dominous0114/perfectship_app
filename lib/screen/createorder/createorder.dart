import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perfectship_app/bloc/orders_bloc/order_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/model/address_model.dart';
import 'package:perfectship_app/model/courier_model.dart';
import 'package:perfectship_app/repository/address_repository.dart';
import 'package:perfectship_app/repository/courier_repository.dart';
import 'package:perfectship_app/screen/profile/screen_on_profile/edit_address_screen.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/customindicator.dart';
import 'package:perfectship_app/widget/fontsize.dart';
import 'package:perfectship_app/widget/searchAddressHelperDelegate.dart';
import 'package:perfectship_app/widget/searchPhoneDelegate.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/address_bloc/address_bloc.dart';
import '../../model/normalize_model.dart';
import '../../model/productcategory_model.dart';
import '../../widget/gettextfield.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  TextEditingController dstnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController subdistrictController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController extractController = TextEditingController();
  TextEditingController searchhelperController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController codController = TextEditingController();
  TextEditingController insuController = TextEditingController();
  bool loadextract = false;
  final _formKey = GlobalKey<FormState>();
  late List<CourierModel> courier = [];
  CourierModel? _courier;
  var isExpanded = false;
  var isExpandedInsu = false;
  var isExpandedSaveaddress = true;
  int insu = 0;
  int saveaddress = 1;
  ProductCategory? _productCategory;
  String labelname = '';
  String labelphone = '';
  String labeladdress = '';
  String labelzipcode = '';
  String srcname = '';
  String srcphone = '';
  String srcsubdistrict = '';
  String srcdistrict = '';
  String srcaddress = '';
  String srcprovince = '';
  String srczipcode = '';
  String accountname = '';
  String accountnumber = '';
  String branchno = '';
  String bankid = '';

  _onExpansionChanged(bool val) {
    setState(() {
      isExpanded = val;
    });
  }

  _onExpansionInsuChanged(bool val) {
    setState(() {
      isExpandedInsu = val;
      if (val == true) {
        insu = 1;
      } else {
        insuController.clear();
        insu = 0;
      }
      print('insu = $insu');
    });
  }

  _onExpansionSaveAddressChanged(bool val) {
    setState(() {
      isExpandedSaveaddress = val;
      if (val == true) {
        saveaddress = 1;
      } else {
        saveaddress = 0;
      }
      print('insu = $insu');
    });
  }

  Future getCourier() async {
    CourierRepository().getCourier().then((value) {
      setState(() {
        courier = value;
        courier.removeWhere((element) => element.id == 1);
      });
    });
  }

  void _onDropDownItemSelected(CourierModel newSelected) {
    setState(() {
      _courier = newSelected;
      print('courierid = ${_courier!.code}');
    });
  }

  void _onDropDownItemSelectedCategory(ProductCategory newSelected) {
    setState(() {
      _productCategory = newSelected;
      print('categoryid = ${_productCategory!.id}');
    });
  }

  systemExtract(BuildContext context, TextEditingController extractController,
      bool loadextract) {
    showDialog(
        barrierDismissible: true,
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return loadextract == true
                  ? Center(
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                    )
                  : CupertinoAlertDialog(
                      title: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.edit,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('ตัวช่วยแยกที่อยู่',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: PlatformSize(context))),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                extractController.text =
                                    'คุณ Perfectship \n0891234567 \nบ้านเลขที่ 11/22 ถนนเพลินจิต \nแขวงลุมพินี เขตปทุมวัน \nกรุงเทพมหานคร 10330';
                              },
                              child: Text('ใช้ตัวอย่าง',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                          fontSize: PlatformSize(context))),
                            )
                          ],
                        ),
                      ),
                      content: Column(
                        children: [
                          CupertinoTextField(
                            //padding: const EdgeInsets.all(0),
                            placeholder:
                                'คุณ Perfectship \n0891234567 \nบ้านเลขที่ 11/22 ถนนเพลินจิต \nแขวงลุมพินี เขตปทุมวัน \nกรุงเทพมหานคร 10330',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: PlatformSize(context)),
                            placeholderStyle: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontSize: PlatformSize(context)),
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            minLines: 10,
                            maxLines: 10,
                            controller: extractController,
                          ),
                        ],
                      ),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () {
                            setState(() {
                              loadextract = true;
                            });
                            if (extractController.text == '') {
                              Fluttertoast.showToast(msg: 'กรุณากรอกที่อยู่');
                              setState(() {
                                loadextract = false;
                              });
                            } else {
                              AddressRepository()
                                  .normalizeAddress(extractController.text)
                                  .then((value) {
                                if (value['status'] == true) {
                                  final normalize = Normalize.fromJson(value);
                                  print(normalize.cutAll);
                                  setState(() {
                                    phoneController.text = normalize.phone;
                                    dstnameController.text = normalize.name;
                                    houseNoController.text = normalize.cutAll;
                                    subdistrictController.text =
                                        normalize.district;
                                    districtController.text = normalize.amphure;
                                    provinceController.text =
                                        normalize.province;
                                    zipcodeController.text = normalize.zipcode;
                                    Fluttertoast.showToast(msg: 'คัดแยกสำเร็จ');
                                    extractController.text = '';
                                    Navigator.pop(context);
                                    setState(() {
                                      loadextract = false;
                                    });
                                  });

                                  print('test');
                                } else {
                                  setState(() {
                                    loadextract = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: '${value["msg"]}');
                                }
                              });
                            }
                          },
                          child: Text("ตกลง",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: PlatformSize(context))),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.pop(context);
                            extractController.text = '';
                          },
                          child: Text("ยกเลิก",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: PlatformSize(context))),
                        ),
                      ],
                    );
            },
          );
        });
  }

  @override
  void initState() {
    getCourier();
    context.read<AddressBloc>().add(AddressInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'CreateOrderScreen',
          backArrow: true,
          onPressArrow: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<UserDataBloc, UserDataState>(
                builder: (context, state) {
                  if (state is UserDataLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.black54, blurRadius: 1)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is UserDataLoaded) {
                    srcname = state.srcaddressmodel.name!;
                    srcphone = state.srcaddressmodel.phone!;
                    srcsubdistrict = state.srcaddressmodel.subDistrict!;
                    srcdistrict = state.srcaddressmodel.district!;
                    srcaddress = state.srcaddressmodel.address!;
                    srcprovince = state.srcaddressmodel.province!;
                    srczipcode = state.srcaddressmodel.zipcode!;
                    accountname = state.userdatamodel.accountName!;
                    accountnumber = state.userdatamodel.accountNumber!;
                    branchno = state.userdatamodel.branchNo!;
                    bankid = state.userdatamodel.bankId.toString();

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black54, blurRadius: 1)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/image/circle_perfectship.png'),
                                radius: 20,
                                backgroundColor: Colors.grey.shade100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        'เครดิต ${state.usercreditmodel.credit} บาท ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                              fontSize: PlatformSize(context),
                                              fontWeight: FontWeight.bold,
                                            )),
                                    Text(
                                        'สร้างได้ ${state.usercreditmodel.orderAmount} รายการ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                              fontSize: PlatformSize(context),
                                              fontWeight: FontWeight.bold,
                                            ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  if (state is AddressLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Container(
                          height: 95,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.black54, blurRadius: 1)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is AddressLoaded) {
                    // state.addressmodel
                    //     .where((element) => element.primaryAddress == 1);
                    Iterable<AddressModel> list = state.addressmodel
                        .where((element) => element.primaryAddress == 1);
                    print(list.length.toString());
                    return list.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(blurRadius: 1, color: Colors.grey)
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Column(
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.cube_box_fill,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'ผู้ส่ง (ที่อยู่แสดงบนใบปะหน้า)',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        PlatformSize(context) *
                                                            1.1,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.warning_amber_rounded,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              'คุณยังไม่มีมี่อยู่เริ่มต้น กรุณาเพิ่มที่อยู่เริ่มต้น',
                                              style: TextStyle(
                                                  fontSize:
                                                      PlatformSize(context),
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // context
                                            //     .read<AddressBloc>()
                                            //     .add(AddressInitialEvent());
                                            Navigator.pushNamed(
                                                context, '/addressoncreate');
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        200, 43, 166, 223),
                                                    Color.fromARGB(
                                                        180, 41, 88, 162),
                                                  ],
                                                  begin: Alignment.bottomLeft,
                                                  end: Alignment.topRight,
                                                  stops: [0.0, 0.8],
                                                  tileMode: TileMode.clamp,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'กดเพื่อเลือกที่อยู่',
                                                      style: TextStyle(
                                                          fontSize:
                                                              PlatformSize(
                                                                  context),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : MediaQuery.removePadding(
                            context: context,
                            removeBottom: true,
                            child: ListView.builder(
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: list.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  labelname = list.first.name!;
                                  labelphone = list.first.phone!;
                                  labeladdress = list.first.address!;
                                  labelzipcode = list.first.zipcode!;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/addressoncreate');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 1,
                                                  color: Colors.grey)
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          200, 43, 166, 223),
                                                      Color.fromARGB(
                                                          180, 41, 88, 162),
                                                    ],
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    stops: [0.0, 0.8],
                                                    tileMode: TileMode.clamp,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .cube_box_fill,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'ผู้ส่ง (ที่อยู่แสดงบนใบปะหน้า)',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  PlatformSize(
                                                                          context) *
                                                                      1.1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'ชื่อ :',
                                                        style: TextStyle(
                                                            fontSize:
                                                                PlatformSize(
                                                                    context),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        ' ${list.first.name} (${list.first.phone})',
                                                        style: TextStyle(
                                                            fontSize:
                                                                PlatformSize(
                                                                    context),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'ที่อยู่ :',
                                                        style: TextStyle(
                                                            fontSize:
                                                                PlatformSize(
                                                                    context),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        ' ${list.first.address} ${list.first.subDistrict} ${list.first.district} ${list.first.province} ${list.first.zipcode}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                PlatformSize(
                                                                    context),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                  } else {
                    return Container();
                  }
                },
              ),
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
                                      'ข้อมูลการจัดส่ง',
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 1, color: Colors.grey)],
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.cube_box,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'ผู้รับ (ที่อยู่ในการจัดส่ง)',
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ค้นหาที่อยู่ผู้รับ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: PlatformSize(context),
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 41, 88, 162)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    systemExtract(context, extractController,
                                        loadextract);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.amber.shade600,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        Icon(
                                          CupertinoIcons.layers_alt,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('ตัวช่วยแยกที่อยู่',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize:
                                                        PlatformSize(context),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GetTextField(
                              onTap: () {
                                showSearch(
                                    context: context,
                                    delegate: SearchPhoneDelegate(
                                        addresscontroller: houseNoController,
                                        namecontroller: dstnameController,
                                        phonecontroller: phoneController,
                                        provincecontroller: provinceController,
                                        amphurecontroller: districtController,
                                        districtcontroller:
                                            subdistrictController,
                                        zipcodecontroller: zipcodeController,
                                        typeaheadcontroller:
                                            searchhelperController));
                              },
                              enableIconPrefix: true,
                              preIcon: CupertinoIcons.phone,
                              title: '092xxxxxxx',
                              textInputType: TextInputType.none,
                              maxLength: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'ตัวช่วยค้นหาที่อยู่ (ตำบล / อำเภอ / จังหวัด / รหัสไปรษณีย์)',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      fontSize: PlatformSize(context),
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 41, 88, 162)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GetTextField(
                              textInputType: TextInputType.none,
                              controller: searchhelperController,
                              onTap: () {
                                showSearch(
                                    context: context,
                                    delegate: SearchAddressDelegate(
                                        provincecontroller: provinceController,
                                        amphurecontroller: districtController,
                                        districtcontroller:
                                            subdistrictController,
                                        zipcodecontroller: zipcodeController,
                                        typeaheadcontroller:
                                            searchhelperController));
                              },
                              enableIconPrefix: true,
                              preIcon: CupertinoIcons.search,
                              title: 'ค้นหาตำบล/ อำเภอ/ จังหวัด/ รหัสไปรษณีย์',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'ชื่อผู้รับ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      fontSize: PlatformSize(context),
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 41, 88, 162)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GetTextField(
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกข้อมูล';
                                }
                                return null;
                              },
                              controller: dstnameController,
                              enableIconPrefix: true,
                              preIcon: CupertinoIcons.person_alt_circle_fill,
                              title: 'ชื่อผู้รับ',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'เบอร์โทร',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: PlatformSize(context),
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 41, 88, 162)),
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
                                } else if (value.length < 10) {
                                  return 'กรุณาเบอร์โทรศัพท์ให้ถูกต้อง';
                                }
                                return null;
                              },
                              controller: phoneController,
                              enableIconPrefix: true,
                              preIcon: CupertinoIcons.phone,
                              title: '092xxxxxxx',
                              textInputType: TextInputType.phone,
                              maxLength: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'บ้านเลขที่',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: PlatformSize(context),
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 41, 88, 162)),
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
                              controller: houseNoController,
                              enableIconPrefix: true,
                              preIcon: CupertinoIcons.house_fill,
                              title: '57/11',
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'ตำบล / แขวง',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: PlatformSize(context),
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 41, 88, 162)),
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
                              controller: subdistrictController,
                              enableIconPrefix: true,
                              preIcon: CupertinoIcons.location_circle_fill,
                              title: 'สายไหม',
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'อำเภอ / เขต',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: PlatformSize(context),
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 41, 88, 162)),
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
                              controller: districtController,
                              enableIconPrefix: true,
                              preIcon: CupertinoIcons.location_circle_fill,
                              title: 'สายไหม',
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'จังหวัด',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: PlatformSize(context),
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 41, 88, 162)),
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
                              controller: provinceController,
                              enableIconPrefix: true,
                              preIcon: CupertinoIcons.location_circle_fill,
                              title: 'กรุงเทพ',
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'รหัสไปรษณีย์',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: PlatformSize(context),
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 41, 88, 162)),
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
                              controller: zipcodeController,
                              textInputType: TextInputType.number,
                              enableIconPrefix: true,
                              preIcon: CupertinoIcons.envelope_circle,
                              title: '10210',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'หมายเหตุ (ถ้ามี)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: PlatformSize(context),
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 41, 88, 162)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: '',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color:
                                            Colors.grey[500]!.withOpacity(.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: PlatformSize(context)),
                                fillColor: Colors.white,
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.all(2),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.7,
                                      color: Colors.grey), //<-- SEE HERE
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue.shade200),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                errorStyle: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                              ),
                              minLines: 5,
                              maxLines: 8,
                              controller: remarkController,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black54, blurRadius: 1)
                                    ],
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Column(
                                  children: [
                                    ExpansionTile(
                                      title: Text(
                                        'เก็บเงินปลายทาง (ถ้ามี)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                                fontSize:
                                                    PlatformSize(context)),
                                      ),
                                      trailing: SizedBox(),
                                      onExpansionChanged: _onExpansionChanged,
                                      leading: IgnorePointer(
                                        child: Checkbox(
                                            value: isExpanded,
                                            onChanged: (_) {
                                              setState(() {
                                                isExpanded = !isExpanded;
                                              });
                                            }),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: GetTextField(
                                            validator: (value) {
                                              if (isExpanded == true) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'กรุณากรอกข้อมูล';
                                                } else {
                                                  return null;
                                                }
                                              }

                                              return null;
                                            },
                                            controller: codController,
                                            enableIconPrefix: true,
                                            preIcon: CupertinoIcons
                                                .money_dollar_circle,
                                            title: 'จำนวนเงิน',
                                          ),
                                        )
                                      ],
                                    ),
                                    ExpansionTile(
                                      title: Text(
                                        'ซื้อประกันสินค้า',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                                fontSize:
                                                    PlatformSize(context)),
                                      ),
                                      trailing: SizedBox(),
                                      onExpansionChanged:
                                          _onExpansionInsuChanged,
                                      leading: IgnorePointer(
                                        child: Checkbox(
                                            value: isExpandedInsu,
                                            onChanged: (_) {
                                              setState(() {
                                                isExpandedInsu =
                                                    !isExpandedInsu;
                                              });
                                            }),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: GetTextField(
                                            validator: (value) {
                                              if (isExpandedInsu == true) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'กรุณากรอกข้อมูล';
                                                } else {
                                                  return null;
                                                }
                                              }

                                              return null;
                                            },
                                            controller: insuController,
                                            enableIconPrefix: true,
                                            preIcon: CupertinoIcons.bookmark,
                                            title:
                                                'มูลค่าสินค้า(2,000 ถึง 5,000)',
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1, bottom: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black54, blurRadius: 1)
                                    ],
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: ExpansionTile(
                                  title: Text(
                                    'บันทึกที่อยู่ผู้รับ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: PlatformSize(context)),
                                  ),
                                  trailing: SizedBox(),
                                  onExpansionChanged:
                                      _onExpansionSaveAddressChanged,
                                  leading: IgnorePointer(
                                    child: Checkbox(
                                        value: isExpandedSaveaddress,
                                        onChanged: (_) {
                                          setState(() {
                                            isExpandedSaveaddress =
                                                !isExpandedSaveaddress;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            BlocBuilder<OrderBloc, OrderState>(
                              builder: (context, state) {
                                if (state is OrderLoading) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: CupertinoButton(
                                        color: Color.fromARGB(255, 41, 88, 162),
                                        onPressed: () {},
                                        child: CustomProgessIndicator(
                                            Colors.white, 20)),
                                  );
                                } else if (state is OrderInitial) {
                                  // print(
                                  //     'state bank = ${state.userdatamodel.accountName}');
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: CupertinoButton(
                                      color: Color.fromARGB(255, 41, 88, 162),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (labelname == '' ||
                                              labelphone == '' ||
                                              labeladdress == '' ||
                                              labelzipcode == '') {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'กรุณาตรวจสอบที่อยู่ผู้ส่ง');
                                          } else {
                                            context
                                                .read<UserDataBloc>()
                                                .add(UserdataAfterSendEvent());
                                            context.read<OrderBloc>().add(
                                                AddOrderEvent(
                                                    context: context,
                                                    courier_code:
                                                        _courier!.code!,
                                                    current_order: '',
                                                    src_name: srcname,
                                                    src_phone: srcphone,
                                                    src_district:
                                                        srcsubdistrict,
                                                    src_amphure: srcdistrict,
                                                    src_address: srcaddress,
                                                    src_province: srcprovince,
                                                    src_zipcode: srczipcode,
                                                    label_name: labelname,
                                                    label_phone: labelphone,
                                                    label_address: labeladdress,
                                                    label_zipcode: labelzipcode,
                                                    dst_name:
                                                        dstnameController.text,
                                                    dst_phone:
                                                        phoneController.text,
                                                    dst_address:
                                                        houseNoController.text,
                                                    dst_district:
                                                        subdistrictController
                                                            .text,
                                                    dst_amphure:
                                                        districtController.text,
                                                    dst_province:
                                                        provinceController.text,
                                                    dst_zipcode:
                                                        zipcodeController.text,
                                                    account_name: accountname,
                                                    account_number:
                                                        accountnumber,
                                                    account_branch: branchno,
                                                    account_bank: bankid,
                                                    is_insure: insu.toString(),
                                                    product_value:
                                                        insuController.text,
                                                    cod_amount:
                                                        codController.text,
                                                    remark:
                                                        remarkController.text,
                                                    issave: saveaddress
                                                        .toString()));
                                          }
                                        }
                                      },
                                      child: Text('บันทึกรายการ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize:
                                                      PlatformSize(context),
                                                  fontWeight: FontWeight.bold)),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
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
