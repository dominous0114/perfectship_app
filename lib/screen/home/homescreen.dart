import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:perfectship_app/bloc/dashboard_bloc/dashboard_bloc.dart';

import 'package:perfectship_app/bloc/track_bloc/track_bloc.dart';
import 'package:perfectship_app/model/dashboard_graph_model.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/searchTrackDelegate.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import '../../model/statistics_model.dart';
import '../../repository/dashboard_repository.dart';
import '../../widget/barchart.dart';
import '../../widget/fontsize.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _endDate = DateTime.now();
  TextEditingController firstTimeController = TextEditingController();
  int _currentPage = 0;

  bool isSelected = true;

  var _pages = <Widget>[];

  List buttons = ['ยอดขนส่ง', 'ค่าขนส่ง'];
  List iconbutton = [Icons.local_shipping, Icons.attach_money_rounded];

  final _controller = PageController(initialPage: 0);

  @override
  void initState() {
    context.read<DashboardBloc>().add(DashboardInitialEvent());
    firstTimeController = TextEditingController(
        text:
            "${DateFormat('yyyy-MM-dd').format(_startDate)} -\t ${DateFormat('yyyy-MM-dd').format(_endDate)}");
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
    super.initState();
  }

  buildFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: PlatformSize(context)),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                  enabled: false,
                  hintText: 'YYYY-MM-DD',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: PlatformSize(context)),
                  prefixIcon: Icon(
                    Icons.timelapse_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  border: OutlineInputBorder()),
              controller: firstTimeController,
              onTap: () {},
            ),
          ),
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color.fromARGB(200, 43, 166, 223),
                    Color.fromARGB(180, 41, 88, 162),
                  ],
                ),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
                onPressed: () async {
                  /*final List<DateTime> picked = await DateRangePicker.showDatePicker(
                      context: context, locale: Locale("th", "TH"), initialFirstDate: _startDate, initialLastDate: _endDate, firstDate: DateTime(2020), lastDate: DateTime.now());*/
                  DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      initialEntryMode: DatePickerEntryMode.calendar,
                      helpText: 'เลือกวันที่หรือช่วงวันที่',
                      cancelText: 'ยกเลิก',
                      confirmText: 'ตกลง',
                      initialDateRange:
                          DateTimeRange(start: _startDate, end: _endDate),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
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
                      _startDate = picked.start;
                      _endDate = picked.end;
                      String formattedDate2 =
                          DateFormat('yyyy-MM-dd').format(_endDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(_startDate);
                      firstTimeController.text =
                          '$formattedDate - $formattedDate2';
                      context.read<DashboardBloc>().add(
                          FilterDateTimeGraphEvent(
                              start_date: formattedDate,
                              end_date: formattedDate2));
                    });
                  }
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  pinned: false,
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
                      Text(
                        'Perfect Ship',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: PlatformSize(context) * 1.3,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
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
                    IconButton(
                        onPressed: () {
                          context.read<TrackBloc>().add(TrackInitialEvent());
                          showSearch(
                              context: context,
                              delegate: SearchTrackDeletfate());
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ))
                  ],
                )
              ],
          body: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoading) {
                return LoadingShimmer();
              } else if (state is DashboardLoaded) {
                var statistics = [
                  Statistics(
                      name: 'รอจัดส่ง',
                      icon: Icons.compare_arrows,
                      iconColor: Colors.blue,
                      bgColor: Colors.blue,
                      total: state.statistic.waiting.toString()),
                  Statistics(
                      name: 'ส่งแล้ว',
                      icon: Icons.outbox_outlined,
                      iconColor: Colors.red,
                      bgColor: Colors.red,
                      total: state.statistic.shiped.toString()),
                  Statistics(
                      name: 'ชำระปลายทาง',
                      icon: Icons.monetization_on_outlined,
                      iconColor: Colors.green,
                      bgColor: Colors.green,
                      total: state.statistic.cod.toString()),
                ];
                List<Datas>? credits;
                List<Data>? packs;
                state.graph!.credits!.map((e) {
                  e.data;
                  credits = e.data;
                }).toList();

                state.graph!.packs!.map((e) {
                  e.data;
                  packs = e.data;
                }).toList();
                _pages = <Widget>[
                  Shipping(shipping: packs),
                  CreditLog(creditLog: credits),
                ];
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      buildFilter(context),
                      MediaQuery.removePadding(
                        context: context,
                        removeBottom: true,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.transparent,
                              ),
                              height: MediaQuery.of(context).size.height * 0.48,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: PageView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  controller: _controller,
                                  children: _pages,
                                ),
                              ),
                            ),
                            Positioned(
                                right: -10,
                                child: IconButton(
                                  onPressed: () {
                                    _controller.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.linear);
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Colors.grey,
                                  ),
                                )),
                            Positioned(
                                left: -10,
                                child: IconButton(
                                  onPressed: () {
                                    _controller.previousPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_sharp,
                                    color: Colors.grey,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MediaQuery.removePadding(
                            context: context,
                            removeBottom: true,
                            child: Card(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: .7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: buttons.length,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (_currentPage == index) {
                                              // _controller.animateToPage(_currentPage, duration: Duration(milliseconds: 500), curve: (_currentPage - 1) % 3 != 0 ?  Curves.easeIn : Curves.easeIn);
                                            } else {
                                              _controller.animateToPage(
                                                  (_currentPage - 1) % 3,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve:
                                                      (_currentPage - 1) % 3 !=
                                                              1
                                                          ? Curves.easeIn
                                                          : Curves.easeIn);
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: _currentPage == index
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Theme.of(context)
                                                        .appBarTheme
                                                        .backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 70,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    iconbutton[index],
                                                    color: _currentPage == index
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${buttons[index]}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize:
                                                              PlatformSize(
                                                                  context),
                                                          color: _currentPage ==
                                                                  index
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Color.fromARGB(200, 43, 166, 223),
                              Color.fromARGB(180, 41, 88, 162),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   height: 45,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.graphic_eq,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Statistics',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize:
                                                      PlatformSize(context) *
                                                          1.2,
                                                  color: Colors.white)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.80,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            statistics[0]
                                                                .bgColor
                                                                .withOpacity(
                                                                    .2),
                                                        child: Icon(
                                                          statistics[0].icon,
                                                          color: statistics[0]
                                                              .iconColor,
                                                        )),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      statistics[0].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize:
                                                                  PlatformSize(
                                                                          context) *
                                                                      .9),
                                                    ),
                                                    SizedBox(height: 10),
                                                    statistics[0].name ==
                                                            'ชำระปลายทาง'
                                                        ? Text(
                                                            '${statistics[0].total} บาท',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        PlatformSize(context) *
                                                                            .9),
                                                          )
                                                        : Text(
                                                            statistics[0].total,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        PlatformSize(context) *
                                                                            .9),
                                                          ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            statistics[1]
                                                                .bgColor
                                                                .withOpacity(
                                                                    .2),
                                                        child: Icon(
                                                          statistics[1].icon,
                                                          color: statistics[1]
                                                              .iconColor,
                                                        )),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      statistics[1].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize:
                                                                  PlatformSize(
                                                                          context) *
                                                                      .9),
                                                    ),
                                                    SizedBox(height: 10),
                                                    statistics[1].name ==
                                                            'ชำระปลายทาง'
                                                        ? Text(
                                                            '${statistics[1].total} บาท',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        PlatformSize(context) *
                                                                            .9),
                                                          )
                                                        : Text(
                                                            statistics[1].total,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        PlatformSize(context) *
                                                                            .9),
                                                          ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            statistics[2]
                                                                .bgColor
                                                                .withOpacity(
                                                                    .2),
                                                        child: Icon(
                                                          statistics[2].icon,
                                                          color: statistics[2]
                                                              .iconColor,
                                                        )),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      statistics[2].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize:
                                                                  PlatformSize(
                                                                          context) *
                                                                      .9),
                                                    ),
                                                    SizedBox(height: 10),
                                                    statistics[2].name ==
                                                            'ชำระปลายทาง'
                                                        ? Text(
                                                            '${statistics[2].total} บาท',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        PlatformSize(context) *
                                                                            .9),
                                                          )
                                                        : Text(
                                                            statistics[1].total,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        PlatformSize(context) *
                                                                            .9),
                                                          ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            // child: ListView.builder(
                                            //     shrinkWrap: true,
                                            //     physics:
                                            //         AlwaysScrollableScrollPhysics(),
                                            //     scrollDirection:
                                            //         Axis.horizontal,
                                            //     itemCount: statistics.length,
                                            //     itemBuilder:
                                            //         (BuildContext ctx, index) {
                                            //       return GestureDetector(
                                            //           onTap: () {
                                            //             DashboardRepository()
                                            //                 .getTopProvince();
                                            //           },
                                            // child: Container(
                                            //   margin:
                                            //       EdgeInsets.all(0),
                                            //   decoration:
                                            //       BoxDecoration(
                                            //     color: Colors.white,
                                            //     borderRadius:
                                            //         BorderRadius
                                            //             .circular(16),
                                            //   ),
                                            //             alignment:
                                            //                 Alignment.center,
                                            //             child: Column(
                                            //               mainAxisAlignment:
                                            //                   MainAxisAlignment
                                            //                       .center,
                                            //               children: [
                                            //                 Padding(
                                            //                   padding: const EdgeInsets
                                            //                           .symmetric(
                                            //                       horizontal:
                                            //                           10.0),
                                            //                   child: Row(
                                            //                     children: [
                                            //                       Column(
                                            //                         mainAxisAlignment:
                                            //                             MainAxisAlignment
                                            //                                 .start,
                                            //                         crossAxisAlignment:
                                            //                             CrossAxisAlignment
                                            //                                 .center,
                                            //                         children: [
                                            // CircleAvatar(
                                            //     backgroundColor: statistics[index].bgColor.withOpacity(
                                            //         .2),
                                            //     child:
                                            //         Icon(
                                            //       statistics[index].icon,
                                            //       color:
                                            //           statistics[index].iconColor,
                                            //     )),
                                            // SizedBox(
                                            //     width:
                                            //         10),
                                            // Text(
                                            //   statistics[index]
                                            //       .name,
                                            //   style: Theme.of(context)
                                            //       .textTheme
                                            //       .bodyText1!
                                            //       .copyWith(fontSize: PlatformSize(context) * .9),
                                            // ),
                                            // SizedBox(
                                            //     width:
                                            //         10),
                                            // statistics[index].name ==
                                            //         'ชำระปลายทาง'
                                            //     ? Text(
                                            //         '${statistics[index].total} บาท',
                                            //         style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: PlatformSize(context) * .9),
                                            //       )
                                            //     : Text(
                                            //         statistics[index].total,
                                            //         style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: PlatformSize(context) * .9),
                                            //       ),
                                            //                         ],
                                            //                       ),
                                            //                     ],
                                            //                   ),
                                            //                 ),
                                            //               ],
                                            //             ),
                                            //           ));
                                            //     }),
                                          ),
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.auto_graph),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('10 จังหวัดส่งของมากที่สุด',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontSize: PlatformSize(
                                                                context) *
                                                            1.2)),
                                          ],
                                        ),
                                        // ListView.builder(
                                        //   shrinkWrap: true,
                                        //   itemCount: state.provinceRanking!.data!.length,
                                        //   itemBuilder: (BuildContext context, int index) {
                                        //     return Column(
                                        //       mainAxisAlignment: MainAxisAlignment.start,
                                        //       children: [
                                        //         Text(index.toString()),
                                        //       ],
                                        //     );
                                        //   },
                                        // ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.56,
                                          child: SingleChildScrollView(
                                            child: SafeArea(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: state.provinceModel!
                                                    .map((e) {
                                                  var index = state
                                                      .provinceModel!
                                                      .indexOf(e);
                                                  return Column(
                                                    children: [
                                                      ListTile(
                                                        // iconColor: Colors.pink,
                                                        // textColor: Colors.amber,
                                                        // tileColor: Colors.green,
                                                        // focusColor:
                                                        //     Colors.brown,
                                                        // hoverColor:
                                                        //     Colors.purple,
                                                        // splashColor:
                                                        //     Colors.cyan,
                                                        // selectedColor:
                                                        //     Colors.brown,
                                                        // selectedTileColor:
                                                        //     Colors.grey,
                                                        leading: Text(
                                                          '${index + 1}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                        ),
                                                        title: Text(
                                                          '${e.dstProvince!}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                        ),
                                                        trailing: Text(
                                                          '${e.totalPack!.toString()} รายการ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                        ),
                                                      ),
                                                      Divider()
                                                    ],
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
