import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import 'package:perfectship_app/bloc/new_bloc/create_order/create_order_bloc.dart';
import 'package:perfectship_app/bloc/new_bloc/orderlist_new/orderlist_new_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/model/new_model/category_new_model.dart';
import 'package:perfectship_app/model/new_model/product_create_model.dart';
import 'package:perfectship_app/repository/new_repository/address_repository.dart';

import 'package:perfectship_app/model/new_model/courier_new_model.dart';
import 'package:perfectship_app/repository/new_repository/order_reposittory.dart';
import 'package:perfectship_app/screen/createorder/new_widget/custom_expansion.dart';
import 'package:perfectship_app/screen/createorder/new_widget/search_address_delegate.dart';
import 'package:perfectship_app/screen/createorder/new_widget/search_dst_delegate.dart';
import 'package:perfectship_app/screen/createorder/new_widget/select_courier.dart';
import 'package:perfectship_app/screen/new_screen/edit_profile.dart';
import 'package:perfectship_app/widget/custom_dialog.dart';
import 'package:perfectship_app/widget/gettexfield_multiline.dart';

import 'package:perfectship_app/widget/gettextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/new_model/address_search_new_model.dart';
import '../../../model/new_model/static_model/search_phone.dart';
import '../../../widget/fontsize.dart';
import '../../../widget/fontsizemenu.dart';

class CreateOrderNew extends StatefulWidget {
  const CreateOrderNew({Key? key}) : super(key: key);

  @override
  State<CreateOrderNew> createState() => _CreateOrderNewState();
}

class _CreateOrderNewState extends State<CreateOrderNew> {
  final fromKey = GlobalKey<FormState>();
  final dialogform = GlobalKey<FormState>();
  final expkey = GlobalKey<FormState>();
  final Color primaryColor = Color.fromARGB(235, 53, 136, 195);
  FocusNode searchFocusNode = FocusNode();
  FocusNode searchSrcFocusNode = FocusNode();
  FocusNode extNode = FocusNode();

  bool isCod = false;
  bool isInsure = false;
  bool isSave = true;
  bool isExtract = false;
  bool loadingExt = false;
  TextEditingController _extractController = TextEditingController();

  SharedPreferences? sharePrefs;

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
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
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
            body: Form(
              key: fromKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<CreateOrderBloc, CreateOrderState>(
                      builder: (context, state) {
                        if (state is CreateOrderData) {
                          return Padding(
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              style: TextStyle(
                                                  color: Colors.blue.shade800,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<UserDataBloc>().add(UserDataInitialEvent());
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) => EditProfile(),
                                                ));
                                          },
                                          child: Icon(
                                            Icons.edit_square,
                                            color: Colors.amber.shade800,
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'ชื่อ : ',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                        Text(
                                          '${state.srcnameController.text}',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'เบอร์โทร : ',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                        Text(
                                          '${state.srcphoneController.text}',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ที่อยู่ : ',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${state.srcaddressController.text} ${state.srcsubDistrictController.text} ${state.srcdistrictController.text} ${state.srcprovinceController.text} ${state.srczipcodeController.text}',
                                            style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
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
                          );
                        }
                      },
                    ),
                    BlocBuilder<CreateOrderBloc, CreateOrderState>(
                      builder: (context, state) {
                        if (state is CreateOrderData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: GestureDetector(
                              onTap: () async {
                                print('tap');
                                CourierNewModel? cour = await Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => SelectCourierScreen(),
                                    ));

                                if (cour != null) {
                                  context.read<CreateOrderBloc>().add(SelectCourierEvent(courier: cour));
                                }
                              },
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6),
                                        child: Row(
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
                                              style: TextStyle(
                                                  color: Colors.blue.shade800,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              ' **',
                                              style: TextStyle(
                                                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          // boxShadow: [
                                          //   BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                          // ],
                                        ),
                                        child: Container(
                                          height: 60,
                                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                                          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            boxShadow: [
                                              // BoxShadow(
                                              //   color: Colors.grey[100]!,
                                              //   blurRadius: 5.0,
                                              //   spreadRadius: 0.0,
                                              //   offset: const Offset(2, 6), // shadow direction: bottom right
                                              // )
                                            ],
                                            // border: Border.all(color: Colors.grey.shade50)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: state.courierNewModel.logo ?? '',
                                                errorWidget: (context, url, error) {
                                                  return Icon(
                                                    CupertinoIcons.cube_box_fill,
                                                    color: Colors.amber.shade700,
                                                    size: 20,
                                                  );
                                                },
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  state.courierNewModel.name == null
                                                      ? 'กรุณาเลือกขนส่ง'
                                                      : '${state.courierNewModel.name}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall!
                                                      .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              //CustomTextAutoSizeforMenu(text: 'แก้ไขรหัสผ่าน', bold: true, enable: true),
                                              const Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color.fromARGB(255, 41, 88, 162),
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                        // DropdownButtonHideUnderline(
                                        //   child: DropdownButtonFormField2<CourierNewModel>(
                                        //     validator: (v) {
                                        //       if (v == null) {
                                        //         return 'กรุณาเลือกขนส่ง';
                                        //       } else {
                                        //         return null;
                                        //       }
                                        //     },
                                        //     hint: Text(
                                        //       '    --กรุณาเลือกขนส่ง--',
                                        //       style:
                                        //           Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black45, fontWeight: FontWeight.bold),
                                        //       textAlign: TextAlign.center,
                                        //     ),
                                        //     buttonHeight: 55,
                                        //     dropdownDecoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.circular(14),
                                        //       boxShadow: [
                                        //         BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                        //       ],
                                        //     ),
                                        //     buttonDecoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.circular(14),
                                        //       color: Colors.white,
                                        //       border: Border.all(color: Colors.black54),
                                        //     ),
                                        //     dropdownElevation: 8,
                                        //     scrollbarRadius: const Radius.circular(40),
                                        //     dropdownMaxHeight: 400,
                                        //     scrollbarThickness: 6,
                                        //     scrollbarAlwaysShow: true,
                                        //     offset: const Offset(0, -20),
                                        //     selectedItemHighlightColor: Colors.blue.shade50.withOpacity(.4),
                                        //     items: state.courierNewModels.map<DropdownMenuItem<CourierNewModel>>((e) {
                                        //       return DropdownMenuItem(
                                        //           value: e,
                                        //           child: Container(
                                        //             child: Padding(
                                        //               padding: const EdgeInsets.symmetric(horizontal: 8),
                                        //               child: Row(
                                        //                 children: [
                                        //                   Image.network(
                                        //                     e.logo ?? '',
                                        //                     height: 50,
                                        //                     errorBuilder: (context, error, stackTrace) {
                                        //                       return Icon(
                                        //                         FontAwesomeIcons.truckFast,
                                        //                         size: 15,
                                        //                       );
                                        //                     },
                                        //                   ),
                                        //                   SizedBox(
                                        //                     width: 10,
                                        //                   ),
                                        //                   Text(
                                        //                     e.name ?? '',
                                        //                     style: Theme.of(context)
                                        //                         .textTheme
                                        //                         .headlineSmall!
                                        //                         .copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
                                        //                   )
                                        //                 ],
                                        //               ),
                                        //             ),
                                        //           ));
                                        //     }).toList(),
                                        //     onChanged: (value) {
                                        //       //ontext.read<CreateOrderBloc>().add(OrderSelectFuze(value: value!));
                                        //       //  _onDropDownItemSelected(value!);
                                        //       print(value!.name);
                                        //       context.read<CreateOrderBloc>().add(SelectCourierEvent(courier: value));
                                        //       print(state.customerId);
                                        //     },
                                        //     value: null,
                                        //     buttonPadding: EdgeInsets.all(0),
                                        //   ),
                                        // ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
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
                          );
                        }
                      },
                    ),
                    BlocBuilder<CreateOrderBloc, CreateOrderState>(
                      builder: (context, state) {
                        if (state is CreateOrderData) {
                          return Column(
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
                                                            style: TextStyle(
                                                                color: Colors.blue.shade800,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: GestureDetector(
                                                onTap: () {
                                                  //showMultilineTextFieldDialog(context);
                                                  setState(() {
                                                    isExtract = !isExtract;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: isExtract ? Colors.amber : Colors.white,
                                                      borderRadius: BorderRadius.circular(8),
                                                      border: isExtract
                                                          ? null
                                                          : Border.all(color: Colors.amber, width: 0.5)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons.layers_alt,
                                                          color: isExtract ? Colors.white : Colors.amber,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          'คัดแยก',
                                                          style: TextStyle(
                                                              color: isExtract ? Colors.white : Colors.amber,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold),
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
                                                  SearchPhoneModel search = await showSearch(
                                                      context: context, delegate: SearchDstNewDelegate());
                                                  context.read<CreateOrderBloc>().add(OnRecieveSearchEvent(
                                                      district: search.district,
                                                      subdistrict: search.subDistrict,
                                                      province: search.province,
                                                      zipcode: search.zipcode,
                                                      name: search.name,
                                                      phone: search.phone,
                                                      address: search.address));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue, borderRadius: BorderRadius.circular(8)),
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
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold),
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
                                        Divider(),
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          height: isExtract ? 210 : 0,
                                          child: SingleChildScrollView(
                                            child: Form(
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              key: expkey,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  GetTextFieldMultiLine(
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'กรุณากรอกข้อมูล';
                                                      }
                                                      return null;
                                                    },
                                                    focusNode: extNode,
                                                    controller: _extractController,
                                                    title: 'นายทดสอบ ระบบ\n91/83 สายไหม สายไหม 10220\n0987654321',
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _extractController.text =
                                                                  'นายทดสอบ ระบบ\n91/83 สายไหม สายไหม 10220\n0987654321';
                                                            });
                                                          },
                                                          child: Text(
                                                            'ตัวอย่าง',
                                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.blue.shade800),
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            _extractController.clear();
                                                          },
                                                          child: Text(
                                                            'ล้าง',
                                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                                fontWeight: FontWeight.bold, color: Colors.red),
                                                          )),
                                                      loadingExt == true
                                                          ? SizedBox(
                                                              width: 18, height: 18, child: CircularProgressIndicator())
                                                          : TextButton(
                                                              onPressed: () async {
                                                                if (expkey.currentState!.validate()) {
                                                                  setState(() {
                                                                    loadingExt = true;
                                                                  });
                                                                  print('pass');
                                                                  await AddressNewRepository()
                                                                      .getNormalize(_extractController.text)
                                                                      .then((value) {
                                                                    if (value.status == true) {
                                                                      context.read<CreateOrderBloc>().add(
                                                                          OnRecieveSearchEvent(
                                                                              district: value.amphure!,
                                                                              subdistrict: value.district!,
                                                                              province: value.province!,
                                                                              zipcode: value.zipcode!,
                                                                              name: value.name!,
                                                                              phone: value.phone!,
                                                                              address: value.cutAll!));

                                                                      setState(() {
                                                                        loadingExt = false;
                                                                        isExtract = !isExtract;
                                                                        extNode.unfocus();
                                                                        _extractController.clear();
                                                                        Fluttertoast.showToast(
                                                                            msg: 'คัดแยกเรียบร้อย',
                                                                            gravity: ToastGravity.CENTER);
                                                                      });
                                                                    } else {
                                                                      loadingExt = false;
                                                                      extNode.requestFocus();
                                                                      responseDialog(context, 'ไม่สามารถคัดแยกได้');
                                                                    }
                                                                  });
                                                                  // context
                                                                  //     .read<CreateOrderBloc>()
                                                                  //     .add(OrderNormalizeEvent(context, _extractController.text));
                                                                  // setState(() {
                                                                  //   isExtract = !isExtract;
                                                                  //   extNode.unfocus();
                                                                  // });
                                                                } else {
                                                                  extNode.requestFocus();
                                                                }
                                                              },
                                                              child: Text('คัดแยก',
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .headlineSmall!
                                                                      .copyWith(
                                                                          fontWeight: FontWeight.bold,
                                                                          color: Colors.blue))),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text('ค้นหาที่อยู่ผู้รับ',
                                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                        GetTextField(
                                          focusNode: searchFocusNode,
                                          onTap: () async {
                                            searchFocusNode.unfocus();
                                            AddressSearchNewModel address = await showSearch(
                                                context: context, delegate: SearcgAddressNewDelegate());
                                            context
                                                .read<CreateOrderBloc>()
                                                .add(SelectAddressManulEvent(addressSearchNewModel: address));
                                            // districtController.text = address.amphure!;
                                            // subdistrictController.text = address.district!;
                                            // provinceController.text = address.province!;
                                            // zipcodeController.text = address.zipcode!;
                                            context.read<CreateOrderBloc>().add(OnRecieveSearchEvent(
                                                district: address.amphure!,
                                                subdistrict: address.district!,
                                                province: address.province!,
                                                zipcode: address.zipcode!,
                                                name: state.dstNameController.text,
                                                phone: state.dstPhoneController.text,
                                                address: state.dstAddressController.text));
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
                                                controller: state.dstNameController,
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
                                                controller: state.dstPhoneController,
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
                                                controller: state.dstAddressController,
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
                                                controller: state.dstSubdistrictController,
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
                                                controller: state.dstDistrictController,
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
                                                controller: state.dstProvinceController,
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
                                                controller: state.dstZipcodeController,
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
                          );
                        } else {
                          return Padding(
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
                          );
                        }
                      },
                    ),
                    BlocBuilder<CreateOrderBloc, CreateOrderState>(
                      builder: (context, state) {
                        if (state is CreateOrderData) {
                          return Padding(
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
                                              'พัสดุ',
                                              style: TextStyle(
                                                  color: Colors.blue.shade800,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text('ประเภทพัสดุ ',
                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6.5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<CategoryNewModel>(
                                                isExpanded: true,
                                                icon: Icon(Icons.arrow_drop_down),
                                                iconSize: 24,
                                                elevation: 16,
                                                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.blueAccent,
                                                ),
                                                items: state.categories.map<DropdownMenuItem<CategoryNewModel>>((e) {
                                                  return DropdownMenuItem<CategoryNewModel>(
                                                      value: e,
                                                      child: Row(
                                                        children: [
                                                          Text(e.name ?? '',
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .headlineSmall!
                                                                  .copyWith(
                                                                      color: Colors.black54,
                                                                      fontWeight: FontWeight.bold))
                                                        ],
                                                      ));
                                                }).toList(),
                                                onChanged: (value) {
                                                  context
                                                      .read<CreateOrderBloc>()
                                                      .add(SelectCategoryEvent(category: value!));
                                                },
                                                value: state.category,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Text(
                                    //         'น้ำหนัก : ',
                                    //         style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 4,
                                    //       child: GetTextField(
                                    //         validator: (v) {
                                    //           if (v == null || v.isEmpty) {
                                    //             return 'กรุณากรอกข้อมูล';
                                    //           }
                                    //           if (double.tryParse(v) == null) {
                                    //             return 'กรุณากรอกเฉพาะตัวเลข';
                                    //           }
                                    //           if (double.parse(v) < 1) {
                                    //             return 'ต้องมีน้ำหนักอย่างน้อย 1';
                                    //           }
                                    //           return null;
                                    //         },
                                    //         controller: weigthController,
                                    //         textInputType: TextInputType.numberWithOptions(decimal: true),
                                    //         preIcon: Icons.scale_outlined,
                                    //         enableIconPrefix: true,
                                    //         title: 'น้ำหนัก',
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Text(
                                    //         'กว้าง : ',
                                    //         style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 4,
                                    //       child: GetTextField(
                                    //         controller: widthController,
                                    //         textInputType: TextInputType.numberWithOptions(decimal: true),
                                    //         preIcon: Icons.width_wide,
                                    //         enableIconPrefix: true,
                                    //         title: 'ความกว้าง',
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Text(
                                    //         'ยาว : ',
                                    //         style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 4,
                                    //       child: GetTextField(
                                    //         controller: lengthController,
                                    //         textInputType: TextInputType.numberWithOptions(decimal: true),
                                    //         preIcon: CupertinoIcons.cube,
                                    //         enableIconPrefix: true,
                                    //         title: 'ความยาว',
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Text(
                                    //         'สูง : ',
                                    //         style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 4,
                                    //       child: GetTextField(
                                    //         controller: heigthController,
                                    //         textInputType: TextInputType.numberWithOptions(decimal: true),
                                    //         preIcon: Icons.height,
                                    //         enableIconPrefix: true,
                                    //         title: 'ความสูง',
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Text(
                            '...',
                            style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.w500),
                          );
                        }
                      },
                    ),
                    BlocBuilder<CreateOrderBloc, CreateOrderState>(builder: (context, state) {
                      if (state is CreateOrderData) {
                        return Column(
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
                                                style: TextStyle(
                                                    color: Colors.blue.shade800,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '  หมายเหตุ',
                                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                          ),
                                          // Container(
                                          //   //height: 100,
                                          //   decoration: BoxDecoration(
                                          //     color: Theme.of(context).scaffoldBackgroundColor,
                                          //     // borderRadius: BorderRadius.circular(6),
                                          //     // border: Border.all(color: _nodeText13.hasFocus ? Colors.blue.shade400 : Colors.grey.shade400),
                                          //   ),
                                          //   child: TextFormField(
                                          //     minLines: 5,
                                          //     maxLines: 5,
                                          //     keyboardType: TextInputType.multiline,
                                          //     controller: state.remarkController,
                                          //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: PlatformSize(context)),
                                          //     decoration: new InputDecoration(
                                          //       fillColor: Colors.white,
                                          //       focusedBorder: OutlineInputBorder(
                                          //           borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(4)),
                                          //       enabledBorder: OutlineInputBorder(
                                          //           borderSide: BorderSide(width: 0.7, color: Colors.grey), //<-- SEE HERE
                                          //           borderRadius: BorderRadius.circular(10)),
                                          //       contentPadding: const EdgeInsets.all(5),
                                          //       hintText: '  หมายเหตุ',
                                          //       hintStyle: Theme.of(context)
                                          //           .textTheme
                                          //           .bodyLarge!
                                          //           .copyWith(fontSize: PlatformSize(context), color: Colors.grey),
                                          //       border: InputBorder.none,
                                          //     ),
                                          //     onChanged: (v) {
                                          //       //context.read<CreateOrderBloc>().add(OrderRemarkChangeEvent(v));
                                          //     },
                                          //   ),
                                          // ),
                                          GetTextFieldMultiLine(
                                            textInputType: TextInputType.multiline,
                                            controller: state.remarkController,
                                            title: '  หมายเหตุ',
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              sharePrefs = await SharedPreferences.getInstance();
                                              bool? condition = sharePrefs!.getBool('is_cod_condition');
                                              if (state.isCod == false) {
                                                if (condition == false || condition == null) {
                                                  CustomDialog().showAlertCODConditionDialog(
                                                      context: context,
                                                      onPressed: () {
                                                        sharePrefs!.setBool('is_cod_condition', true);
                                                        Navigator.pop(context);
                                                      },
                                                      onCancel: () {
                                                        Navigator.pop(context);
                                                      });
                                                }
                                              }
                                              context
                                                  .read<CreateOrderBloc>()
                                                  .add(OnCheckBoxCodChange(isCod: !state.isCod));
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Checkbox(
                                                    value: state.isCod,
                                                    onChanged: (value) async {
                                                      sharePrefs = await SharedPreferences.getInstance();
                                                      bool? condition = sharePrefs!.getBool('is_cod_condition');
                                                      if (value == true) {
                                                        if (condition == false || condition == null) {
                                                          CustomDialog().showAlertCODConditionDialog(
                                                              context: context,
                                                              onPressed: () {
                                                                sharePrefs!.setBool('is_cod_condition', true);
                                                                Navigator.pop(context);
                                                              },
                                                              onCancel: () {
                                                                Navigator.pop(context);
                                                              });
                                                        }
                                                      }
                                                      context
                                                          .read<CreateOrderBloc>()
                                                          .add(OnCheckBoxCodChange(isCod: value!));
                                                    }),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  'เก็บเงินปลายทาง (ถ้ามี)',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall!
                                                      .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            child: Visibility(
                                              visible: state.isCod,
                                              child: GetTextField(
                                                validator: (v) {
                                                  if (state.isCod == true) {
                                                    if (v == null || v.isEmpty) {
                                                      return 'กรุณากรอกข้อมูล';
                                                    } else {
                                                      return null;
                                                    }
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                controller: state.codController,
                                                textInputType: TextInputType.number,
                                                preIcon: Icons.local_shipping_rounded,
                                                enableIconPrefix: true,
                                                title: 'เก็บเงินปลายทาง (COD)',
                                              ),
                                            ),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            child: Visibility(
                                              visible: state.isCod,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(),
                                                      borderRadius: BorderRadius.circular(8)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            text:
                                                                '***ข้อมูลสินค้านี้จะทำการส่งให้ทางขนส่งตามมาตราการส่งดี (Dee-Delivery) ของ สคบ',
                                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                                color: Colors.red, fontWeight: FontWeight.bold),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text: ' รายละเอียดเพิ่มเติม',
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .headlineSmall!
                                                                    .copyWith(
                                                                        color: Colors.blue.shade700,
                                                                        fontWeight: FontWeight.bold),
                                                                recognizer: TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    launchUrl(Uri.parse(
                                                                        'https://www.ocpb.go.th/news_view.php?nid=15465'));
                                                                  },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(),
                                                        state.products.isEmpty
                                                            ? TextButton(
                                                                onPressed: () {
                                                                  addProductModal(context);
                                                                },
                                                                child: Text(
                                                                  '+ เพิ่มสินค้า',
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .headlineSmall!
                                                                      .copyWith(
                                                                          color: Colors.blue.shade700,
                                                                          fontWeight: FontWeight.bold),
                                                                ))
                                                            : Column(
                                                                children: [
                                                                  ListView.builder(
                                                                    physics: NeverScrollableScrollPhysics(),
                                                                    padding: EdgeInsets.zero,
                                                                    shrinkWrap: true,
                                                                    itemCount: state.products.length,
                                                                    itemBuilder: (context, index) {
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 2),
                                                                        child: GestureDetector(
                                                                          onTap: () {
                                                                            addProductModal(context,
                                                                                productCreateModel:
                                                                                    state.products[index],
                                                                                index: index);
                                                                          },
                                                                          child: Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                color: Colors.grey.shade200,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(
                                                                                    horizontal: 8, vertical: 8),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        '${state.products[index].productName} (${state.products[index].productPrice}฿) ${state.products[index].productQTY} ชิ้น',
                                                                                        style: Theme.of(context)
                                                                                            .textTheme
                                                                                            .headlineMedium!
                                                                                            .copyWith(
                                                                                                color: Colors.black87,
                                                                                                fontWeight:
                                                                                                    FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        CustomDialog().showRemoveDialog(
                                                                                          context: context,
                                                                                          msg:
                                                                                              'ต้องการลบสินค้านี้ใช่หรือไม่',
                                                                                          onPressed: () {
                                                                                            context
                                                                                                .read<CreateOrderBloc>()
                                                                                                .add(
                                                                                                  deleteProductCreateEvent(
                                                                                                    index: index,
                                                                                                  ),
                                                                                                );
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          title: 'ลบสินค้า',
                                                                                        );
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(),
                                                                                        width: 30,
                                                                                        child: Icon(
                                                                                          Icons.delete,
                                                                                          color: Colors.red,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                  state.products.length >= 10
                                                                      ? SizedBox()
                                                                      : TextButton(
                                                                          onPressed: () {
                                                                            addProductModal(context);
                                                                          },
                                                                          child: Text(
                                                                            '+ เพิ่มสินค้า',
                                                                            style: Theme.of(context)
                                                                                .textTheme
                                                                                .headlineSmall!
                                                                                .copyWith(
                                                                                    color: Colors.blue.shade700,
                                                                                    fontWeight: FontWeight.bold),
                                                                          ))
                                                                ],
                                                              )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // CustomExpansionTile(
                                          //   childrenPadding: EdgeInsets.all(0),
                                          //   tilePadding: EdgeInsets.all(0),
                                          //   initiallyExpanded: false,
                                          //   trailing: SizedBox(),
                                          //   isExpan: true,
                                          //   onExpansionChanged: (value) {
                                          //     context.read<CreateOrderBloc>().add(OnCheckBoxCodChange(isCod: value));
                                          //   },
                                          //   leading: MediaQuery.removePadding(
                                          //     context: context,
                                          //     removeRight: true,
                                          //     child: IgnorePointer(
                                          //       child: Checkbox(
                                          //           value: state.isCod,
                                          //           onChanged: (value) {
                                          //             setState(() {
                                          //               isCod = value!;
                                          //             });
                                          //           }),
                                          //     ),
                                          //   ),
                                          //   title: MediaQuery.removePadding(
                                          //     context: context,
                                          //     removeLeft: true,
                                          //     child: Row(
                                          //       mainAxisAlignment: MainAxisAlignment.start,
                                          //       children: [
                                          //         Text(
                                          //           'เก็บเงินปลายทาง (ถ้ามี)',
                                          //           style: Theme.of(context)
                                          //               .textTheme
                                          //               .headlineSmall!
                                          //               .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          //   children: [
                                          //     GetTextField(
                                          //       validator: (v) {
                                          //         if (isCod == true) {
                                          //           if (v == null || v.isEmpty) {
                                          //             return 'กรุณากรอกข้อมูล';
                                          //           } else {
                                          //             return null;
                                          //           }
                                          //         } else {
                                          //           return null;
                                          //         }
                                          //       },
                                          //       controller: state.codController,
                                          //       textInputType: TextInputType.number,
                                          //       preIcon: Icons.local_shipping_rounded,
                                          //       enableIconPrefix: true,
                                          //       title: 'เก็บเงินปลายทาง (COD)',
                                          //     ),
                                          //   ],
                                          // ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                  value: state.isInsure,
                                                  onChanged: (value) {
                                                    context
                                                        .read<CreateOrderBloc>()
                                                        .add(OnCheckBoxInsureChange(isInsure: value!));
                                                  }),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text('ซื้อประกัน',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall!
                                                      .copyWith(color: Colors.black87, fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                          AnimatedContainer(
                                            duration: Duration(milliseconds: 300),
                                            height: state.isInsure ? null : 0,
                                            child: Visibility(
                                              visible: state.isInsure,
                                              child: GetTextField(
                                                validator: (v) {
                                                  if (state.isInsure == true) {
                                                    if (v == null || v.isEmpty) {
                                                      return 'กรุณากรอกข้อมูล';
                                                    } else {
                                                      return null;
                                                    }
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                controller: state.insureController,
                                                textInputType: TextInputType.number,
                                                preIcon: Icons.list_alt_rounded,
                                                enableIconPrefix: true,
                                                title: 'ประกัน',
                                              ),
                                            ),
                                          ),
                                          // CustomExpansionTile(
                                          //   childrenPadding: EdgeInsets.all(0),
                                          //   tilePadding: EdgeInsets.all(0),
                                          //   initiallyExpanded: false,
                                          //   trailing: SizedBox(),
                                          //   isExpan: true,
                                          //   onExpansionChanged: (value) {
                                          //     context.read<CreateOrderBloc>().add(OnCheckBoxInsureChange(isInsure: value));
                                          //   },
                                          //   leading: MediaQuery.removePadding(
                                          //     context: context,
                                          //     removeRight: true,
                                          //     child: IgnorePointer(
                                          //       child: Checkbox(
                                          //           value: state.isInsure,
                                          //           onChanged: (value) {
                                          //             setState(() {
                                          //               isInsure = value!;
                                          //             });
                                          //           }),
                                          //     ),
                                          //   ),
                                          //   title: MediaQuery.removePadding(
                                          //     context: context,
                                          //     removeLeft: true,
                                          //     child: Row(
                                          //       mainAxisAlignment: MainAxisAlignment.start,
                                          //       children: [
                                          //         Text('ซื้อประกัน',
                                          //             style: Theme.of(context)
                                          //                 .textTheme
                                          //                 .headlineSmall!
                                          //                 .copyWith(color: Colors.black87, fontWeight: FontWeight.bold)),
                                          //       ],
                                          //     ),
                                          //   ),
                                          //   children: [
                                          //     GetTextField(
                                          //       validator: (v) {
                                          //         if (isInsure == true) {
                                          //           if (v == null || v.isEmpty) {
                                          //             return 'กรุณากรอกข้อมูล';
                                          //           } else {
                                          //             return null;
                                          //           }
                                          //         } else {
                                          //           return null;
                                          //         }
                                          //       },
                                          //       controller: state.insureController,
                                          //       textInputType: TextInputType.number,
                                          //       preIcon: Icons.list_alt_rounded,
                                          //       enableIconPrefix: true,
                                          //       title: 'ประกัน',
                                          //     ),
                                          //   ],
                                          // ),
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
                                                  style: TextStyle(
                                                      color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),
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
                        );
                      } else {
                        return Padding(
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
                        );
                      }
                    }),
                    BlocBuilder<CreateOrderBloc, CreateOrderState>(
                      builder: (context, state) {
                        if (state is CreateOrderData) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                                child: InkWell(
                                  splashColor: Colors.blue.shade300,
                                  onTap: () {
                                    bool checkcontain = false;
                                    String word = "Bulky";

                                    RegExp regex = RegExp(r"\b" + word + r"\b");
                                    if (regex.hasMatch(state.courierNewModel.name)) {
                                      checkcontain = true;
                                    }
                                    print(state.courierNewModel.name);
                                    print('checkcontain = $checkcontain');

                                    if (fromKey.currentState!.validate()) {
                                      if (state.courierNewModel.code == null) {
                                        Fluttertoast.showToast(msg: 'กรุณาเลือกขนส่ง', gravity: ToastGravity.CENTER);
                                      } else {
                                        if (state.isCod) {
                                          if (state.products.isEmpty) {
                                            CustomDialog().showAlertNormalDialog(
                                                context: context,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                msg: 'กรุณาเพิ่มสินค้าก่อนสร้างรายการ');
                                          } else {
                                            if (fromKey.currentState!.validate()) {
                                              createOrder(context, state, checkcontain);
                                            }
                                          }
                                        } else {
                                          if (fromKey.currentState!.validate()) {
                                            createOrder(context, state, checkcontain);
                                          }
                                        }
                                      }
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
                              ));
                        } else {
                          return Padding(
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
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createOrder(BuildContext context, CreateOrderData state, bool checkcontain) {
    try {
      loadingDialog(context);
      print('on create id = ${state.customerId}');
      print(checkcontain);
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
              dstName: state.dstNameController.text,
              dstPhone: state.dstPhoneController.text,
              dstAddress: state.dstAddressController.text,
              dstSubDistrict: state.dstSubdistrictController.text,
              dstDistrict: state.dstDistrictController.text,
              dstProvince: state.dstProvinceController.text,
              dstZipcode: state.dstZipcodeController.text,
              weight: checkcontain ? 5100 : 1000,
              width: 1,
              length: 1,
              height: 1,
              codAmount: double.parse(state.codController.text.isEmpty ? '0' : state.codController.text),
              remark: state.remarkController.text,
              isInsured: state.isInsure == true ? 1 : 0,
              productValue: state.isInsure == false
                  ? 0.0
                  : double.parse(state.insureController.text.isEmpty ? '0' : state.insureController.text),
              customerId: state.customerId,
              isBulky: state.isBulky,
              jntPickup: 6,
              kerryPickup: 0,
              categoryId: state.category.id!,
              saveDstAddress: isSave ? 1 : 0,
              products: state.products)
          .then((value) {
        if (value is bool) {
          // Error occurred, close loading dialog and show error message
          Navigator.pop(context);
          responseDialog(context, 'เกิดข้อผิดพลาดที่ไม่คาดคิด กรุณาติดต่อผู้ดูแล');
        } else {
          if (value['status'] == true) {
            context.read<OrderlistNewBloc>().add(OrderlistNewInitialEvent());
            context.read<CreateOrderBloc>().add(OnResetDstDataEvent());
            Navigator.pop(context);
            correctDialog(context, value['message']);
          } else if (value['status'] == false) {
            Navigator.pop(context);
            responseDialog(context, value['message']);
          } else {
            Navigator.pop(context);
            responseDialog(context, 'เกิดข้อผิดพลาดที่ไม่คาดคิด กรุณาติดต่อผู้ดูแล');
          }
        }
      });
    } catch (e) {
      print('create order exception = $e');
      Navigator.pop(context);
      responseDialog(context, 'เกิดข้อผิดพลาดที่ไม่คาดคิด กรุณาติดต่อผู้ดูแล');
    }
  }

  void addProductModal(BuildContext context, {ProductCreateModel? productCreateModel, int? index}) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController(text: productCreateModel?.productName ?? '');
    TextEditingController qtyController = TextEditingController(text: productCreateModel?.productQTY ?? '');
    TextEditingController weightController = TextEditingController(text: productCreateModel?.productWeight ?? '');
    TextEditingController widthController = TextEditingController(text: productCreateModel?.productWidth ?? '');
    TextEditingController lengthController = TextEditingController(text: productCreateModel?.productLength ?? '');
    TextEditingController heightController = TextEditingController(text: productCreateModel?.productHeight ?? '');
    TextEditingController colorController = TextEditingController(text: productCreateModel?.productColor ?? '');
    TextEditingController priceController = TextEditingController(text: productCreateModel?.productPrice ?? '');
    TextEditingController remarkController = TextEditingController(text: productCreateModel?.productRemark ?? '');
    showModalBottomSheet(
      backgroundColor: Colors.white,
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    print('tap');
                    FocusScope.of(context).unfocus();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
                      key: formKey,
                      child: Container(
                        decoration: BoxDecoration(),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.add_shopping_cart_outlined,
                                    size: 30,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    productCreateModel != null ? 'แก้ไขสินค้า' : 'เพิ่มสินค้า',
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Theme.of(context).focusColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text('ชื่อสินค้า : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 2,
                                      child: GetTextField(
                                        controller: nameController,
                                        title: 'ชื่อสินค้า',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ถูกต้อง';
                                          }
                                          return null;
                                        },
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text('จำนวน : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 2,
                                      child: GetTextField(
                                        controller: qtyController,
                                        title: 'จำนวน',
                                        textInputType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ถูกต้อง';
                                          }
                                          return null;
                                        },
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text('กว้าง : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 2,
                                      child: GetTextField(
                                        controller: widthController,
                                        title: 'กว้าง',
                                        textInputType: TextInputType.numberWithOptions(decimal: true),
                                        suffixText: 'cm',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ถูกต้อง';
                                          }
                                          return null;
                                        },
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text('ยาว : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 2,
                                      child: GetTextField(
                                        controller: lengthController,
                                        title: 'ยาว',
                                        textInputType: TextInputType.numberWithOptions(decimal: true),
                                        suffixText: 'cm',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ถูกต้อง';
                                          }
                                          return null;
                                        },
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text('สูง : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 2,
                                      child: GetTextField(
                                        controller: heightController,
                                        title: 'สูง',
                                        textInputType: TextInputType.numberWithOptions(decimal: true),
                                        suffixText: 'cm',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ถูกต้อง';
                                          }
                                          return null;
                                        },
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text('น้ำหนัก : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 2,
                                      child: GetTextField(
                                        controller: weightController,
                                        title: 'น้ำหนัก',
                                        textInputType: TextInputType.numberWithOptions(decimal: true),
                                        suffixText: 'kg',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ถูกต้อง';
                                          }
                                          return null;
                                        },
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text('สี : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 2,
                                      child: GetTextField(
                                        controller: colorController,
                                        title: 'สี',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ถูกต้อง';
                                          }
                                          return null;
                                        },
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text('ราคา : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 2,
                                      child: GetTextField(
                                        controller: priceController,
                                        title: 'ราคา',
                                        textInputType: TextInputType.numberWithOptions(decimal: true),
                                        suffixText: '฿',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูลให้ถูกต้อง';
                                          }
                                          return null;
                                        },
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('หมายเหตุ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              GetTextFieldMultiLine(
                                controller: remarkController,
                                title: 'หมายเหตุ',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (productCreateModel != null) {
                                      context.read<CreateOrderBloc>().add(editProductCreateEvent(
                                          index: index!,
                                          productCreate: ProductCreateModel(
                                            productName: nameController.text,
                                            productQTY: qtyController.text,
                                            productWidth: widthController.text,
                                            productLength: lengthController.text,
                                            productHeight: heightController.text,
                                            productWeight: weightController.text,
                                            productColor: colorController.text,
                                            productPrice: priceController.text,
                                            productRemark: remarkController.text,
                                          )));
                                      Navigator.pop(context);
                                    } else {
                                      context.read<CreateOrderBloc>().add(AddProductCreateEvent(
                                              productCreate: ProductCreateModel(
                                            productName: nameController.text,
                                            productQTY: qtyController.text,
                                            productWidth: widthController.text,
                                            productLength: lengthController.text,
                                            productHeight: heightController.text,
                                            productWeight: weightController.text,
                                            productColor: colorController.text,
                                            productPrice: priceController.text,
                                            productRemark: remarkController.text,
                                          )));
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: primaryColor,
                                    // gradient: LinearGradient(
                                    //     begin: Alignment.topCenter,
                                    //     end: Alignment.bottomCenter,
                                    //     colors: <Color>[
                                    //       Theme.of(context)
                                    //           .cupertinoOverrideTheme!
                                    //           .textTheme!
                                    //           .dateTimePickerTextStyle
                                    //           .color!,
                                    //       Theme.of(context).cupertinoOverrideTheme!.textTheme!.pickerTextStyle.color!
                                    //     ]),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        child: Text(
                                          productCreateModel != null ? 'แก้ไขสินค้า' : 'เพิ่มสินค้า',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
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
            textStyle:
                Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
            textStyle:
                Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
                        hintText: 'นายทดสอบ ระบบ\n91/83 สายไหม สายไหม 10220\n0987654321',
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
                                    context.read<CreateOrderBloc>().add(OnRecieveSearchEvent(
                                        district: value.amphure!,
                                        subdistrict: value.district!,
                                        province: value.province!,
                                        zipcode: value.zipcode!,
                                        name: value.name!,
                                        phone: value.phone!,
                                        address: value.cutAll!));
                                    setState(() {
                                      // dstnameController.text = value.name!;
                                      // addressController.text = value.cutAll!;
                                      // districtController.text = value.amphure!;
                                      // subdistrictController.text = value.district!;
                                      // provinceController.text = value.province!;
                                      // zipcodeController.text = value.zipcode!;
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
