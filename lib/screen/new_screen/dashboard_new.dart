import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:perfectship_app/bloc/new_bloc/dashboard/dashboard_bloc.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import '../../widget/fontsize.dart';

class DashBoardNew extends StatefulWidget {
  const DashBoardNew({Key? key}) : super(key: key);

  @override
  State<DashBoardNew> createState() => _DashBoardNewState();
}

class _DashBoardNewState extends State<DashBoardNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return LoadingShimmer();
          } else if (state is DashboardLoaded) {
            return CustomScrollView(
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
                        'assets/image/circle_perfectship.png',
                        scale: 5,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          //launchUrl(Uri.parse('https://app-uat.iship.cloud/'));
                        },
                        child: Text(
                          'Perfect Ship',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: PlatformSize(context) * 1.3, fontWeight: FontWeight.w900, color: Colors.white),
                        ),
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
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          'สถิติการสั่งซื้อ',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildStatisticBigRow(
                            label: 'จำนวนรายการทั้งหมด',
                            value: state.dashboardNewModel.orderAll!.toString(),
                            lottie: 'assets/lottie/list.json',
                            suffix: 'รายการ',
                            color: Colors.blue.shade100,
                            sized: 35),
                        Row(
                          children: [
                            Expanded(
                                child: _buildStatisticRow(
                                    label: 'รายการที่รอการจัดส่ง',
                                    value: state.dashboardNewModel.orderWaitShipping!.toString(),
                                    color: Colors.brown.shade100,
                                    lottie: 'assets/lottie/pack.json',
                                    suffix: 'รายการ')),
                            Expanded(
                                child: _buildStatisticRow(
                                    label: 'รายการที่กำลังดำเนินการ',
                                    value: state.dashboardNewModel.orderOnProcess!.toString(),
                                    color: Colors.blueGrey.shade100,
                                    lottie: 'assets/lottie/shipping.json',
                                    suffix: 'รายการ')),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'เก็บเงินปลายทาง (COD)',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildStatisticBigRow(
                            label: 'ยอด COD ทั้งหมด',
                            value: state.dashboardNewModel.codAll!,
                            color: Colors.green.shade100,
                            lottie: 'assets/lottie/cod.json',
                            suffix: 'บาท',
                            sized: 35),
                        Row(
                          children: [
                            Expanded(
                                child: _buildStatisticRow(
                                    label: 'ยอด COD ที่รอการชำระ',
                                    value: state.dashboardNewModel.codWaiting!,
                                    color: Colors.cyan.shade100,
                                    lottie: 'assets/lottie/wait.json',
                                    suffix: 'บาท')),
                            Expanded(
                                child: _buildStatisticRow(
                                    label: 'ยอด COD ที่ชำระแล้ว',
                                    value: state.dashboardNewModel.codSuccess!,
                                    color: Colors.amber.shade100,
                                    lottie: 'assets/lottie/cod_complete.json',
                                    suffix: 'บาท')),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'สถิติอื่น ๆ',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
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
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
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
