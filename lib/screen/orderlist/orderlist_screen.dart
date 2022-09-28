import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectship_app/bloc/track_bloc/track_bloc.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';
import 'package:intl/intl.dart';

import '../../widget/fontsize.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  bool isPlaying = false;
  TextEditingController textController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
      print(isPlaying);
    });
  }

  buildSearch(BuildContext context, int total) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset.zero, spreadRadius: .2, color: Colors.grey.shade400)
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
                          // if (keyword == '') {
                          //   context
                          //       .read<GetMessageHistoryBloc>()
                          //       .add(GetMessageHistoryInitialEvent());
                          // } else {
                          //   context
                          //       .read<GetMessageHistoryBloc>()
                          //       .add(FilterUserwithSearch(keyword: keyword));
                          // }
                        },
                        decoration: InputDecoration(
                            prefixIconColor: Colors.blue,
                            iconColor: Colors.blue,
                            focusColor: Colors.blue,
                            contentPadding: EdgeInsets.symmetric(vertical: 1),
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            suffix: TextButton(
                              onPressed: () {},
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
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            'ทั้งหมก $total รายการ',
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
            GestureDetector(
              onTap: () {},
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    context.read<TrackBloc>().add(TrackInitialEvent(
        start: '2022-09-01',
        end: '2022-09-25',
        courier: 'all',
        printing: 'all',
        order: 'all'));
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
            // appBar: CustomAppBar(title: 'OrderList', backArrow: false),
            body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: false,
              pinned: false,
              toolbarHeight: 50,
              elevation: 0,
              title: Text('Orderlist'),
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
                    buildSearch(context, state.trackmodel.length),
                    Expanded(
                      child: ListView.builder(
                        //physics: AlwaysScrollableScrollPhysics(),
                        itemCount: state.trackmodel.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   width: 0.5,
                                  //   color: Colors.black54,
                                  // ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black45,
                                        spreadRadius: 0,
                                        blurRadius: 1)
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
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
                                                          Radius.circular(8)),
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
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87,
                                                            fontSize:
                                                                PlatformSize(
                                                                    context)),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '${state.trackmodel[index].trackNo}',
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
                                                    'ผู้รับ : ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87,
                                                            fontSize:
                                                                PlatformSize(
                                                                    context)),
                                                  ),
                                                  Text(
                                                    '${state.trackmodel[index].dstName}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(
                                                            color:
                                                                Colors.black87,
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
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87,
                                                            fontSize:
                                                                PlatformSize(
                                                                    context)),
                                                  ),
                                                  Text(
                                                    '${state.trackmodel[index].dstPhone}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(
                                                            color:
                                                                Colors.black87,
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
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87,
                                                            fontSize:
                                                                PlatformSize(
                                                                    context)),
                                                  ),
                                                  Text(
                                                    DateFormat.yMd('th')
                                                        .add_jms()
                                                        .format(DateTime.parse(
                                                            '${state.trackmodel[index].createdAt}')),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(
                                                            color:
                                                                Colors.black87,
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
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8))),
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
                                                            FontWeight.bold,
                                                        color: Colors.black87,
                                                        fontSize: PlatformSize(
                                                            context)),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${state.trackmodel[index].dstAddress} ${state.trackmodel[index].dstZipcode}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4!
                                                      .copyWith(
                                                          color: Colors.black87,
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
                                                            FontWeight.bold,
                                                        color: Colors.black87,
                                                        fontSize: PlatformSize(
                                                            context)),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    state.trackmodel[index]
                                                        .statusName!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87,
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
                          );
                        },
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
