import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:perfectship_app/bloc/track_bloc/track_bloc.dart';
import 'package:perfectship_app/config/constant.dart';
import 'package:perfectship_app/screen/orderlist/tracking_screen.dart';
import 'package:perfectship_app/widget/fontsize.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

class SearchTrackDeletfate extends SearchDelegate {
  String server = MyConstant().domain;
  String initend = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String path = '/tracking?track=';
  BuildContext? contextPage;
  Color _color = Colors.transparent;
  String get searchFieldLabel => "กรอกหมายเลขพัสดุ";

  Future<void> scan(ScanMode scanMode, BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, scanMode);

      if (barcodeScanRes == '-1') {
      } else {
        query = barcodeScanRes;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TrackingScreen(
                    url: server, path: path, trackingNo: barcodeScanRes)));
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: query != '' ? Icon(Icons.clear) : Icon(Icons.qr_code_scanner),
        onPressed: query != ''
            ? () {
                query = "";
              }
            : () {
                scan(ScanMode.QR, context);
              },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Theme.of(context).iconTheme.color,
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        close(context, 'close');
        //Navigator.pop(context,'close');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return TrackingScreen(url: server, path: path, trackingNo: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    context.read<TrackBloc>().add(TrackSearchHomeEvent(
        keyword: query,
        start: '2021-01-01',
        end: initend,
        courier: 'all',
        printing: 'all',
        order: 'all'));
    return BlocBuilder<TrackBloc, TrackState>(
      builder: (context, state) {
        if (state is TrackLoading) {
          return LoadingShimmer();
        } else if (state is TrackLoaded) {
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.trackmodel.take(10).length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    state.trackmodel[index].logoMobile.toString(),
                    width: 50,
                  ),
                  title: Text(state.trackmodel[index].trackNo ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: PlatformSize(context) * 0.8)),
                  subtitle: Text('ผู้รับ : ${state.trackmodel[index].dstName}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: PlatformSize(context) * 0.7)),
                  trailing: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.copy,
                            color: Theme.of(context).iconTheme.color),
                        onPressed: () {
                          // query = state.orderData[index].trackNo!;
                          Clipboard.setData(ClipboardData(
                                  text: state.trackmodel[index].trackNo!))
                              .then((_) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              "คัดลอก ${state.trackmodel[index].trackNo!} แล้ว",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: PlatformSize(context),
                                      color: Colors.white),
                            )));
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          CupertinoIcons.arrow_up_left,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: () {
                          query = state.trackmodel[index].trackNo!;
                        },
                      ),
                    ],
                  ),
                  onTap: () async {
                    if (state.trackmodel[index].courierCode == 'NinjaVan') {
                      server = '';
                      server = 'https://www.ninjavan.co/th-th';
                      path = '';
                      path = '/tracking?id=';
                      query = state.trackmodel[index].trackNo!;
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => TrackingScreen(url: 'https://www.ninjavan.co/th-th', path: path, trackingNo: state.orderData[index].trackNo!)));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrackingScreen(
                                  url: 'https://www.ninjavan.co/th-th',
                                  path: path,
                                  trackingNo:
                                      state.trackmodel[index].trackNo!)));
                    } else {
                      server = '';
                      server = MyConstant().domainprint;
                      path = '';
                      path = '/tracking?track=';
                      query = state.trackmodel[index].trackNo!;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrackingScreen(
                                  url: server,
                                  path: '/tracking?track=',
                                  trackingNo:
                                      state.trackmodel[index].trackNo!)));
                    }
                  },
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
