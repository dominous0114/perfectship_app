import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perfectship_app/bloc/new_bloc/create_order/create_order_bloc.dart';
import 'package:perfectship_app/model/new_model/category_new_model.dart';
import 'package:perfectship_app/model/new_model/courier_new_model.dart';
import 'package:perfectship_app/screen/createorder/new_widget.dart/search_address_delegate.dart';
import 'package:perfectship_app/widget/gettextfield.dart';

import '../../../model/new_model/address_search_new_model.dart';

class CreateOrderNew extends StatefulWidget {
  const CreateOrderNew({Key? key}) : super(key: key);

  @override
  State<CreateOrderNew> createState() => _CreateOrderNewState();
}

class _CreateOrderNewState extends State<CreateOrderNew> {
  final fromKey = GlobalKey<FormState>();
  final Color primaryColor = Color.fromARGB(235, 53, 136, 195);
  FocusNode searchFocusNode = FocusNode();
  TextEditingController addressController = TextEditingController();
  TextEditingController subdistrictController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
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
        child: Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
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
              body: CustomScrollView(
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
                                          'ข้อมูลของผู้ส่ง',
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
                                          child: Row(
                                            children: [
                                              Text('ชื่อ : ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                              Text('${state.labelName}',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('เบอร์โทร : ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                              Text('${state.labelPhone}',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('ที่อยู่ : ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                        Expanded(
                                          child: Text(
                                              '${state.labelAddress} ${state.labelSubDistrict} ${state.labelDistrict} ${state.labelProvince} ${state.labelZipcode}',
                                              style: TextStyle(
                                                color: Colors.black87,
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('ขนส่งเริ่มต้น : ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                              Container(
                                                width: 150,
                                                child: Image.network(
                                                  state.courierImg,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Text('ไม่มีขนส่งเริ่มต้น',
                                                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(color: Colors.blue, blurRadius: 1, offset: Offset(0.5, 1)),
                                          ],
                                          borderRadius: BorderRadius.circular(16)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('แก้ไขข้อมูลผู้ส่ง',
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                )),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1, child: Text('เลือกขนส่ง : ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6.5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          // boxShadow: [
                                          //   BoxShadow(color: Colors.black26, spreadRadius: 0.5, blurRadius: 1),
                                          // ],
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<CourierNewModel>(
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
                                            items: state.courierNewModels.map<DropdownMenuItem<CourierNewModel>>((e) {
                                              return DropdownMenuItem(
                                                  value: e,
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Image.network(
                                                          e.logo ?? '',
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
                                                          style: TextStyle(fontSize: 15),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                            }).toList(),
                                            onChanged: (value) {
                                              //ontext.read<CreateOrderBloc>().add(OrderSelectFuze(value: value!));
                                              //  _onDropDownItemSelected(value!);
                                              print(value!.name);
                                              context.read<CreateOrderBloc>().add(SelectCourierEvent(courier: value));
                                            },
                                            value: state.courierNewModel,
                                            underline: SizedBox(),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
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
                                              Text('ค้นหาที่อยู่ผู้รับ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
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
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          flex: 2,
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
                                        AddressSearchNewModel address = await showSearch(context: context, delegate: SearcgAddressNewDelegate());
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
                                            'บ้านเลขที่ : ',
                                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: GetTextField(
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
                        );
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
                                          flex: 1, child: Text('ประเภทพัสดุ ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
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
                                          'จังหวัด : ',
                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: GetTextField(
                                          controller: provinceController,
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
                ],
              ),
            )),
      ),
    );
  }
}
