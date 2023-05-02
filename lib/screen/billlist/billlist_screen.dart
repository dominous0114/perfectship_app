import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:perfectship_app/bloc/bill_bloc/bill_bloc.dart';
import 'package:perfectship_app/repository/bill_repository.dart';
import 'package:perfectship_app/widget/allkey.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import '../../widget/fontsize.dart';

class BillListScreen extends StatefulWidget {
  const BillListScreen({Key? key}) : super(key: key);

  @override
  State<BillListScreen> createState() => _BillListScreenState();
}

class _BillListScreenState extends State<BillListScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;
  TextEditingController textController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String lid = '';
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late NavigatorState _navigator;
  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying ? _animationController.forward() : _animationController.reverse();
      print(isPlaying);
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
                          boxShadow: [BoxShadow(offset: Offset.zero, spreadRadius: .3, color: Colors.grey)]),
                      child: TextFormField(
                        style: TextStyle(fontSize: PlatformSize(context)),
                        cursorColor: Colors.blue.shade300,
                        controller: textController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        focusNode: searchFocusNode,
                        onChanged: (keyword) async {
                          if (textController.text == '') {
                            context.read<BillBloc>().add(BillInitialEvent());
                          } else {
                            String formattedDate2 = DateFormat('yyyy-MM-dd').format(_endDate);
                            String formattedDate = DateFormat('yyyy-MM-dd').format(_startDate);
                            context.read<BillBloc>().add(BillFilterSearchEvent(keyword: keyword, end: formattedDate2, start: formattedDate));
                          }
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
                                context.read<BillBloc>().add(BillInitialEvent());
                                setState(() {
                                  textController.clear();
                                  searchFocusNode.unfocus();
                                });
                              },
                              child: Text(
                                'ล้าง',
                                style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.blue.shade300, fontSize: PlatformSize(context)),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'ค้นหา',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: PlatformSize(context))),
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
                                .copyWith(fontSize: PlatformSize(context) * 1.2, fontWeight: FontWeight.bold, color: Colors.black),
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
                      boxShadow: [BoxShadow(offset: Offset.zero, spreadRadius: .3, color: Colors.grey)]),
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
              onTap: () async {
                DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    initialEntryMode: DatePickerEntryMode.calendar,
                    helpText: 'เลือกวันที่หรือช่วงวันที่',
                    cancelText: 'ยกเลิก',
                    confirmText: 'ตกลง',
                    initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
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
                    _startDate = picked.start;
                    _endDate = picked.end;

                    String formattedDate2 = DateFormat('yyyy-MM-dd').format(_endDate);
                    String formattedDate = DateFormat('yyyy-MM-dd').format(_startDate);
                    print('forend = $formattedDate2');
                    context.read<BillBloc>().add(BillFilterDateEvent(start: formattedDate, end: formattedDate2));
                    //firstTimeController.text = '${formattedDate} - $formattedDate2';
                  });
                }
              },
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[
                        Color.fromARGB(200, 43, 166, 223),
                        Color.fromARGB(180, 41, 88, 162),
                      ]),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(offset: Offset.zero, spreadRadius: .3, color: Colors.grey)]),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.calendar,
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
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    context.read<BillBloc>().add(BillInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
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
          key: scaffoldKey,
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      floating: true,
                      snap: false,
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
                            'รายการบิล',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: PlatformSize(context) * 1.2, fontWeight: FontWeight.bold, color: Colors.white),
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
                    )
                  ],
              body: BlocBuilder<BillBloc, BillState>(
                builder: (context, state) {
                  if (state is BillLoading) {
                    return LoadingShimmer();
                  } else if (state is BillLoaded) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black)]),
                          child: buildSearch(context, state.billmodel.length),
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await Future.delayed(Duration(milliseconds: 1000), () {
                                _startDate = DateTime.now().subtract(Duration(days: 30));
                                _endDate = DateTime.now();
                                context.read<BillBloc>().add(BillInitialEvent());
                              });
                            },
                            child: ListView.builder(
                              controller: Allkey.billScrollController,
                              //physics: NeverScrollableScrollPhysics(),
                              itemCount: state.billmodel.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                  child: Slidable(
                                    enabled: state.billmodel[index].isPrint == 1 ? true : false,
                                    endActionPane: ActionPane(extentRatio: 1, motion: DrawerMotion(), children: [
                                      SlidableAction(
                                        onPressed: (context) async {
                                          await BillRepository().getBillDetail(state.billmodel[index].id.toString()).then((value) async {
                                            var enval = value.map((e) => e.orderId.toString());
                                            String enval2 = enval.toString();
                                            final removefirst = enval2.replaceAll('(', '');
                                            final removelast = removefirst.replaceAll(')', '');
                                            setState(() {
                                              lid = removelast;
                                              print('lid = $lid');
                                            });
                                            Navigator.pushNamed(scaffoldKey.currentContext!, '/pdforder', arguments: lid);
                                          });
                                        },
                                        label: 'ใบเสร็จ',
                                        icon: CupertinoIcons.printer,
                                        foregroundColor: Color.fromARGB(200, 43, 166, 223),
                                        backgroundColor: Colors.white,
                                      ),
                                      SlidableAction(
                                        onPressed: (context) async {
                                          await BillRepository().getBillDetail(state.billmodel[index].id.toString()).then((value) async {
                                            var enval = value.map((e) => e.orderId.toString());
                                            String enval2 = enval.toString();
                                            final removefirst = enval2.replaceAll('(', '');
                                            final removelast = removefirst.replaceAll(')', '');
                                            setState(() {
                                              lid = removelast;
                                              print('lid = $lid');
                                            });
                                            Navigator.pushNamed(scaffoldKey.currentContext!, '/pdfbill', arguments: lid);
                                          });
                                        },
                                        label: 'ใบปะหน้า',
                                        icon: CupertinoIcons.printer_fill,
                                        foregroundColor: Color.fromARGB(180, 41, 88, 162),
                                        backgroundColor: Colors.white,
                                      ),
                                    ]),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/billdetail',
                                            arguments: [state.billmodel[index].id.toString(), state.billmodel[index].code.toString()]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [BoxShadow(blurRadius: 1, color: Colors.grey)],
                                            borderRadius: BorderRadius.all(Radius.circular(5))),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(200, 43, 166, 223),
                                                      Color.fromARGB(180, 41, 88, 162),
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
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons.receipt,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          // '${state.addressmodel[index].name}',
                                                          '# ${state.billmodel[index].code}',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: PlatformSize(context) * 1.1,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
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
                                                        'วันที่สร้าง : ',
                                                        style: TextStyle(fontSize: PlatformSize(context), fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        // ' ${state.addressmodel[index].phone}',
                                                        DateFormat.yMd('th').add_jms().format(DateTime.parse('${state.billmodel[index].created}')),
                                                        style: TextStyle(fontSize: PlatformSize(context), fontWeight: FontWeight.normal),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'ชื่อลูกค้า : ',
                                                        style: TextStyle(fontSize: PlatformSize(context), fontWeight: FontWeight.bold),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${state.billmodel[index].customerName}',
                                                          style: TextStyle(fontSize: PlatformSize(context), fontWeight: FontWeight.normal),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'เบอร์โทร : ',
                                                        style: TextStyle(fontSize: PlatformSize(context), fontWeight: FontWeight.bold),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${state.billmodel[index].customerPhone}',
                                                          style: TextStyle(fontSize: PlatformSize(context), fontWeight: FontWeight.normal),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'ราคา : ',
                                                        style: TextStyle(fontSize: PlatformSize(context), fontWeight: FontWeight.bold),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${state.billmodel[index].totalAmount}',
                                                          style: TextStyle(fontSize: PlatformSize(context), fontWeight: FontWeight.normal),
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
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              )),
        ),
      ),
    );
  }
}
