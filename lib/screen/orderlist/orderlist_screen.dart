import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perfectship_app/bloc/track_bloc/track_bloc.dart';
import 'package:perfectship_app/repository/track_repository.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';
import 'package:intl/intl.dart';

import '../../config/convert_date_time.dart';
import '../../model/printstatus_model.dart';
import '../../widget/fontsize.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isSelect = false;
  bool _isSelectAll = false;

  bool isPlaying = false;
  TextEditingController textController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  TextEditingController firstTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  DateTime _startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime _endDate = DateTime.now();
  Printed? _printed;
  List<Printed>? listprint;

  List _selectedItems = [];

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
      print(isPlaying);
    });
  }

  _onSelectFilterStatusPrint(Printed printed) {
    setState(() {
      _printed = printed;
    });
  }

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  buildSearch(BuildContext context, int total, TrackLoaded state) {
    return _isSelect == true
        ? Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: Offset.zero,
                  spreadRadius: .2,
                  color: Colors.grey.shade400)
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Color.fromARGB(180, 41, 88, 162),
                                          Color.fromARGB(200, 43, 166, 223),
                                        ]),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset.zero,
                                          spreadRadius: .3,
                                          color: Colors.grey)
                                    ]),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.printer,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'ปริ้นท์  ${_selectedItems.length} รายการ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontSize:
                                                  PlatformSize(context) * 1.1,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                    )
                                  ],
                                ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSelect = !_isSelect;
                        if (_isSelect == false) {
                          _isSelectAll = false;
                          _selectedItems.clear();
                        }
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Color.fromARGB(200, 43, 166, 223),
                                  Color.fromARGB(180, 41, 88, 162),
                                ]),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset.zero,
                                  spreadRadius: .3,
                                  color: Colors.grey)
                            ]),
                        child: Center(
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: Offset.zero,
                  spreadRadius: .2,
                  color: Colors.grey.shade400)
            ]),
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
                              cursorColor: Colors.blue,
                              controller: textController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              focusNode: searchFocusNode,
                              onChanged: (keyword) async {
                                if (keyword == '') {
                                  context.read<TrackBloc>().add(
                                      TrackFilterEvent(
                                          start: DateFormat('yyyy-MM-dd')
                                              .format(_startDate),
                                          end: DateFormat('yyyy-MM-dd')
                                              .format(_endDate),
                                          courier: state.courierSelected.code
                                              .toString(),
                                          printing: _printed!.id,
                                          order: state.statusSelected.id
                                              .toString()));
                                } else {
                                  context.read<TrackBloc>().add(
                                      TrackSearchEvent(
                                          keyword: keyword,
                                          start: DateFormat('yyyy-MM-dd')
                                              .format(_startDate),
                                          end: DateFormat('yyyy-MM-dd')
                                              .format(_endDate),
                                          courier: state.courierSelected.code
                                              .toString(),
                                          printing: _printed!.id,
                                          order: state.statusSelected.id
                                              .toString()));
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.blue,
                                  iconColor: Colors.blue,
                                  focusColor: Colors.blue,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 1),
                                  prefixIcon: Icon(
                                    Icons.search,
                                  ),
                                  suffix: TextButton(
                                    onPressed: () {
                                      textController.clear();
                                      searchFocusNode.unfocus();
                                      context.read<TrackBloc>().add(
                                          TrackFilterEvent(
                                              start: DateFormat('yyyy-MM-dd')
                                                  .format(_startDate),
                                              end: DateFormat('yyyy-MM-dd')
                                                  .format(_endDate),
                                              courier: state
                                                  .courierSelected.code
                                                  .toString(),
                                              printing: _printed!.id,
                                              order: state.statusSelected.id
                                                  .toString()));
                                    },
                                    child: Text(
                                      'ล้าง',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              color: Colors.blue,
                                              fontSize: PlatformSize(context)),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'ค้นหา',
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
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
                  isPlaying
                      ? GestureDetector(
                          onTap: () {
                            buildShowModalBottomSheet(context);
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        Color.fromARGB(200, 43, 166, 223),
                                        Color.fromARGB(180, 41, 88, 162),
                                      ]),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset.zero,
                                        spreadRadius: .3,
                                        color: Colors.grey)
                                  ]),
                              child: Center(
                                child: Icon(
                                  Icons.tune_outlined,
                                  color: Colors.white,
                                ),
                              )),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSelect = !_isSelect;
                            });
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        Color.fromARGB(180, 41, 88, 162),
                                        Color.fromARGB(200, 43, 166, 223),
                                      ]),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset.zero,
                                        spreadRadius: .3,
                                        color: Colors.grey)
                                  ]),
                              child: Center(
                                child: Icon(
                                  Icons.checklist_sharp,
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
    _printed = Printed.printed.first;

    print(_startDate.toString());
    print(_endDate.toString());
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    context.read<TrackBloc>().add(TrackInitialEvent());
    firstTimeController = TextEditingController(
        text:
            "${DateFormat('yyyy-MM-dd').format(_startDate)} -\t ${DateFormat('yyyy-MM-dd').format(_endDate)}");
    super.initState();
  }

  void _showAlertDelete(
      BuildContext context, String orderid, String courier, String refcode) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return BlocBuilder<TrackBloc, TrackState>(
              builder: (context, state) {
                if (state is TrackLoading) {
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
                } else if (state is TrackLoaded) {
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
                          context.read<TrackBloc>().add(DeleteTrackEvent(
                              keyword: textController.text,
                              start:
                                  DateFormat('yyyy-MM-dd').format(_startDate),
                              end: DateFormat('yyyy-MM-dd').format(_endDate),
                              courier: state.courierSelected.code.toString(),
                              printing: _printed!.id,
                              order: state.statusSelected.id.toString(),
                              context: context,
                              courier_code: courier,
                              refcode: refcode,
                              id: orderid));
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

  Container filterHeader(BuildContext context, StateSetter setState) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromARGB(200, 43, 166, 223),
              Color.fromARGB(180, 41, 88, 162),
            ]),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        FontAwesomeIcons.close,
                        color: Theme.of(context).iconTheme.color,
                      )),
                  backgroundColor: Colors.white60,
                ),
                Text(
                  'กรองข้อมูล',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: PlatformSize(context) * 1.2,
                      color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TrackBloc>().add(TrackInitialEvent());
                    context.read<TrackBloc>().add(ResetFilterEvent());
                    setState(() {
                      _startDate = DateTime(
                          DateTime.now().year, DateTime.now().month, 1);
                      _endDate = DateTime.now();
                      firstTimeController = TextEditingController(
                          text:
                              "${DateFormat('yyyy-MM-dd').format(_startDate)} -\t ${DateFormat('yyyy-MM-dd').format(_endDate)}");
                      //searchFocusNode = FocusNode();
                      _printed = Printed.printed.first;
                      print('printed = ${_printed!.statusName}');

                      //context.read<FilterOrderBloc>().add(FilterOrderInitialEvent());
                    });
                  },
                  child: Text(
                    'รีเซ็ท',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: PlatformSize(context),
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding _shippingHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_shipping,
                color: Theme.of(context).iconTheme.color,
              ),
              Text(
                '   ขนส่ง',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: PlatformSize(context)),
              ),
            ],
          ),
          Icon(Icons.keyboard_double_arrow_right_rounded,
              size: 20, color: Color.fromARGB(180, 41, 88, 162))
        ],
      ),
    );
  }

  _filterDateTime(BuildContext context, StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                  hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.grey, fontSize: PlatformSize(context)),
                  prefixIcon: Icon(
                    Icons.timelapse_rounded,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              controller: firstTimeController,
              onTap: () {},
            ),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () async {
              DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  initialEntryMode: DatePickerEntryMode.calendar,
                  helpText: 'เลือกวันที่หรือช่วงวันที่',
                  cancelText: 'ยกเลิก',
                  confirmText: 'ตกลง',
                  initialDateRange:
                      DateTimeRange(start: _startDate, end: _endDate),
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
                  String formattedDate2 =
                      DateFormat('yyyy-MM-dd').format(_endDate);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(_startDate);
                  //firstTimeController.text = '${formattedDate} - $formattedDate2';

                  {
                    firstTimeController.text =
                        '$formattedDate - $formattedDate2';
                  }
                });
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 0.5)],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color.fromARGB(200, 43, 166, 223),
                    Color.fromARGB(180, 41, 88, 162),
                  ],
                ),
              ),
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _apply(
      BuildContext context, StateSetter setState, TrackLoaded state) {
    return Container(
        width: MediaQuery.of(context).size.width - 10,
        height: 60,
        child: Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          width: MediaQuery.of(context).size.width - 10,
          height: 50,
          child: CupertinoButton.filled(
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  context.read<TrackBloc>().add(TrackFilterEvent(
                      start: DateFormat('yyyy-MM-dd').format(_startDate),
                      end: DateFormat('yyyy-MM-dd').format(_endDate),
                      courier: state.courierSelected.code.toString(),
                      printing: _printed!.id,
                      order: state.statusSelected.id.toString()));
                  // textOrder = state.statusSelected!.name!;
                  Navigator.pop(context);
                });
              },
              child: Text(
                'นำไปใช้',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: PlatformSize(context) * 1.4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
        ));
  }

  _bodyShipping(TrackLoaded state, StateSetter setState, Color colorcourier) {
    return Container(
      //color: Colors.red,
      color: Colors.white,
      height: 170,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.courier.length,
                physics: AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 110,
                    childAspectRatio: 8 / 15,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.read<TrackBloc>().add(UpdateFilterEvent(
                          courierSelected: state.courier[index]));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset.zero,
                                color: colorcourier = state.courier[index] ==
                                        state.courierSelected
                                    ? Colors.blue
                                    : Colors.black26,
                                blurRadius: state.courier[index] ==
                                        state.courierSelected
                                    ? 2
                                    : 1,
                                spreadRadius: 0)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          state.courier[index].name != 'ทั้งหมด'
                              ? Image.network(
                                  state.courier[index].logo!,
                                  width: 70,
                                )
                              : state.courier[index].name == 'ทั้งหมด'
                                  ? Icon(Icons.local_shipping_outlined)
                                  : SizedBox(),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            state.courier[index].name!,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontSize: PlatformSize(context) * .9,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Padding _orderHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.square_list,
                color: Theme.of(context).iconTheme.color,
              ),
              Text(
                '   สถานะ',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: PlatformSize(context)),
              ),
            ],
          ),
          Icon(Icons.keyboard_double_arrow_right_rounded,
              size: 20, color: Color.fromARGB(180, 41, 88, 162))
        ],
      ),
    );
  }

  Container _bodyStatus(BuildContext context, TrackLoaded state,
      StateSetter setState, Color colorstatus) {
    return Container(
      height: 170,
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.ordermodel.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 110,
                    childAspectRatio: 8 / 15,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.read<TrackBloc>().add(UpdateFilterEvent(
                          statusSelected: state.ordermodel[index]));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset.zero,
                                color: colorstatus = state.ordermodel[index] ==
                                        state.statusSelected
                                    ? Colors.blue
                                    : Colors.black26,
                                blurRadius: state.ordermodel[index] ==
                                        state.statusSelected
                                    ? 2
                                    : 1)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.ordermodel[index].name!,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontSize: PlatformSize(context) * .9,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Padding _headerPrint(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.printer,
                color: Theme.of(context).iconTheme.color,
              ),
              Text(
                '   สถานะพิมพ์',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: PlatformSize(context)),
              ),
            ],
          ),
          Icon(Icons.keyboard_double_arrow_right_rounded,
              size: 20, color: Color.fromARGB(180, 41, 88, 162))
        ],
      ),
    );
  }

  Container _bodyPrintStatus(
      BuildContext context, StateSetter setState, Color colorstatusprint) {
    return Container(
      height: 85,
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Printed.printed.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 110,
                    childAspectRatio: 6 / 11.5,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onSelectFilterStatusPrint(Printed.printed[index]);
                      setState(() {
                        colorstatusprint = Printed.printed[index] == _printed
                            ? Colors.blue
                            : Colors.black26;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset.zero,
                                color: colorstatusprint =
                                    Printed.printed[index] == _printed
                                        ? Colors.blue
                                        : Colors.black26,
                                blurRadius:
                                    Printed.printed[index] == _printed ? 2 : 1)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            Printed.printed[index].statusName,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontSize: PlatformSize(context),
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  buildShowModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      barrierColor: Colors.black54,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        Color colorcourier = Colors.black26;
        Color colorstatus = Colors.black26;
        Color colorstatusprint = Colors.black26;
        return SafeArea(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                height: MediaQuery.of(context).size.height * .85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    filterHeader(context, setState),
                    // _customDivinder(context),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            //color: Theme.of(context).primaryColor,
                            child: Column(
                              children: [
                                BlocBuilder<TrackBloc, TrackState>(
                                    builder: (context, state) {
                                  if (state is TrackLoaded) {
                                    // _orderStatus = state.orderStatusList!.first;
                                    return Column(
                                      children: [
                                        _filterDateTime(context, setState),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        _shippingHeader(context),
                                        _bodyShipping(
                                            state, setState, colorcourier),
                                        _orderHeader(context),
                                        _bodyStatus(context, state, setState,
                                            colorstatus),
                                        _headerPrint(context),
                                        _bodyPrintStatus(context, setState,
                                            colorstatusprint),
                                        _apply(context, setState, state)
                                      ],
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
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
        bottom: false,
        child: Scaffold(
            // appBar: CustomAppBar(title: 'OrderList', backArrow: false),
            body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: false,
              pinned: false,
              toolbarHeight: 50,
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
                    'รายการพัสดุ',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: PlatformSize(context) * 1.2,
                        fontWeight: FontWeight.bold,
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
            )
          ],
          body: BlocBuilder<TrackBloc, TrackState>(
            builder: (context, state) {
              if (state is TrackLoading) {
                return LoadingShimmer();
              } else if (state is TrackLoaded) {
                return Column(
                  children: [
                    buildSearch(context, state.trackmodel.length, state),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(Duration(milliseconds: 1000),
                              () {
                            context.read<TrackBloc>().add(TrackInitialEvent());
                          });
                        },
                        child: ListView.builder(
                          //physics: AlwaysScrollableScrollPhysics(),
                          itemCount: state.trackmodel.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              child: Slidable(
                                enabled: !_isSelect,
                                endActionPane: state.trackmodel[index].inBill ==
                                        1
                                    ? ActionPane(
                                        extentRatio: 2 / 5,
                                        motion: DrawerMotion(),
                                        children: [
                                            SlidableAction(
                                              onPressed: (context) {},
                                              label: 'ปริ้นท์',
                                              icon: CupertinoIcons.printer,
                                              foregroundColor: Colors.blue,
                                              backgroundColor: Colors.white,
                                            ),
                                          ])
                                    : ActionPane(
                                        extentRatio: 3 / 5,
                                        motion: DrawerMotion(),
                                        children: [
                                            SlidableAction(
                                              onPressed: (context) {},
                                              label: 'ปริ้นท์',
                                              icon: CupertinoIcons.printer,
                                              foregroundColor: Colors.blue,
                                              backgroundColor: Colors.white,
                                            ),
                                            SlidableAction(
                                              onPressed: (context) {
                                                _showAlertDelete(
                                                    context,
                                                    state.trackmodel[index].id
                                                        .toString(),
                                                    state.trackmodel[index]
                                                        .courierCode!,
                                                    state.trackmodel[index]
                                                        .refCode!);
                                              },
                                              label: 'ยกเลิก',
                                              icon: CupertinoIcons.delete,
                                              foregroundColor: Colors.red,
                                              backgroundColor: Colors.white,
                                            )
                                          ]),
                                child: GestureDetector(
                                  onTap: _isSelect
                                      ? () {
                                          setState(() {
                                            if (_selectedItems.contains(
                                                state.trackmodel[index].id)) {
                                              _selectedItems.removeWhere(
                                                  (val) =>
                                                      val ==
                                                      state.trackmodel[index]
                                                          .id);
                                            } else {
                                              _selectedItems.add(
                                                  state.trackmodel[index].id);
                                            }
                                          });
                                        }
                                      : null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // border: Border.all(
                                        //   width: 0.5,
                                        //   color: Colors.black54,
                                        // ),
                                        boxShadow: [
                                          _selectedItems.contains(
                                                  state.trackmodel[index].id)
                                              ? BoxShadow(
                                                  color: Colors.blue,
                                                  spreadRadius: 3,
                                                  blurRadius: 4)
                                              : BoxShadow(
                                                  color: Colors.black45,
                                                  spreadRadius: 0,
                                                  blurRadius: 1)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.23,
                                                child: state.trackmodel[index]
                                                            .courierCode ==
                                                        'FlashExpress'
                                                    ? Image.network(
                                                        '${state.trackmodel[index].logoMobile}',
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8)),
                                                        child: Image.network(
                                                          '${state.trackmodel[index].logoMobile}',
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'เลขพัสดุ : ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context)),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            '${state.trackmodel[index].trackNo}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline4!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        PlatformSize(
                                                                            context)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'ผู้รับ : ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context)),
                                                        ),
                                                        Text(
                                                          '${state.trackmodel[index].dstName}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context)),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'เบอร์โทร : ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context)),
                                                        ),
                                                        Text(
                                                          '${state.trackmodel[index].dstPhone}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context)),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'วันที่ : ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context)),
                                                        ),
                                                        Text(
                                                          DateFormat.yMd('th')
                                                              .add_jms()
                                                              .format(DateTime
                                                                  .parse(
                                                                      '${state.trackmodel[index].createdAt}')),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey.shade100,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'ที่อยู่ : ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black87,
                                                              fontSize:
                                                                  PlatformSize(
                                                                      context)),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${state.trackmodel[index].dstAddress} ${state.trackmodel[index].dstZipcode}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize:
                                                                    PlatformSize(
                                                                        context)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'สถานะ : ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black87,
                                                              fontSize:
                                                                  PlatformSize(
                                                                      context)),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Color(_getColorFromHex(state
                                                                  .trackmodel[
                                                                      index]
                                                                  .statusColor!))
                                                              .withOpacity(.75),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          state
                                                              .trackmodel[index]
                                                              .statusName!,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      PlatformSize(
                                                                          context)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
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
          ),
        )),
      ),
    );
  }
}
