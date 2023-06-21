import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import 'package:perfectship_app/bloc/new_bloc/create_order/create_order_bloc.dart';
import 'package:perfectship_app/bloc/new_bloc/orderlist_new/orderlist_new_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/model/new_model/category_new_model.dart';
import 'package:perfectship_app/repository/new_repository/address_repository.dart';

import 'package:perfectship_app/model/new_model/courier_new_model.dart';
import 'package:perfectship_app/repository/new_repository/order_reposittory.dart';
import 'package:perfectship_app/screen/createorder/new_widget/custom_expansion.dart';
import 'package:perfectship_app/screen/createorder/new_widget/search_address_delegate.dart';
import 'package:perfectship_app/screen/createorder/new_widget/search_dst_delegate.dart';

import 'package:perfectship_app/widget/gettextfield.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/new_model/address_search_new_model.dart';
import '../../../model/new_model/static_model/search_phone.dart';
import '../../../widget/fontsize.dart';

class CreateOrderNew extends StatefulWidget {
  const CreateOrderNew({Key? key}) : super(key: key);

  @override
  State<CreateOrderNew> createState() => _CreateOrderNewState();
}

class _CreateOrderNewState extends State<CreateOrderNew> {
  final fromKey = GlobalKey<FormState>();
  final dialogform = GlobalKey<FormState>();
  final Color primaryColor = Color.fromARGB(235, 53, 136, 195);
  FocusNode searchFocusNode = FocusNode();
  FocusNode searchSrcFocusNode = FocusNode();
  TextEditingController addressController = TextEditingController();
  TextEditingController subdistrictController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController weigthController = TextEditingController(text: '1');
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController codController = TextEditingController();
  TextEditingController insureController = TextEditingController();
  TextEditingController dstnameController = TextEditingController();
  TextEditingController dstphoneController = TextEditingController();
  bool isCod = false;
  bool isInsure = false;
  bool isSave = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: <Color>[
        //     Color.fromARGB(200, 43, 166, 223).withAlpha(223),
        //     Color.fromARGB(180, 41, 88, 162).withAlpha(162),
        //   ],
        // ),
        color: Color.fromARGB(200, 43, 166, 223).withAlpha(255),
      ),
      child: SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      floating: true,
                      pinned: true,
                      snap: true,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                      title: Text(
                        'สร้างรายการพัสดุ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color.fromARGB(200, 43, 166, 223).withAlpha(255),
                              Color.fromARGB(180, 41, 88, 162).withAlpha(162),
                            ],
                          ),
                          //color: Color.fromARGB(200, 43, 166, 223),
                        ),
                      ),
                      elevation: 0,
                      centerTitle: true,
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                    ),
                  ];
                },
                body: Form(
                  key: fromKey,
                  child: CustomScrollView(
                    slivers: [
                      BlocBuilder<CreateOrderBloc, CreateOrderState>(
                        builder: (context, state) {
                          if (state is CreateOrderData) {
                            return SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                      ],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.person_alt_circle,
                                              color: primaryColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'ข้อมูลของผู้ส่ง (${state.customerId})',
                                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),
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
                                                'ชื่อผู้ส่ง : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                controller: state.srcnameController,
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
                                                preIcon: CupertinoIcons.person_alt_circle_fill,
                                                enableIconPrefix: true,
                                                title: 'คุณ เพอร์เฟคชิพ',
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
                                                'เบอร์โทร : ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: GetTextField(
                                                controller: state.srcphoneController,
                                                textInputType: TextInputType.phone,
                                                maxLength: 10,
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
                                                preIcon: CupertinoIcons.phone,
                                                enableIconPrefix: true,
                                                title: '088888888',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('ค้นหาที่อยู่ผู้ส่ง', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                        GetTextField(
                                          //controller: s,
                                          focusNode: searchSrcFocusNode,
                                          onTap: () async {
                                            AddressSearchNewModel address = await showSearch(context: context, delegate: SearcgAddressNewDelegate());
                                            context.read<CreateOrderBloc>().add(OnSrcAddressChangeEvent(
                                                subDistrict: address.district!,
                                                district: address.amphure!,
                                                province: address.province!,
                                                zipcode: address.zipcode!));
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
                                                controller: state.srcaddressController,
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
                                                preIcon: CupertinoIcons.envelope,
                                                enableIconPrefix: true,
                                                title: 'บ้านเลขที่1/2 ซอย3 หมู่4',
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
                                                controller: state.srcsubDistrictController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
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
                                                controller: state.srcdistrictController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
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
                                                controller: state.srcprovinceController,
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
                                                controller: state.srczipcodeController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'กรุณากรอกข้อมูล';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                textInputType: TextInputType.none,
                                                preIcon: CupertinoIcons.envelope_open,
                                                enableIconPrefix: true,
                                                title: 'รหัสไปรษณีย์',
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Expanded(
                                        //       child: Row(
                                        //         children: [
                                        //           Text('ชื่อ : ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                        //           Text('${state.labelName}',
                                        //               style: TextStyle(
                                        //                 color: Colors.black87,
                                        //               )),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //     Expanded(
                                        //       child: Row(
                                        //         children: [
                                        //           Text('เบอร์โทร : ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                        //           Text('${state.labelPhone}',
                                        //               style: TextStyle(
                                        //                 color: Colors.black87,
                                        //               )),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text('ที่อยู่ : ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                        //     Expanded(
                                        //       child: Text(
                                        //           '${state.labelAddress} ${state.labelSubDistrict} ${state.labelDistrict} ${state.labelProvince} ${state.labelZipcode}',
                                        //           style: TextStyle(
                                        //             color: Colors.black87,
                                        //           )),
                                        //     ),
                                        //   ],
                                        // ),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Expanded(
                                        //       child: Row(
                                        //         children: [
                                        //           Text('ขนส่งเริ่มต้น : ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                        //           Container(
                                        //             width: 150,
                                        //             child: Image.network(
                                        //               state.courierImg,
                                        //               errorBuilder: (context, error, stackTrace) {
                                        //                 return Text('ไม่มีขนส่งเริ่มต้น',
                                        //                     style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
                                        //               },
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        // Container(
                                        //   decoration: BoxDecoration(
                                        //       color: Colors.white,
                                        //       boxShadow: [
                                        //         BoxShadow(color: Colors.blue, blurRadius: 1, offset: Offset(0.5, 1)),
                                        //       ],
                                        //       borderRadius: BorderRadius.circular(16)),
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                        //     child: Row(
                                        //       mainAxisSize: MainAxisSize.min,
                                        //       children: [
                                        //         Icon(
                                        //           Icons.edit,
                                        //           size: 18,
                                        //         ),
                                        //         SizedBox(
                                        //           width: 5,
                                        //         ),
                                        //         Text('แก้ไขข้อมูลผู้ส่ง',
                                        //             style: TextStyle(
                                        //               color: Colors.black87,
                                        //             )),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SliverToBoxAdapter(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.grey[300]!,
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                  height: 150,
                                  child: Row(),
                                ),
                              ),
                            ));
                          }
                        },
                      ),
                      BlocBuilder<CreateOrderBloc, CreateOrderState>(
                        builder: (context, state) {
                          if (state is CreateOrderData) {
                            return SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                      ],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.local_shipping_outlined,
                                            color: primaryColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'เลือกขนส่ง',
                                            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          // boxShadow: [
                                          //   BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                          // ],
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField2<CourierNewModel>(
                                            validator: (v) {
                                              if (v == null) {
                                                return 'กรุณาเลือกขนส่ง';
                                              } else {
                                                return null;
                                              }
                                            },
                                            hint: Text(
                                              '    --กรุณาเลือกขนส่ง--',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38, fontSize: 15),
                                              textAlign: TextAlign.center,
                                            ),
                                            buttonHeight: 55,
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(14),
                                              boxShadow: [
                                                BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                              ],
                                            ),
                                            buttonDecoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(14),
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
                                            items: state.courierNewModels.map<DropdownMenuItem<CourierNewModel>>((e) {
                                              return DropdownMenuItem(
                                                  value: e,
                                                  child: Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                                      child: Row(
                                                        children: [
                                                          Image.network(
                                                            e.logo ?? '',
                                                            height: 50,
                                                            errorBuilder: (context, error, stackTrace) {
                                                              return Icon(
                                                                FontAwesomeIcons.truckFast,
                                                                size: 15,
                                                              );
                                                            },
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            e.name ?? '',
                                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
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
                                              context.read<CreateOrderBloc>().add(SelectCourierEvent(courier: value));
                                              print(state.customerId);
                                            },
                                            value: null,
                                            buttonPadding: EdgeInsets.all(0),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SliverToBoxAdapter(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.grey[300]!,
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                  height: 135,
                                  child: Row(),
                                ),
                              ),
                            ));
                          }
                        },
                      ),
                      BlocBuilder<CreateOrderBloc, CreateOrderState>(
                        builder: (context, state) {
                          if (state is CreateOrderData) {
                            return SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                          ],
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                CupertinoIcons.paperplane,
                                                                color: primaryColor,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                'ข้อมูลของผู้รับ',
                                                                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text('ค้นหาที่อยู่ผู้รับ',
                                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showMultilineTextFieldDialog(context);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(8)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons.layers_alt,
                                                              color: Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              'คัดแยก',
                                                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      SearchPhoneModel search = await showSearch(context: context, delegate: SearchDstNewDelegate());
                                                      districtController.text = search.district;
                                                      subdistrictController.text = search.subDistrict;
                                                      provinceController.text = search.province;
                                                      zipcodeController.text = search.zipcode;
                                                      dstnameController.text = search.name;
                                                      dstphoneController.text = search.phone;
                                                      addressController.text = search.address;
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons.search,
                                                              color: Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              'ค้นหา',
                                                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            GetTextField(
                                              focusNode: searchFocusNode,
                                              onTap: () async {
                                                searchFocusNode.unfocus();
                                                AddressSearchNewModel address =
                                                    await showSearch(context: context, delegate: SearcgAddressNewDelegate());
                                                context.read<CreateOrderBloc>().add(SelectAddressManulEvent(addressSearchNewModel: address));
                                                districtController.text = address.amphure!;
                                                subdistrictController.text = address.district!;
                                                provinceController.text = address.province!;
                                                zipcodeController.text = address.zipcode!;
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
                                                    'ชื่อผู้รับ : ',
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
                                                    onChanged: (v) {
                                                      //context.read<CreateOrderBloc>().add(OnAddressChangeEvent(address: v));
                                                    },
                                                    controller: dstnameController,
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
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'เบอร์โทร : ',
                                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: GetTextField(
                                                    textInputType: TextInputType.phone,
                                                    validator: (v) {
                                                      if (v == null || v.isEmpty) {
                                                        return 'กรุณากรอกข้อมูล';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    maxLength: 10,
                                                    onChanged: (v) {
                                                      //context.read<CreateOrderBloc>().add(OnAddressChangeEvent(address: v));
                                                    },
                                                    controller: dstphoneController,
                                                    preIcon: CupertinoIcons.phone,
                                                    enableIconPrefix: true,
                                                    title: '0999999999',
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
                                                    'บ้านเลขที่ : ',
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
                                                    onChanged: (v) {
                                                      context.read<CreateOrderBloc>().add(OnAddressChangeEvent(address: v));
                                                    },
                                                    controller: addressController,
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
                                                    validator: (v) {
                                                      if (v == null || v.isEmpty) {
                                                        return 'กรุณากรอกข้อมูล';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    controller: subdistrictController,
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
                                                    validator: (v) {
                                                      if (v == null || v.isEmpty) {
                                                        return 'กรุณากรอกข้อมูล';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    controller: districtController,
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
                                                    validator: (v) {
                                                      if (v == null || v.isEmpty) {
                                                        return 'กรุณากรอกข้อมูล';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    controller: provinceController,
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
                                                    validator: (v) {
                                                      if (v == null || v.isEmpty) {
                                                        return 'กรุณากรอกข้อมูล';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    controller: zipcodeController,
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
                                ],
                              ),
                            );
                          } else {
                            return SliverToBoxAdapter(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.grey[300]!,
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                  height: 470,
                                  child: Row(),
                                ),
                              ),
                            ));
                          }
                        },
                      ),
                      BlocBuilder<CreateOrderBloc, CreateOrderState>(
                        builder: (context, state) {
                          if (state is CreateOrderData) {
                            return SliverToBoxAdapter(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                    ],
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.cube_box,
                                                color: primaryColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'น้ำหนักและปริมาตร',
                                                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),
                                              ),
                                            ],
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
                                              child: Text('ประเภทพัสดุ ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6.5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton2<CategoryNewModel>(
                                                  buttonHeight: 40,
                                                  dropdownDecoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14),
                                                    boxShadow: [
                                                      BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                                    ],
                                                  ),
                                                  buttonDecoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.white),
                                                  dropdownElevation: 8,
                                                  scrollbarRadius: const Radius.circular(40),
                                                  dropdownMaxHeight: 400,
                                                  scrollbarThickness: 6,
                                                  scrollbarAlwaysShow: true,
                                                  offset: const Offset(0, -20),
                                                  selectedItemHighlightColor: Colors.blue.shade50.withOpacity(.4),
                                                  items: state.categories.map<DropdownMenuItem<CategoryNewModel>>((e) {
                                                    return DropdownMenuItem(
                                                        value: e,
                                                        child: Container(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                e.name ?? '',
                                                                style: TextStyle(fontSize: 15),
                                                              )
                                                            ],
                                                          ),
                                                        ));
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    context.read<CreateOrderBloc>().add(SelectCategoryEvent(category: value!));
                                                  },
                                                  value: state.category ?? null,
                                                  underline: SizedBox(),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'น้ำหนัก : ',
                                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: GetTextField(
                                              validator: (v) {
                                                if (v == null || v.isEmpty) {
                                                  return 'กรุณากรอกข้อมูล';
                                                }
                                                if (double.tryParse(v) == null) {
                                                  return 'กรุณากรอกเฉพาะตัวเลข';
                                                }
                                                if (double.parse(v) < 1) {
                                                  return 'ต้องมีน้ำหนักอย่างน้อย 1';
                                                }
                                                return null;
                                              },
                                              controller: weigthController,
                                              textInputType: TextInputType.numberWithOptions(decimal: true),
                                              preIcon: Icons.scale_outlined,
                                              enableIconPrefix: true,
                                              title: 'น้ำหนัก',
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
                                              'กว้าง : ',
                                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: GetTextField(
                                              controller: widthController,
                                              textInputType: TextInputType.numberWithOptions(decimal: true),
                                              preIcon: Icons.width_wide,
                                              enableIconPrefix: true,
                                              title: 'ความกว้าง',
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
                                              'ยาว : ',
                                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: GetTextField(
                                              controller: lengthController,
                                              textInputType: TextInputType.numberWithOptions(decimal: true),
                                              preIcon: CupertinoIcons.cube,
                                              enableIconPrefix: true,
                                              title: 'ความยาว',
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
                                              'สูง : ',
                                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: GetTextField(
                                              controller: heigthController,
                                              textInputType: TextInputType.numberWithOptions(decimal: true),
                                              preIcon: Icons.height,
                                              enableIconPrefix: true,
                                              title: 'ความสูง',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                          } else {
                            return SliverToBoxAdapter(
                              child: Text(
                                '...',
                                style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.w500),
                              ),
                            );
                          }
                        },
                      ),
                      BlocBuilder<CreateOrderBloc, CreateOrderState>(builder: (context, state) {
                        if (state is CreateOrderData) {
                          return SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                        ],
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons.bookmark,
                                                    color: primaryColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'อื่นๆ..',
                                                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '  หมายเหตุ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                              Container(
                                                //height: 100,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).scaffoldBackgroundColor,
                                                  // borderRadius: BorderRadius.circular(6),
                                                  // border: Border.all(color: _nodeText13.hasFocus ? Colors.blue.shade400 : Colors.grey.shade400),
                                                ),
                                                child: TextFormField(
                                                  minLines: 5,
                                                  maxLines: 5,
                                                  keyboardType: TextInputType.multiline,
                                                  controller: remarkController,
                                                  //controller: state.remarkController,
                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: PlatformSize(context)),
                                                  decoration: new InputDecoration(
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(4)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(width: 0.7, color: Colors.grey), //<-- SEE HERE
                                                        borderRadius: BorderRadius.circular(10)),
                                                    contentPadding: const EdgeInsets.all(5),
                                                    hintText: '  หมายเหตุ',
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(fontSize: PlatformSize(context), color: Colors.grey),
                                                    border: InputBorder.none,
                                                  ),
                                                  onChanged: (v) {
                                                    //context.read<CreateOrderBloc>().add(OrderRemarkChangeEvent(v));
                                                  },
                                                ),
                                              ),
                                              CustomExpansionTile(
                                                childrenPadding: EdgeInsets.all(0),
                                                tilePadding: EdgeInsets.all(0),
                                                initiallyExpanded: false,
                                                trailing: SizedBox(),
                                                isExpan: true,
                                                onExpansionChanged: (value) {
                                                  setState(() {
                                                    if (value == false) {
                                                      codController.text = '0.00';
                                                    }
                                                    isCod = value;
                                                  });
                                                },
                                                leading: MediaQuery.removePadding(
                                                  context: context,
                                                  removeRight: true,
                                                  child: IgnorePointer(
                                                    child: Checkbox(
                                                        value: isCod,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            isCod = value!;
                                                          });
                                                        }),
                                                  ),
                                                ),
                                                title: MediaQuery.removePadding(
                                                  context: context,
                                                  removeLeft: true,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'เก็บเงินปลายทาง (ถ้ามี)',
                                                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                children: [
                                                  GetTextField(
                                                    validator: (v) {
                                                      if (isCod == true) {
                                                        if (v == null || v.isEmpty) {
                                                          return 'กรุณากรอกข้อมูล';
                                                        } else {
                                                          return null;
                                                        }
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    controller: codController,
                                                    textInputType: TextInputType.number,
                                                    preIcon: Icons.local_shipping_rounded,
                                                    enableIconPrefix: true,
                                                    title: 'เก็บเงินปลายทาง (COD)',
                                                  ),
                                                ],
                                              ),
                                              CustomExpansionTile(
                                                childrenPadding: EdgeInsets.all(0),
                                                tilePadding: EdgeInsets.all(0),
                                                initiallyExpanded: false,
                                                trailing: SizedBox(),
                                                isExpan: true,
                                                onExpansionChanged: (value) {
                                                  setState(() {
                                                    if (value == false) {
                                                      insureController.text = '0.00';
                                                    }
                                                    isInsure = value;
                                                  });
                                                },
                                                leading: MediaQuery.removePadding(
                                                  context: context,
                                                  removeRight: true,
                                                  child: IgnorePointer(
                                                    child: Checkbox(
                                                        value: isInsure,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            isInsure = value!;
                                                          });
                                                        }),
                                                  ),
                                                ),
                                                title: MediaQuery.removePadding(
                                                  context: context,
                                                  removeLeft: true,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'ซื้อประกัน',
                                                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                children: [
                                                  GetTextField(
                                                    validator: (v) {
                                                      if (isInsure == true) {
                                                        if (v == null || v.isEmpty) {
                                                          return 'กรุณากรอกข้อมูล';
                                                        } else {
                                                          return null;
                                                        }
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    controller: insureController,
                                                    textInputType: TextInputType.number,
                                                    preIcon: Icons.list_alt_rounded,
                                                    enableIconPrefix: true,
                                                    title: 'ประกัน',
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isSave = !isSave;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Checkbox(
                                                        value: isSave,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            isSave = value!;
                                                          });
                                                        }),
                                                    Text(
                                                      '    บันทึกที่อยู่ผู้รับ',
                                                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SliverToBoxAdapter(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.grey[300]!,
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                height: 250,
                                child: Row(),
                              ),
                            ),
                          ));
                        }
                      }),
                      BlocBuilder<CreateOrderBloc, CreateOrderState>(
                        builder: (context, state) {
                          if (state is CreateOrderData) {
                            return SliverToBoxAdapter(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                      child: InkWell(
                                        splashColor: Colors.blue.shade300,
                                        onTap: () {
                                          if (fromKey.currentState!.validate()) {
                                            loadingDialog(context);
                                            print('on create id = ${state.customerId}');
                                            OrderRepository()
                                                .createOrder(
                                                    courierCode: state.courierNewModel.code,
                                                    type: 2,
                                                    labelName: state.srcnameController.text,
                                                    labelPhone: state.srcphoneController.text,
                                                    labelAddress: state.srcaddressController.text,
                                                    labelSubDistrict: state.srcsubDistrictController.text,
                                                    labelDistrict: state.srcdistrictController.text,
                                                    labelProvince: state.srcprovinceController.text,
                                                    labelZipcode: state.srczipcodeController.text,
                                                    accountName: state.accountName,
                                                    accountNumber: state.accountNumber,
                                                    accountBranch: state.accountBranch,
                                                    accountBank: state.accountBank,
                                                    dstName: dstnameController.text,
                                                    dstPhone: dstphoneController.text,
                                                    dstAddress: addressController.text,
                                                    dstSubDistrict: subdistrictController.text,
                                                    dstDistrict: districtController.text,
                                                    dstProvince: provinceController.text,
                                                    dstZipcode: zipcodeController.text,
                                                    weight: double.parse(weigthController.text.isEmpty ? '0' : weigthController.text),
                                                    width: double.parse(widthController.text.isEmpty ? '0' : widthController.text),
                                                    length: double.parse(lengthController.text.isEmpty ? '0' : lengthController.text),
                                                    height: double.parse(heigthController.text.isEmpty ? '0' : heigthController.text),
                                                    codAmount: double.parse(codController.text.isEmpty ? '0' : codController.text),
                                                    remark: remarkController.text,
                                                    isInsured: isInsure == true ? 1 : 0,
                                                    productValue: isInsure == false
                                                        ? 0.0
                                                        : double.parse(insureController.text.isEmpty ? '0' : insureController.text),
                                                    customerId: state.customerId,
                                                    isBulky: state.isBulky,
                                                    jntPickup: 6,
                                                    kerryPickup: 0,
                                                    categoryId: state.category.id!,
                                                    saveDstAddress: isSave ? 1 : 0)
                                                .then((value) {
                                              if (value['status'] == true) {
                                                context.read<OrderlistNewBloc>().add(OrderlistNewInitialEvent());
                                                Navigator.pop(context);
                                                correctDialog(context, value['message']);
                                              } else {
                                                Navigator.pop(context);
                                                responseDialog(context, value['message']);
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 0.5,
                                                blurRadius: 1,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'สร้างรายการ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )));
                          } else {
                            return SliverToBoxAdapter(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.grey[300]!,
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                  height: 40,
                                  child: Row(),
                                ),
                              ),
                            ));
                          }
                        },
                      )
                    ],
                  ),
                ),
              )),
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
            textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            iconColor: Colors.white,
          ),
        ]);
  }

  void loadingDialog(BuildContext context) {
    Dialogs.materialDialog(
      barrierDismissible: false,
      color: Colors.white,
      title: 'กำลังสร้างรายการ กรุณารอสักครู่..',
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
        title: 'สร้างรายการสำเร็จ!!',
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
            },
            text: 'ปิด',
            iconData: Icons.close,
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            iconColor: Colors.white,
          ),
        ]);
  }

  void showMultilineTextFieldDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    bool isload = false;
    showDialog(
      context: context,
      barrierDismissible: !isload,
      builder: (BuildContext context) {
        return Form(
            key: dialogform,
            child: StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  actionsPadding: EdgeInsets.all(0),
                  contentPadding: EdgeInsets.all(8),
                  titlePadding: EdgeInsets.all(0),
                  title: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                      color: Colors.amber,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.layers_alt,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'คัดแยก',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  content: Container(
                    color: Colors.white,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                      controller: controller,
                      style: TextStyle(fontSize: 14),
                      minLines: 8,
                      maxLines: null, // Allow unlimited number of lines
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                        hintText: 'นายทดสอบ ระบบ\n91/83 สายไหม สายไหม 10220\n0987654321\n**N19-2 กล่องสุ่ม999(1กล่อง)\nCOD100',
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    isload == true
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(width: 12, height: 12, child: CircularProgressIndicator()),
                          )
                        : TextButton(
                            child: Text('คัดแยก   '),
                            onPressed: () async {
                              if (dialogform.currentState!.validate()) {
                                setState(() {
                                  isload = true;
                                });
                                await AddressNewRepository().getNormalize(controller.text).then((value) {
                                  if (value.status == true) {
                                    setState(() {
                                      dstnameController.text = value.name!;
                                      addressController.text = value.cutAll!;
                                      districtController.text = value.amphure!;
                                      subdistrictController.text = value.district!;
                                      provinceController.text = value.province!;
                                      zipcodeController.text = value.zipcode!;
                                      isload = false;
                                      Navigator.of(context).pop();
                                    });
                                  } else {
                                    setState(() {
                                      isload = false;
                                    });
                                    responseDialog(context, 'ไม่สามารถคัดแยกได้');
                                  }
                                });
                              }

                              // Perform actions with the entered text
                            },
                          ),
                  ],
                );
              },
            ));
      },
    );
  }
}
