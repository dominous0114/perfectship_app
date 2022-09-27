import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:perfectship_app/bloc/address_bloc/address_bloc.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import '../../../widget/fontsize.dart';

class SenderAddressScreen extends StatefulWidget {
  const SenderAddressScreen({Key? key}) : super(key: key);
  static const String routeName = '/senderaddress';

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => SenderAddressScreen());
  }

  @override
  State<SenderAddressScreen> createState() => _SenderAddressScreenState();
}

class _SenderAddressScreenState extends State<SenderAddressScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;
  TextEditingController textController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  bool _isprimayloading = false;

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
      print(isPlaying);
    });
  }

  void _showAlertSetprimary(BuildContext context, String id) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          bool _isprimayloading = false;
          return StatefulBuilder(builder: (context, StateSetter setState) {
            print(_isprimayloading);
            return BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressLoading) {
                  return Center(
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
                  );
                } else if (state is AddressLoaded) {
                  return CupertinoAlertDialog(
                    title: Text(
                      'แจ้งเตือน',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: PlatformSize(context) * 1.2,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      'คุณต้องการตั้งที่อยู่นี้เป็นที่อยู่เริ่มต้นหรือไม่',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: PlatformSize(context) * 1.1,
                          fontWeight: FontWeight.normal),
                    ),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () {
                          // setState(() {
                          //   _isprimayloading = true;
                          // });
                          context.read<AddressBloc>().add(
                              SetPrimaryAddressEvent(id: id, context: context));
                          print(_isprimayloading.toString());
                        },
                        child: const Text('ตกลง'),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('ยกเลิก'),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            );
          });
        });
  }

  void _showAlertDelete(BuildContext context, String id) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressLoading) {
                  return Center(
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
                  );
                } else if (state is AddressLoaded) {
                  return CupertinoAlertDialog(
                    title: Text(
                      'แจ้งเตือน',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: PlatformSize(context) * 1.2,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      'คุณต้องลบที่อยู่นี้หรือไม่',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: PlatformSize(context) * 1.1,
                          fontWeight: FontWeight.normal),
                    ),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () {
                          // setState(() {
                          //   _isprimayloading = true;
                          // });
                          context.read<AddressBloc>().add(
                              DeleteAddressEvent(id: id, context: context));
                        },
                        child: const Text('ตกลง'),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('ยกเลิก'),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            );
          });
        });
  }

  buildSearch(BuildContext context, int total) {
    return Container(
      //decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(offset: Offset.zero, spreadRadius: .2, color: Colors.grey.shade400)]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          children: [
            isPlaying
                ? Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset.zero,
                                spreadRadius: .3,
                                color: Colors.grey)
                          ]),
                      child: TextFormField(
                        style: TextStyle(fontSize: PlatformSize(context)),
                        cursorColor: Colors.blue.shade300,
                        controller: textController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        focusNode: searchFocusNode,
                        onChanged: (keyword) async {
                          if (textController.text == '') {
                            context
                                .read<AddressBloc>()
                                .add(AddressInitialEvent());
                          } else {}
                          context
                              .read<AddressBloc>()
                              .add(AddressSearchEvent(keyword: keyword));
                        },
                        decoration: InputDecoration(
                            prefixIconColor: Colors.blue.shade300,
                            iconColor: Colors.blue.shade300,
                            focusColor: Colors.blue.shade300,
                            contentPadding: EdgeInsets.symmetric(vertical: 1),
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            suffix: TextButton(
                              onPressed: () {
                                context
                                    .read<AddressBloc>()
                                    .add(AddressInitialEvent());
                                setState(() {
                                  textController.clear();
                                  searchFocusNode.unfocus();
                                });
                              },
                              child: Text(
                                'ล้าง',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: Colors.blue.shade300,
                                        fontSize: PlatformSize(context)),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'ค้นหา ชื่อ ที่อยู่ เบอร์โทร',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: PlatformSize(context))),
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            'ทั้งหมด $total รายการ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: PlatformSize(context) * 1.2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () => _handleOnPressed(),
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset.zero,
                            spreadRadius: .3,
                            color: Colors.grey)
                      ]),
                  child: Center(
                    child: AnimatedIcon(
                      color: Colors.black54,
                      icon: AnimatedIcons.search_ellipsis,
                      progress: _animationController,
                    ),
                  )),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/addaddress');
              },
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colors.blue.shade300, Colors.blue]),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset.zero,
                            spreadRadius: .3,
                            color: Colors.grey)
                      ]),
                  child: Center(
                    child: Icon(
                      Icons.add_location_alt_outlined,
                      color: Colors.white,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    context.read<AddressBloc>().add(AddressInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ที่อยู่ในการเข้ารับพัสดุ',
        backArrow: true,
        onPressArrow: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is AddressLoading) {
            return LoadingShimmer();
          } else if (state is AddressLoaded) {
            print('length = ${state.addressmodel.length}');
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1), () {
                  textController.clear();
                  context.read<AddressBloc>().add(AddressInitialEvent());
                });
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black)]),
                      child: buildSearch(context, state.addressmodel.length),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.addressmodel.length,
                      itemBuilder: (context, index) {
                        state.addressmodel.sort(
                          (a, b) =>
                              b.primaryAddress!.compareTo(a.primaryAddress!),
                        );
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Slidable(
                                // enabled: AddressModel.addresstest[index].primaryAddress == 1
                                //     ? false
                                //     : true,
                                endActionPane: state.addressmodel[index]
                                            .primaryAddress ==
                                        1
                                    ? ActionPane(
                                        extentRatio: 2 / 5,
                                        motion: DrawerMotion(),
                                        children: [
                                            SlidableAction(
                                              onPressed: (context) {
                                                _showAlertDelete(
                                                    context,
                                                    state.addressmodel[index].id
                                                        .toString());
                                              },
                                              label: 'ลบ',
                                              icon: CupertinoIcons.delete,
                                              foregroundColor: Colors.red,
                                              backgroundColor: Colors.white,
                                            )
                                          ])
                                    : ActionPane(
                                        extentRatio: 3.5 / 5,
                                        motion: DrawerMotion(),
                                        children: [
                                            SlidableAction(
                                              onPressed: (context) {
                                                // showDialog(
                                                //   context: context,
                                                //   builder: (context) => Center(
                                                //     child: Container(
                                                //       width: 60.0,
                                                //       height: 60.0,
                                                //       decoration: BoxDecoration(
                                                //         color: Colors.white,
                                                //         borderRadius:
                                                //             BorderRadius
                                                //                 .circular(4.0),
                                                //       ),
                                                //       child: Padding(
                                                //         padding:
                                                //             const EdgeInsets
                                                //                 .all(12.0),
                                                //         child:
                                                //             CupertinoActivityIndicator(),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // );

                                                _showAlertSetprimary(
                                                    context,
                                                    state.addressmodel[index].id
                                                        .toString());
                                              },
                                              label: 'ที่อยู่เริ่มต้น',
                                              icon:
                                                  CupertinoIcons.location_fill,
                                              foregroundColor: Color.fromARGB(
                                                  180, 41, 88, 162),
                                              backgroundColor: Colors.white,
                                            ),
                                            SlidableAction(
                                              onPressed: (context) {
                                                _showAlertDelete(
                                                    context,
                                                    state.addressmodel[index].id
                                                        .toString());
                                              },
                                              label: 'ลบ',
                                              icon: CupertinoIcons.delete,
                                              foregroundColor: Colors.red,
                                              backgroundColor: Colors.white,
                                            )
                                          ]),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/editaddress',
                                        arguments: state.addressmodel[index]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 1, color: Colors.grey)
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              gradient: state
                                                          .addressmodel[index]
                                                          .primaryAddress ==
                                                      1
                                                  ? LinearGradient(
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
                                                    )
                                                  : LinearGradient(
                                                      colors: [
                                                        Colors.grey.shade200,
                                                        Colors.grey.shade300
                                                      ],
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                      stops: [0.0, 0.8],
                                                      tileMode: TileMode.clamp,
                                                    ),
                                              // color: state.addressmodel[index]
                                              //             .primaryAddress ==
                                              //         1
                                              //     ? Colors.blue.shade300
                                              //     : Colors.grey.shade200,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight:
                                                      Radius.circular(5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: state
                                                                  .addressmodel[
                                                                      index]
                                                                  .primaryAddress ==
                                                              1
                                                          ? Colors.white
                                                          : Colors.blue,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      // '${state.addressmodel[index].name}',
                                                      '${state.addressmodel[index].name}',
                                                      style: TextStyle(
                                                          color: state
                                                                      .addressmodel[
                                                                          index]
                                                                      .primaryAddress ==
                                                                  1
                                                              ? Colors.white
                                                              : Colors.blue,
                                                          fontSize:
                                                              PlatformSize(
                                                                      context) *
                                                                  1.1,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                state.addressmodel[index]
                                                            .primaryAddress ==
                                                        1
                                                    ? Row(
                                                        children: [
                                                          Icon(
                                                            Icons.add_task,
                                                            color: Colors
                                                                .green.shade900,
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            // '${state.addressmodel[index].name}',
                                                            'ที่อยู่เริ่มต้น',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    PlatformSize(
                                                                            context) *
                                                                        1.1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'เบอร์โทร : ${state.addressmodel[index].phone}',
                                                    style: TextStyle(
                                                        fontSize: PlatformSize(
                                                            context),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    // ' ${state.addressmodel[index].phone}',
                                                    '',
                                                    style: TextStyle(
                                                        fontSize: PlatformSize(
                                                            context),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'ที่อยู่ :',
                                                    style: TextStyle(
                                                        fontSize: PlatformSize(
                                                            context),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      ' ${state.addressmodel[index].address} ${state.addressmodel[index].subDistrict} ${state.addressmodel[index].district} ${state.addressmodel[index].province} ${state.addressmodel[index].zipcode}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              PlatformSize(
                                                                  context),
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
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
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
