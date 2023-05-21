import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectship_app/model/new_model/tracking_list_model.dart';
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
                      title: Text(
                        'ติดตามสถานะ',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: PlatformSize(context) * 1.2, fontWeight: FontWeight.bold, color: Colors.white),
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
                              child: Stepper(
                                currentStep: state.track.traceLogs!.length - 1,
                                controlsBuilder: (context, details) {
                                  return SizedBox.shrink();
                                },
                                steps: List<Step>.generate(state.track.traceLogs!.length, (int index) {
                                  final TraceLogs log = state.track.traceLogs![index];
                                  return Step(
                                    isActive: index == state.track.traceLogs!.length - 1,
                                    state: index == state.track.traceLogs!.length - 1 ? StepState.complete : StepState.indexed,
                                    title: Text(log.statusDesc!),
                                    content: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Container(
                                            height: 10.0,
                                            color: index == state.track.traceLogs!.length - 1 ? Colors.green : Colors.grey,
                                          ),
                                          SizedBox(height: 8.0),
                                          Container(
                                            width: 20.0,
                                            height: 20.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: index == state.track.traceLogs!.length - 1 ? Colors.green : Colors.grey,
                                            ),
                                          ),
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
