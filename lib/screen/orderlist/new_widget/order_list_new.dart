import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import 'package:perfectship_app/bloc/new_bloc/navbar/navbar_bloc.dart';
import 'package:perfectship_app/bloc/new_bloc/tracking/tracking_bloc.dart';
import 'package:perfectship_app/screen/createorder/new_widget/persis_delegate.dart';
import 'package:perfectship_app/screen/orderlist/new_widget/filter_ordernew.dart';
import 'package:perfectship_app/screen/orderlist/new_widget/testwidget.dart';
import 'package:perfectship_app/screen/orderlist/new_widget/tracking_list.dart';
import 'package:perfectship_app/widget/gettextfield.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';
import 'package:perfectship_app/widget/status_color.dart';

import '../../../bloc/new_bloc/orderlist_new/orderlist_new_bloc.dart';
import '../../../model/new_model/orderlist_new_model.dart';
import '../../../repository/new_repository/order_reposittory.dart';
import '../../../widget/allkey.dart';
import '../../../widget/fontsize.dart';

class OrderlistNewScreen extends StatefulWidget {
  const OrderlistNewScreen({Key? key}) : super(key: key);

  @override
  State<OrderlistNewScreen> createState() => _OrderlistNewScreenState();
}

class _OrderlistNewScreenState extends State<OrderlistNewScreen> {
  ScrollController scrollController = ScrollController();
  Timer? _scrollTimer;
  bool isSelect = false;
  List<OrderlistNewModel> _selectedItems = [];

  Future<void> _refresh() async {
    print('on refersh');
    Future bloc = context.read<OrderlistNewBloc>().stream.first;
    context.read<OrderlistNewBloc>().add(OrderlistNewInitialEvent());
    await bloc;
  }

  @override
  void initState() {
    scrollController.addListener(() {
      if (isSelect == false) {
        if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          context.read<NavbarBloc>().add(NavbarOrderScrollHideEvent());
        }
        if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
          context.read<NavbarBloc>().add(NavbarOrderScrollShowEvent());
        }
        _scrollTimer?.cancel();

        // Start a new timer for 2 seconds
        _scrollTimer = Timer(Duration(seconds: 1), () {
          // Show bottom navbar when there's no scrolling for 2 seconds

          context.read<NavbarBloc>().add(NavbarOrderScrollShowEvent());
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              body: BlocBuilder<NavbarBloc, NavbarState>(
                builder: (context, state) {
                  if (state is NavbarInitial) {
                    return NestedScrollView(
                      controller: scrollController,
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverAppBar(
                          floating: true,
                          snap: true,
                          pinned: false,
                          toolbarHeight: MediaQuery.of(context).size.height * 0.072,
                          elevation: 0,
                          title: GestureDetector(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/image/DTracking.png',
                                  scale: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'รายการพัสดุ',
                                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                        fontSize: PlatformSize(context) * 1.2,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                )
                              ],
                            ),
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
                          actions: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSelect = !isSelect;
                                    if (isSelect == false) {
                                      context.read<NavbarBloc>().add(NavbarOrderScrollShowEvent());
                                    } else {
                                      context.read<NavbarBloc>().add(NavbarOrderScrollHideEvent());
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.print,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ],
                      floatHeaderSlivers: true,
                      body: BlocBuilder<OrderlistNewBloc, OrderlistNewState>(
                        builder: (context, state) {
                          if (state is OrderlistNewLoading) {
                            return LoadingShimmer();
                          } else if (state is OrderlistNewLoaded) {
                            return RefreshIndicator(
                              onRefresh: isSelect
                                  ? () async {}
                                  : () async {
                                      await _refresh();
                                    },
                              child: CustomScrollView(
                                slivers: [
                                  SliverPersistentHeader(
                                    pinned: true,
                                    delegate: FloatingHeaderDelegate(minHeight: isSelect ? 0 : 50, maxHeight: isSelect ? 0 : 50, minChild: persistentChild(isSelect: isSelect), maxChild: persistentChild(isSelect: isSelect)),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'ทั้งหมด ${state.orderlist.length} รายการ',
                                            style: Theme.of(context).textTheme.headline6,
                                          ),
                                          Text('${DateFormat('dd/MM/yyyy').format(state.startDate)} - ${DateFormat('dd/MM/yyyy').format(state.endDate)}')
                                        ],
                                      ),
                                    ),
                                  ),
                                  state.orderlist.isEmpty
                                      ? SliverToBoxAdapter(
                                          child: Center(
                                              child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height * 0.3,
                                              ),
                                              Text(
                                                'ไม่พบข้อมูล',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                        )
                                      : SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (isSelect) {
                                                      if (_selectedItems.contains(state.orderlist[index])) {
                                                        setState(() {
                                                          _selectedItems.removeWhere((element) => element.id == state.orderlist[index].id);
                                                        });
                                                      } else {
                                                        setState(() {
                                                          _selectedItems.add(state.orderlist[index]);
                                                        });
                                                      }

                                                      print(_selectedItems[0].id);
                                                      print(state.orderlist[0].id);
                                                    } else {
                                                      context.read<TrackingBloc>().add(TrackingInitialEvent(track: state.orderlist[index].trackNo!));
                                                      Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                            builder: (context) => TrackingListScreen(
                                                              logo: state.orderlist[index].logo!,
                                                              logoMobile: state.orderlist[index].logoMobile!,
                                                              statusColor: state.orderlist[index].statusColor!,
                                                              statusText: state.orderlist[index].statusName!,
                                                            ),
                                                          ));
                                                    }
                                                  },
                                                  onLongPress: () {
                                                    setState(() {
                                                      context.read<NavbarBloc>().add(NavbarOrderScrollHideEvent());
                                                      if (_selectedItems.isEmpty) {
                                                        isSelect = true;
                                                        //Vibration.vibrate(duration: 50);
                                                        _selectedItems.add(state.orderlist[index]);
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      color: Colors.white,
                                                      boxShadow: [_selectedItems.contains(state.orderlist[index]) ? BoxShadow(color: Colors.blue, spreadRadius: 3, blurRadius: 4) : BoxShadow(color: Colors.black45, spreadRadius: 0, blurRadius: 1)],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Expanded(
                                                                  flex: 3,
                                                                  child: Stack(
                                                                    alignment: Alignment.center,
                                                                    children: [
                                                                      Image.network(
                                                                        state.orderlist[index].logoMobile!,
                                                                      ),
                                                                      _selectedItems.contains(state.orderlist[index]) ? Lottie.asset('assets/lottie/78295-correct.json', repeat: false) : SizedBox()
                                                                    ],
                                                                  )),
                                                              Expanded(flex: 1, child: SizedBox()),
                                                              Expanded(
                                                                flex: 8,
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      state.orderlist[index].trackNo!,
                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          'ผู้รับ : ',
                                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                                        ),
                                                                        Text(
                                                                          '${state.orderlist[index].dstName!}',
                                                                          style: TextStyle(fontSize: 14),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          'เบอร์โทร : ',
                                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                                        ),
                                                                        Text(
                                                                          '${state.orderlist[index].dstPhone!}',
                                                                          style: TextStyle(fontSize: 14),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          'COD : ',
                                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                                        ),
                                                                        Text(
                                                                          '${state.orderlist[index].codAmount!}',
                                                                          style: TextStyle(fontSize: 14),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          'สถานะ : ',
                                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                                        ),
                                                                        Container(
                                                                          decoration: BoxDecoration(color: StatusColor().checkstatus(state.orderlist[index].statusColor!), borderRadius: BorderRadius.circular(8)),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                                                            child: Text(
                                                                              '${state.orderlist[index].statusName!}',
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      'ที่อยู่ : ',
                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 9,
                                                                      child: Text(
                                                                        '${state.orderlist[index].dstAddress!} ${state.orderlist[index].dstSubDistrict!} ${state.orderlist[index].dstDistrict!} ${state.orderlist[index].dstProvince!} ${state.orderlist[index].dstZipcode!}',
                                                                        style: TextStyle(fontSize: 14),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                        flex: 1,
                                                                        child: IgnorePointer(
                                                                          ignoring: isSelect,
                                                                          child: PopupMenuButton(
                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                            child: Container(
                                                                              //color: Colors.amber,
                                                                              height: 23,
                                                                              width: 40,
                                                                              alignment: Alignment.centerRight,
                                                                              child: Icon(
                                                                                Icons.more_vert,
                                                                              ),
                                                                            ),
                                                                            color: Colors.white,
                                                                            itemBuilder: state.orderlist[index].statusName != 'รอเข้าระบบ'
                                                                                ? (context) {
                                                                                    return [
                                                                                      PopupMenuItem(
                                                                                          onTap: () {
                                                                                            Future.delayed(
                                                                                              Duration(milliseconds: 1),
                                                                                              () {
                                                                                                Navigator.pushNamed(context, '/pdforder', arguments: state.orderlist[index].id.toString());
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Icon(
                                                                                                CupertinoIcons.printer,
                                                                                                color: Colors.blue.shade700,
                                                                                              ),
                                                                                              SizedBox(width: 5),
                                                                                              Text('ปริ้นท์ใบปะหน้า ',
                                                                                                  style: TextStyle(
                                                                                                    fontSize: PlatformSize(context),
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                    color: Colors.black,
                                                                                                  ))
                                                                                            ],
                                                                                          )),
                                                                                    ];
                                                                                  }
                                                                                : (context) {
                                                                                    return [
                                                                                      PopupMenuItem(
                                                                                          onTap: () {
                                                                                            Future.delayed(
                                                                                              Duration(milliseconds: 1),
                                                                                              () {
                                                                                                print(state.orderlist[index].id);
                                                                                                Navigator.pushNamed(context, '/pdforder', arguments: state.orderlist[index].id.toString());
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Icon(
                                                                                                CupertinoIcons.printer,
                                                                                                color: Colors.blue.shade700,
                                                                                              ),
                                                                                              SizedBox(width: 5),
                                                                                              Text('ปริ้นท์ใบปะหน้า ', style: Theme.of(context).textTheme.headline5)
                                                                                            ],
                                                                                          )),
                                                                                      PopupMenuItem(
                                                                                          onTap: () {
                                                                                            Future.delayed(
                                                                                              Duration(milliseconds: 1),
                                                                                              () {
                                                                                                confirmDialog(context, state.orderlist[index].trackNo!, state.orderlist[index]);
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Icon(
                                                                                                CupertinoIcons.delete,
                                                                                                color: Colors.red,
                                                                                              ),
                                                                                              SizedBox(width: 5),
                                                                                              Text('ลบ ', style: Theme.of(context).textTheme.headline5)
                                                                                            ],
                                                                                          )),
                                                                                    ];
                                                                                  },
                                                                          ),
                                                                        ))
                                                                  ],
                                                                ),
                                                                state.orderlist[index].remark == null || state.orderlist[index].remark == ''
                                                                    ? SizedBox()
                                                                    : Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'หมายเหตุ : ',
                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                                          ),
                                                                          Expanded(
                                                                            child: Text(
                                                                              '${state.orderlist[index].remark.toString()}',
                                                                              style: TextStyle(fontSize: 14),
                                                                            ),
                                                                          ),
                                                                        ],
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
                                            },
                                            childCount: state.orderlist.length,
                                          ),
                                        ),
                                  SliverToBoxAdapter(
                                    child: SizedBox(
                                      height: 120,
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: Text('เกิดข้อผิดพลาดบางอย่าง'),
                            );
                          }
                        },
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ),
        ),
        AnimatedContainer(
          height: isSelect ? MediaQuery.of(context).size.height * 0.13 : 0,
          duration: Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 1)]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/image/DplusExpress-02.png',
                            scale: 20,
                          ),
                          _selectedItems.length == 0
                              ? Text(
                                  '   กรุณาเลือกรายการ',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  '   ${_selectedItems.length} รายการ',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: _selectedItems.length == 0
                                ? () {}
                                : () {
                                    String printdata = _selectedItems.map((e) => e.id).toList().join(',');
                                    Navigator.pushNamed(context, '/pdforder', arguments: printdata);

                                    setState(() {
                                      _selectedItems.clear();
                                      isSelect = false;
                                      context.read<NavbarBloc>().add(NavbarOrderScrollShowEvent());
                                    });
                                  },
                            icon: Icon(
                              Icons.print_outlined,
                              color: _selectedItems.length == 0 ? Colors.grey : Colors.blue,
                            )),
                        IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                isSelect = !isSelect;
                                if (isSelect == false) {
                                  context.read<NavbarBloc>().add(NavbarOrderScrollShowEvent());
                                } else {
                                  context.read<NavbarBloc>().add(NavbarOrderScrollHideEvent());
                                }
                                _selectedItems.clear();
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.blue,
                            )),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void confirmDialog(BuildContext context, String track, OrderlistNewModel model) {
  Dialogs.materialDialog(msgAlign: TextAlign.center, msg: 'คุณต้องการลบรายการ $track ?', title: "ลบรายการ", color: Colors.white, context: context, actions: [
    IconsOutlineButton(
      onPressed: () {
        Navigator.pop(context);
      },
      text: 'ยกเลิก',
      textStyle: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
      iconColor: Colors.grey,
    ),
    IconsButton(
      onPressed: () async {
        Navigator.pop(context);
        loadingDialog(context);
        await OrderRepository().cancelOrder(trackNo: model.trackNo!, refCode: model.refCode!, courierCode: model.courierCode!).then((value) {
          if (value['status'] == true) {
            Navigator.pop(context);
            context.read<OrderlistNewBloc>().add(OrderlistNewInitialEvent());
            Fluttertoast.showToast(msg: 'ลบเรียบร้อย', gravity: ToastGravity.CENTER);
          } else {
            Navigator.pop(context);
            responseDialog(context, value['message']);
          }
        });
      },
      text: 'ลบ',
      iconData: Icons.delete,
      color: Colors.red,
      textStyle: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      iconColor: Colors.white,
    ),
  ]);
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
    title: 'กรุณารอสักครู่..',
    lottieBuilder: Lottie.asset(
      'assets/lottie/7996-rocket-fast.json',
      frameRate: FrameRate(60),
    ),
    customView: Container(),
    customViewPosition: CustomViewPosition.BEFORE_ACTION,
    context: context,
  );
}

class persistentChild extends StatelessWidget {
  const persistentChild({
    Key? key,
    required this.isSelect,
  }) : super(key: key);

  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isSelect ? 0 : 50,
      duration: Duration(milliseconds: 200),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
                flex: 6,
                child: GetTextField(
                  enableIconPrefix: true,
                  preIcon: Icons.search,
                  title: 'ค้นหาจากเลขพัสดุ ชื่อผู้รับ เบอร์โทร',
                  onChanged: (val) {
                    context.read<OrderlistNewBloc>().add(OrderlistNewSearchEvent(keywords: val));
                  },
                )),
            SizedBox(
              width: 2,
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => FilterOrderNew(),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.tune,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
