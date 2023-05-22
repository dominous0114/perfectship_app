import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:perfectship_app/model/new_model/tracking_list_model.dart';
import 'package:perfectship_app/widget/convert_form.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import '../../../bloc/new_bloc/tracking/tracking_bloc.dart';
import '../../../widget/fontsize.dart';
import '../../../widget/status_color.dart';

class TrackingListScreen extends StatefulWidget {
  const TrackingListScreen({Key? key, required this.logo, required this.logoMobile, required this.statusColor, required this.statusText})
      : super(key: key);

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
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: PlatformSize(context) * 1.2, fontWeight: FontWeight.bold, color: Colors.white),
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
                                color: Colors.white,
                              )),
                        ],
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
                                                    decoration: BoxDecoration(
                                                        color: StatusColor().checkstatus(widget.statusColor), borderRadius: BorderRadius.circular(8)),
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
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black45, spreadRadius: 0, blurRadius: 1)],
                              ),
                              child: state.track.traceLogs!.length == 0
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
                                  : Stepper(
                                      currentStep: state.track.traceLogs!.length - 1,
                                      controlsBuilder: (context, details) {
                                        return SizedBox.shrink();
                                      },
                                      steps: List<Step>.generate(state.track.traceLogs!.length, (int index) {
                                        final TraceLogs log = state.track.traceLogs![index];
                                        final int stepNumber = state.track.traceLogs!.length - index; // Compute the step number in reverse order
                                        return Step(
                                          isActive: index == 0,
                                          state: index == 0 ? StepState.complete : StepState.disabled,
                                          title: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              //Text('$stepNumber'), // Display the step number
                                              Text(log.statusDesc!),
                                              Text(convertDateTime(dateTime: log.createdAt!)),
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
                            ),
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
