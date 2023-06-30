import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:perfectship_app/bloc/new_bloc/dashboard/dashboard_bloc.dart';
import 'package:perfectship_app/model/statistics_model.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/new_model/dashboard_new_model.dart';
import '../../widget/fontsize.dart';

class DashBoardNew extends StatefulWidget {
  const DashBoardNew({Key? key}) : super(key: key);

  @override
  State<DashBoardNew> createState() => _DashBoardNewState();
}

final List<ChartData> chartData = [ChartData('David', 25), ChartData('Steve', 38), ChartData('Jack', 34), ChartData('Others', 52)];

class _DashBoardNewState extends State<DashBoardNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return LoadingShimmer();
          } else if (state is DashboardLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(DashboardInitialEvent());
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    pinned: true,
                    toolbarHeight: 60,
                    elevation: 0,
                    title: Row(
                      children: [
                        Image.asset(
                          'assets/image/DplusExpress-04.png',
                          scale: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            //launchUrl(Uri.parse('https://app-uat.iship.cloud/'));
                          },
                          child: Text('DPlus Express',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              )),
                        )
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
                    actions: [
                      IconButton(
                          onPressed: () async {
                            DateTimeRange? picked = await showDateRangePicker(
                                context: context,
                                initialEntryMode: DatePickerEntryMode.calendar,
                                helpText: 'เลือกวันที่หรือช่วงวันที่',
                                cancelText: 'ยกเลิก',
                                confirmText: 'ตกลง',
                                initialDateRange: DateTimeRange(start: state.startDate, end: state.endDate),
                                firstDate: DateTime(2020),
                                // the earliest allowable
                                lastDate: DateTime.now(),
                                // the latest allowable
                                // currentDate: DateTime.now(),
                                saveText: 'เสร็จ',
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData(
                                      backgroundColor: Color(0xFF009CDB),
                                    ),
                                    child: child!,
                                  );
                                });
                            if (picked != null) {
                              setState(() {
                                context.read<DashboardBloc>().add(DashboardfilterEvent(startDate: picked.start, endDate: picked.end));
                              });
                            }
                          },
                          icon: Icon(Icons.calendar_today_outlined))
                      // IconButton(
                      //     onPressed: () async {},
                      //     icon: Icon(
                      //       Icons.notifications_active,
                      //       color: Colors.white,
                      //     )),
                      // IconButton(
                      //     onPressed: () {
                      //       // context.read<TrackBloc>().add(TrackInitialEvent());
                      //       // context.read<TrackBloc>().add(
                      //       //     TrackSearchHomeEvent(keyword: '', start: '2021-01-01', end: initend, courier: 'all', printing: 'all', order: 'all'));
                      //       // showSearch(context: context, delegate: SearchTrackDeletfate());
                      //     },
                      //     icon: Icon(
                      //       Icons.search,
                      //       color: Colors.white,
                      //     ))
                    ],
                  ),

                  // SliverPadding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   sliver: SliverList(
                  //     delegate: SliverChildListDelegate(
                  //       [
                  //         Text(
                  //           'สถิติการสั่งซื้อ',
                  //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  //         ),
                  //         SizedBox(height: 8),
                  //         _buildStatisticBigRow(
                  //             label: 'จำนวนรายการทั้งหมด',
                  //             value: state.dashboardNewModel.orderAll!.toString(),
                  //             lottie: 'assets/lottie/list.json',
                  //             suffix: 'รายการ',
                  //             color: Colors.blue.shade100,
                  //             sized: 35),
                  //         Row(
                  //           children: [
                  //             Expanded(
                  //                 child: _buildStatisticRow(
                  //                     label: 'รายการที่รอการจัดส่ง',
                  //                     value: state.dashboardNewModel.orderWaitShipping!.toString(),
                  //                     color: Colors.brown.shade100,
                  //                     lottie: 'assets/lottie/pack.json',
                  //                     suffix: 'รายการ')),
                  //             Expanded(
                  //                 child: _buildStatisticRow(
                  //                     label: 'รายการที่กำลังดำเนินการ',
                  //                     value: state.dashboardNewModel.orderOnProcess!.toString(),
                  //                     color: Colors.blueGrey.shade100,
                  //                     lottie: 'assets/lottie/shipping.json',
                  //                     suffix: 'รายการ')),
                  //           ],
                  //         ),
                  //         SizedBox(height: 16),
                  //         Text(
                  //           'เก็บเงินปลายทาง (COD)',
                  //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  //         ),
                  //         SizedBox(height: 8),
                  // _buildStatisticBigRow(
                  //     label: 'ยอด COD ทั้งหมด',
                  //     value: state.dashboardNewModel.codAll!,
                  //     color: Colors.green.shade100,
                  //     lottie: 'assets/lottie/cod.json',
                  //     suffix: 'บาท',
                  //     sized: 35),
                  //         Row(
                  //           children: [
                  //             Expanded(
                  //                 child: _buildStatisticRow(
                  //                     label: 'ยอด COD ที่รอการชำระ',
                  //                     value: state.dashboardNewModel.codWaiting!,
                  //                     color: Colors.cyan.shade100,
                  //                     lottie: 'assets/lottie/wait.json',
                  //                     suffix: 'บาท')),
                  //             Expanded(
                  //                 child: _buildStatisticRow(
                  //                     label: 'ยอด COD ที่ชำระแล้ว',
                  //                     value: state.dashboardNewModel.codSuccess!,
                  //                     color: Colors.amber.shade100,
                  //                     lottie: 'assets/lottie/cod_complete.json',
                  //                     suffix: 'บาท')),
                  //           ],
                  //         ),
                  //         SizedBox(height: 8),
                  //         Text(
                  //           'สถิติอื่น ๆ',
                  //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  //         ),
                  //         SizedBox(height: 8),
                  //     Row(
                  //       children: [
                  //         Expanded(
                  //           child: _buildStatisticRow(
                  //               label: 'รายการที่สำเร็จ',
                  //               value: state.dashboardNewModel.successOrder!.toString(),
                  //               color: Colors.green.shade200,
                  //               lottie: 'assets/lottie/78295-correct.json',
                  //               //sized: 35,
                  //               suffix: 'รายการ'),
                  //         ),
                  //         Expanded(
                  //           child: _buildStatisticRow(
                  //             label: 'รายการที่ยกเลิก',
                  //             value: state.dashboardNewModel.cancelOrder!.toString(),
                  //             color: Colors.red.shade200,
                  //             lottie: 'assets/lottie/97670-tomato-error.json',
                  //             suffix: 'รายการ',
                  //             //sized: 35
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: 80),
                  //   ],
                  // ),
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildStatisticRow(
                                label: 'รายการที่สำเร็จ',
                                value: state.dashboardNewModel.successOrder!.toString(),
                                color: Colors.green.shade200,
                                lottie: 'assets/lottie/78295-correct.json',
                                //sized: 35,
                                suffix: 'รายการ'),
                          ),
                          Expanded(
                            child: _buildStatisticRow(
                              label: 'รายการที่ยกเลิก',
                              value: state.dashboardNewModel.cancelOrder!.toString(),
                              color: Colors.red.shade200,
                              lottie: 'assets/lottie/97670-tomato-error.json',
                              suffix: 'รายการ',
                              //sized: 35
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [BoxShadow(color: Colors.blue.shade700, blurRadius: 1)]),
                      padding: EdgeInsets.zero,
                      height: 200,
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: state.dashboardNewModel.codAll == "0.00"
                                  ? Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade300,
                                        ),
                                        child: Center(
                                            child: Text(
                                          'ไม่มีรายการ COD',
                                          style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    )
                                  : SfCircularChart(
                                      margin: EdgeInsets.all(0),
                                      series: <CircularSeries>[
                                        PieSeries<ChartData, String>(
                                          dataSource: <ChartData>[
                                            ChartData('ยอด COD ที่รอการชำระ', double.parse(state.dashboardNewModel.codWaiting ?? '0')),
                                            ChartData('ยอด COD ที่ชำระแล้ว', double.parse(state.dashboardNewModel.codSuccess ?? '0')),
                                          ],
                                          xValueMapper: (ChartData data, _) => data.category,
                                          yValueMapper: (ChartData data, _) => data.value,
                                          pointColorMapper: (ChartData data, _) => data.category == 'ยอด COD ที่รอการชำระ'
                                              ? Colors.red.shade500
                                              : data.category == 'ยอด COD ที่ชำระแล้ว'
                                                  ? Colors.green.shade500
                                                  : Colors.grey.shade500,
                                          dataLabelMapper: (ChartData data, _) => '${data.value} บาท',
                                          groupMode: CircularChartGroupMode.point,
                                          dataLabelSettings: DataLabelSettings(
                                            textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                            showZeroValue: false,
                                            showCumulativeValues: true,
                                            isVisible: true,

                                            labelIntersectAction: LabelIntersectAction.hide, // Hide overlapping labels
                                            // Render labels inside the doughnut
                                            labelAlignment: ChartDataLabelAlignment.top, // Set label alignment to top
                                            // Use series color for data labels
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.amber.shade400,
                                                ),
                                                child: Icon(
                                                  Icons.monetization_on,
                                                  color: Colors.amber.shade700,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ยอด COD ทั้งหมด',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                ),
                                                Text(
                                                  '${state.dashboardNewModel.codAll!} ฿',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red.shade900,
                                                ),
                                                child: Icon(
                                                  Icons.timer,
                                                  color: Colors.red.shade200,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ยอด COD ที่รอการชำระ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                ),
                                                Text(
                                                  '${state.dashboardNewModel.codWaiting!} ฿',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green.shade900,
                                                ),
                                                child: Icon(
                                                  Icons.check_circle_outline_rounded,
                                                  color: Colors.green.shade200,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ยอด COD ที่ชำระแล้ว',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                ),
                                                Text(
                                                  '${state.dashboardNewModel.codSuccess!} ฿',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  )),
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 270,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [BoxShadow(color: Colors.blue.shade700, blurRadius: 1)]),
                      padding: EdgeInsets.zero,
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.orange.shade400,
                                                ),
                                                child: Icon(
                                                  CupertinoIcons.cube_box,
                                                  color: Colors.orange.shade700,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'รายการทั้งหมด',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                ),
                                                Text(
                                                  '${state.dashboardNewModel.orderAll!} รายการ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.orange.shade900,
                                                ),
                                                child: Icon(
                                                  Icons.timer,
                                                  color: Colors.orange.shade200,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'รายการที่รอการจัดส่ง',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                ),
                                                Text(
                                                  '${state.dashboardNewModel.orderWaitShipping!} รายการ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.cyan.shade900,
                                                ),
                                                child: Icon(
                                                  CupertinoIcons.cube,
                                                  color: Colors.cyan.shade200,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'รายการที่กำลังดำเนินการ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                ),
                                                Text(
                                                  '${state.dashboardNewModel.orderOnProcess!} รายการ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green.shade900,
                                                ),
                                                child: Icon(
                                                  Icons.check_circle_outline_rounded,
                                                  color: Colors.green.shade200,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'รายการที่สำเร็จ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                ),
                                                Text(
                                                  '${state.dashboardNewModel.successOrder!} รายการ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red.shade900,
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.red.shade200,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'รายการที่ยกเลิก',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                ),
                                                Text(
                                                  '${state.dashboardNewModel.cancelOrder!} รายการ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            Expanded(
                              flex: 4,
                              child: state.dashboardNewModel.orderAll == 0
                                  ? Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade300,
                                        ),
                                        child: Center(
                                            child: Text(
                                          'ไม่มีรายการ',
                                          style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    )
                                  : SfCircularChart(
                                      margin: EdgeInsets.all(0),
                                      series: <CircularSeries>[
                                        PieSeries<ChartData, String>(
                                          dataSource: <ChartData>[
                                            ChartData('รายการที่รอการจัดส่ง', state.dashboardNewModel.orderWaitShipping ?? 0),
                                            ChartData('รายการที่กำลังดำเนินการ', state.dashboardNewModel.orderOnProcess ?? 0),
                                            ChartData('รายการที่สำเร็จ', state.dashboardNewModel.successOrder ?? 0),
                                            ChartData('รายการที่ยกเลิก', state.dashboardNewModel.cancelOrder ?? 0),
                                          ],
                                          xValueMapper: (ChartData data, _) => data.category,
                                          yValueMapper: (ChartData data, _) => data.value,
                                          pointColorMapper: (ChartData data, _) => data.category == 'รายการที่รอการจัดส่ง'
                                              ? Colors.orange.shade700
                                              : data.category == 'รายการที่กำลังดำเนินการ'
                                                  ? Colors.cyan.shade300
                                                  : data.category == 'รายการที่สำเร็จ'
                                                      ? Colors.green.shade400
                                                      : Colors.red.shade400,
                                          dataLabelMapper: (ChartData data, _) => '${data.value}',
                                          groupMode: CircularChartGroupMode.point,
                                          dataLabelSettings: DataLabelSettings(
                                            textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                                            showZeroValue: false,
                                            showCumulativeValues: true,
                                            isVisible: true,

                                            labelIntersectAction: LabelIntersectAction.hide, // Hide overlapping labels
                                            // Render labels inside the doughnut
                                            labelAlignment: ChartDataLabelAlignment.top, // Set label alignment to top
                                            // Use series color for data labels
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 100,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(child: Text('มีบางอย่างผิดพลาด'));
          }
        },
      ),
    );
  }

  Widget _buildStatisticRow({required String label, required String value, required String lottie, required Color color, required String suffix}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Lottie.asset(lottie, width: 40, height: 40),
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${value} ${suffix}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticBigRow(
      {required String label, required String value, required String suffix, required String lottie, required Color color, required double sized}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                    child: Padding(padding: const EdgeInsets.all(8.0), child: Lottie.asset(lottie, height: sized, width: sized, repeat: false))),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${value} ${suffix}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String category;
  final num value;

  ChartData(this.category, this.value);
}
