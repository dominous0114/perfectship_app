import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:perfectship_app/bloc/new_bloc/bill_list/bill_list_bloc.dart';
import 'package:perfectship_app/screen/new_screen/pdf_billlist_screen.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import '../../bloc/new_bloc/navbar/navbar_bloc.dart';
import '../../config/convert_date_time.dart';
import '../../widget/fontsize.dart';
import '../../widget/gettextfield.dart';
import '../createorder/new_widget/persis_delegate.dart';

class BillListNew extends StatefulWidget {
  const BillListNew({Key? key}) : super(key: key);

  @override
  State<BillListNew> createState() => _BillListNewState();
}

class _BillListNewState extends State<BillListNew> {
  ScrollController scrollController = ScrollController();
  Timer? _scrollTimer;

  Future<void> _refresh() async {
    print('on refersh');
    Future bloc = context.read<BillListBloc>().stream.first;
    context.read<BillListBloc>().add(BillListInitialEvent());
    await bloc;
  }

  @override
  void initState() {
    scrollController.addListener(() {
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
    });

    super.initState();
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
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<NavbarBloc, NavbarState>(
            builder: (context, state) {
              return NestedScrollView(
                  controller: scrollController,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        pinned: false,
                        toolbarHeight: 60,
                        elevation: 0,
                        title: GestureDetector(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/image/circle_perfectship.png',
                                scale: 5,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'รายการบิลล์',
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
                      ),
                    ];
                  },
                  body: BlocBuilder<BillListBloc, BillListState>(
                    builder: (context, state) {
                      if (state is BillListLoading) {
                        return LoadingShimmer();
                      } else if (state is BillListLoaded) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            await _refresh();
                          },
                          child: CustomScrollView(
                            slivers: [
                              SliverPersistentHeader(
                                pinned: true,
                                delegate: FloatingHeaderDelegate(
                                    minHeight: 50, maxHeight: 50, minChild: persistentChild(state), maxChild: persistentChild(state)),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 5,
                                ),
                              ),
                              state.billlist.length == 0
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
                                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) => PdfBillListScreen(pdfData: state.billlist[index].id.toString()),
                                                  ));
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: Colors.white,
                                                    boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 1)]),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.shade100),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.edit_note_rounded),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                          flex: 6,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text('${state.billlist[index].code!}', style: TextStyle(fontWeight: FontWeight.bold)),
                                                              Row(
                                                                children: [
                                                                  Text('ทั้งหมด : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                                                  Text('${state.billlist[index].amount!}฿', style: TextStyle()),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text('วันที่ : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                                                  Text('${convertDateTime(dateTime: state.billlist[index].updatedAt.toString())}',
                                                                      style: TextStyle()),
                                                                ],
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        );
                                      },
                                      childCount: state.billlist.length,
                                    ))
                            ],
                          ),
                        );
                      } else {
                        return Center(child: Text('มีบางอย่างผิดพลาด'));
                      }
                    },
                  ));
            },
          ),
        ),
      ),
    );
  }

  Widget persistentChild(BillListLoaded state) {
    return AnimatedContainer(
      height: 50,
      duration: Duration(milliseconds: 200),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 1)],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Row(
            children: [
              Expanded(
                  flex: 6,
                  child: GetTextField(
                    enableIconPrefix: true,
                    preIcon: Icons.search,
                    title: 'ค้นหาจากเลขบิลล์',
                    onChanged: (val) {
                      context.read<BillListBloc>().add(BillListSearchEvent(keyword: val));
                    },
                  )),
              SizedBox(
                width: 2,
              ),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      DateTimeRange? picked = await showDateRangePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendar,
                          helpText: 'เลือกวันที่หรือช่วงวันที่',
                          cancelText: 'ยกเลิก',
                          confirmText: 'ตกลง',
                          initialDateRange: DateTimeRange(start: state.startdate, end: state.enddate),
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
                          context.read<BillListBloc>().add(BillListFilterDateEvent(start: picked.start, end: picked.end));
                        });
                      }
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
                            Icons.calendar_month_rounded,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
