import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:perfectship_app/bloc/new_bloc/orderlist_new/orderlist_new_bloc.dart';
import 'package:perfectship_app/model/new_model/tracking_list_model.dart';
import 'package:perfectship_app/repository/new_repository/order_reposittory.dart';
import 'package:perfectship_app/widget/convert_form.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import '../../../bloc/new_bloc/tracking/tracking_bloc.dart';
import '../../../widget/fontsize.dart';
import '../../../widget/status_color.dart';

class TrackingListScreen extends StatefulWidget {
  const TrackingListScreen({Key? key, required this.logo, required this.logoMobile, required this.statusColor, required this.statusText}) : super(key: key);

  final String logo;
  final String logoMobile;
  final String statusColor;
  final String statusText;

  @override
  State<TrackingListScreen> createState() => _TrackingListScreenState();
}

class _TrackingListScreenState extends State<TrackingListScreen> {
  int activeStep = 10;
  final List<String> trackingStatus = [
    'Waiting',
    'In Progress',
    'Shipped',
    'Out for Delivery',
    'Delivered',
  ];

  void confirmDialog(BuildContext context, String track, TrackingLoaded state) {
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
          await OrderRepository().cancelOrder(trackNo: state.track.shipping!.trackNo!, refCode: state.track.shipping!.refCode!, courierCode: state.track.shipping!.courierCode!).then((value) {
            if (value['status'] == true) {
              Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
        maintainBottomViewPadding: true,
        bottom: false,
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      floating: true,
                      pinned: true,
                      toolbarHeight: 60,
                      elevation: 0,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'ติดตามสถานะ',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontSize: PlatformSize(context) * 1.2,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                          ),
                        ],
                      ),
                      leading: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black54,
                              )),
                        ],
                      ),
                      flexibleSpace: Container(
                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 0.5,
                          )
                        ]
                            // gradient: LinearGradient(
                            //   colors: [
                            //     Color.fromARGB(200, 43, 166, 223),
                            //     Color.fromARGB(180, 41, 88, 162),
                            //   ],
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.topRight,
                            //   stops: [0.0, 0.8],
                            //   tileMode: TileMode.clamp,
                            // ),
                            ),
                      ),
                      actions: [],
                    ),
                  ],
              body: BlocBuilder<TrackingBloc, TrackingState>(
                builder: (context, state) {
                  if (state is TrackingLoading) {
                    return LoadingShimmer();
                  } else if (state is TrackingLoaded) {
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black45, spreadRadius: 0, blurRadius: 1)],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.network(
                                                  widget.logo,
                                                  height: 50,
                                                ),
                                                SizedBox()
                                              ],
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.track.shipping!.trackNo!,
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'สถานะ : ',
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(color: StatusColor().checkstatus(widget.statusColor), borderRadius: BorderRadius.circular(8)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                                      child: Text(
                                                        '${widget.statusText}',
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/pdforder', arguments: state.track.shipping!.id.toString());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.blue.shade800, blurRadius: 1)]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.print_rounded, color: Colors.blue.shade800),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'ปริ้นท์',
                                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      confirmDialog(context, state.track.shipping!.trackNo!, state);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.red.shade800, blurRadius: 1)]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.cancel, color: Colors.red.shade800),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'ยกเลิก',
                                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(color: Colors.black45, spreadRadius: 0, blurRadius: 1)],
                                ),
                                child: state.track.shipping == null
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset('assets/lottie/97670-tomato-error.json', width: 80, height: 80, repeat: false),
                                            // SizedBox(
                                            //   width: 5,
                                            // ),
                                            Text('ขออภัย ไม่สามารถติดตามสถานะพัสดุนี้ได้',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      )
                                    : state.track.traceLogs!.isEmpty
                                        ? Container(
                                            // Dummy stepper for when traceLogs is empty
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.grey,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(6.0),
                                                          child: Icon(
                                                            CupertinoIcons.cube_box_fill,
                                                            size: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text('พัสดุรอเข้าระบบ')
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            removeBottom: true,
                                            child: Stepper(
                                              // The rest of your existing Stepper code when traceLogs is not empty
                                              physics: NeverScrollableScrollPhysics(),
                                              currentStep: state.track.traceLogs!.length - 1,
                                              controlsBuilder: (context, details) {
                                                return SizedBox.shrink();
                                              },
                                              steps: List<Step>.generate(state.track.traceLogs!.length, (int index) {
                                                final TraceLogs log = state.track.traceLogs![index];
                                                final int stepNumber = state.track.traceLogs!.length - index;
                                                return Step(
                                                  isActive: index == 0,
                                                  state: index == 0 ? StepState.complete : StepState.disabled,
                                                  title: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SelectableText(log.statusDesc!),
                                                      SelectableText(log.createdAt!),
                                                    ],
                                                  ),
                                                  content: SizedBox(
                                                    width: double.infinity,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: <Widget>[
                                                        SizedBox(height: 8.0),
                                                        if (index < state.track.traceLogs!.length - 1)
                                                          Container(
                                                            height: 2.0,
                                                            color: Colors.grey,
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          )),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Text('บางอย่างผิดพลาด');
                  }
                },
              )),
        ),
      ),
    );
  }
}
