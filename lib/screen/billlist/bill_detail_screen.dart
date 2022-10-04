import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perfectship_app/bloc/bill_bloc/bill_bloc.dart';
import 'package:perfectship_app/bloc/bill_detail_bloc/bill_detail_bloc.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import '../../widget/fontsize.dart';

class BillDetailScreen extends StatefulWidget {
  final List list;
  const BillDetailScreen({Key? key, required this.list}) : super(key: key);
  static const String routeName = '/billdetail';

  static Route route({required List list}) {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => BillDetailScreen(
              list: list,
            ));
  }

  @override
  State<BillDetailScreen> createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen>
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
                          boxShadow: [
                            BoxShadow(
                                offset: Offset.zero,
                                spreadRadius: .3,
                                color: Colors.grey)
                          ]),
                      child: TextFormField(
                        style: TextStyle(fontSize: PlatformSize(context)),
                        cursorColor: Colors.blue.shade300,
                        controller: textController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        focusNode: searchFocusNode,
                        onChanged: (keyword) async {
                          if (textController.text == '') {
                            context.read<BillDetailBloc>().add(
                                BillDetailInitialEvent(id: widget.list[0]));
                          } else {
                            context.read<BillDetailBloc>().add(
                                BillDetailSearchEvent(
                                    id: widget.list[0], keyword: keyword));
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
                                context.read<BillDetailBloc>().add(
                                    BillDetailInitialEvent(id: widget.list[0]));
                                setState(() {
                                  textController.clear();
                                  searchFocusNode.unfocus();
                                });
                              },
                              child: Text(
                                'ล้าง',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: Colors.blue.shade300,
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
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    context
        .read<BillDetailBloc>()
        .add(BillDetailInitialEvent(id: widget.list[0]));
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
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      leading: IconButton(
                        icon:
                            Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      floating: true,
                      snap: false,
                      pinned: false,
                      toolbarHeight: 50,
                      elevation: 0,
                      title: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.receipt,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '# ${widget.list[1]}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
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
              body: BlocBuilder<BillDetailBloc, BillDetailState>(
                builder: (context, state) {
                  if (state is BillDetailLoading) {
                    return LoadingShimmer();
                  } else if (state is BillDeatilLoaded) {
                    return SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black)]),
                          child: buildSearch(
                              context, state.billdetailmodel.length),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.billdetailmodel.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 1,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey.shade300,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '# ${state.billdetailmodel[index].trackNo} (${state.billdetailmodel[index].dstName})',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(
                                                        fontSize: PlatformSize(
                                                                context) *
                                                            1.1,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                              ),
                                            ),
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //     color: Colors.red,
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //   ),
                                            //   child: Padding(
                                            //     padding:
                                            //         const EdgeInsets.symmetric(
                                            //             horizontal: 8,
                                            //             vertical: 3),
                                            //     child: Text(
                                            //       'ยกเลิกเลขพัสดุ',
                                            //       style: Theme.of(context)
                                            //           .textTheme
                                            //           .headlineMedium!
                                            //           .copyWith(
                                            //               fontSize: PlatformSize(
                                            //                   context),
                                            //               fontWeight:
                                            //                   FontWeight.w600,
                                            //               color: Colors.white),
                                            //     ),
                                            //   ),
                                            // )
                                            state.billdetailmodel[index]
                                                        .isCancel ==
                                                    'รายการปกติ'
                                                ? SizedBox()
                                                : Text(
                                                    'ยกเลิกเลขพัสดุแล้ว',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium!
                                                        .copyWith(
                                                            fontSize:
                                                                PlatformSize(
                                                                    context),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.red),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'ราคา/หน่วย : ${state.billdetailmodel[index].price}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontSize: PlatformSize(context),
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                    ),
                                    Text(
                                      'COD : ${state.billdetailmodel[index].codAmount}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontSize: PlatformSize(context),
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                    ),
                                    Text(
                                      'ค่าธรรมเนียม COD : ${state.billdetailmodel[index].codAmount}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontSize: PlatformSize(context),
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                    ),
                                    Text(
                                      'จำนวน : ${state.billdetailmodel[index].productQty}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontSize: PlatformSize(context),
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                    ),
                                    Text(
                                      'รวม : ${state.billdetailmodel[index].totalPrice}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontSize: PlatformSize(context),
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ]),
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
