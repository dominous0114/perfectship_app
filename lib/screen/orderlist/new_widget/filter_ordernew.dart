import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perfectship_app/bloc/new_bloc/orderlist_new/orderlist_new_bloc.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

class FilterOrderNew extends StatefulWidget {
  const FilterOrderNew({Key? key}) : super(key: key);

  @override
  State<FilterOrderNew> createState() => _FilterOrderNewState();
}

class _FilterOrderNewState extends State<FilterOrderNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Color.fromARGB(200, 43, 166, 223),
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.blue,
                )),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('คัดกรอง'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<OrderlistNewBloc>().add(OrderlistNewResetEvent());
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.blue,
              )),
        ],
      ),
      body: BlocBuilder<OrderlistNewBloc, OrderlistNewState>(
        builder: (context, state) {
          if (state is OrderlistNewLoading) {
            return LoadingShimmer();
          } else if (state is OrderlistNewLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ขนส่ง',
                      style: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.couriers.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200, childAspectRatio: 2.5, crossAxisSpacing: 6, mainAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.read<OrderlistNewBloc>().add(OrderlistNewChangeCourierEvent(courierNewModel: state.couriers[index]));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: state.couriers[index].code == state.courier.code ? 2 : 0,
                                      blurRadius: state.couriers[index].code == state.courier.code ? 3 : 0.5,
                                      color: state.couriers[index].code == state.courier.code ? Color.fromARGB(200, 43, 166, 223) : Colors.black45),
                                ],
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CachedNetworkImage(
                                        width: 80,
                                        imageUrl: state.couriers[index].logoMobile ?? '',
                                        placeholder: (context, url) => CupertinoActivityIndicator(),
                                        errorWidget: (context, url, error) => Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.truckFast,
                                                    size: 16,
                                                  ),
                                                ],
                                              )),
                                            )),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${state.couriers[index].name}',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'สถานะ',
                      style: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.statuses.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200, childAspectRatio: 3, crossAxisSpacing: 5, mainAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.read<OrderlistNewBloc>().add(OrderlistNewChangeStatusEvent(status: state.statuses[index]));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: state.statuses[index].code == state.status.code ? 2 : 0,
                                      blurRadius: state.statuses[index].code == state.status.code ? 3 : 0.5,
                                      color: state.statuses[index].code == state.status.code ? Color.fromARGB(200, 43, 166, 223) : Colors.black45),
                                ],
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${state.statuses[index].name}',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text('มีบางอย่างผิดพลาด');
          }
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          context.read<OrderlistNewBloc>().add(OrderlistNewFilterEvent());
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 1)]),
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
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
              child: Center(
                child: Text(
                  'คัดกรอง',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
