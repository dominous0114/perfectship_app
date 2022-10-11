import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/dashboard_graph_model.dart';
import 'custom_appbar.dart';

class Shipping extends StatefulWidget {
  final List<Data>? shipping;
  Shipping({
    Key? key,
    required this.shipping,
  }) : super(key: key);

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  String name = 'ยอดขนส่ง';

  bool isRotate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: [
            SfCartesianChart(
                backgroundColor: Colors.white,
                zoomPanBehavior: ZoomPanBehavior(
                    enablePinching: true,
                    enableDoubleTapZooming: true,
                    enableSelectionZooming: true,
                    selectionRectBorderColor: Colors.red,
                    selectionRectBorderWidth: 2,
                    selectionRectColor: Colors.grey,
                    enablePanning: true,
                    zoomMode: ZoomMode.x,
                    enableMouseWheelZooming: true,
                    maximumZoomLevel: 2),
                primaryXAxis: CategoryAxis(),

                // primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<Data, String>>[
                  ColumnSeries<Data, String>(
                    dataSource: widget.shipping!,
                    xValueMapper: (Data data, _) => data.date,
                    yValueMapper: (Data data, _) => data.pack,
                    name: name,
                    color: Colors.blue,
                  )
                ]),
            Positioned(
                top: 0,
                right: 16,
                child: IconButton(
                  color: Theme.of(context).iconTheme.color,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  appBar: CustomAppBar(
                                    title: name,
                                    backArrow: true,
                                    onPressArrow: () async {
                                      await SystemChrome
                                          .setPreferredOrientations([
                                        DeviceOrientation.portraitUp,
                                        DeviceOrientation.portraitDown,
                                      ]);
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                        Icons.stay_current_landscape_sharp),
                                    addButton: false,
                                    onPress: () async {
                                      setState(() {
                                        isRotate = !isRotate;
                                        print(isRotate);
                                      });
                                      if (isRotate == false) {
                                        await SystemChrome
                                            .setPreferredOrientations([
                                          DeviceOrientation.portraitUp,
                                          DeviceOrientation.portraitDown,
                                        ]);
                                      } else {
                                        await SystemChrome
                                            .setPreferredOrientations([
                                          DeviceOrientation.landscapeRight,
                                          DeviceOrientation.landscapeLeft,
                                        ]);
                                      }
                                    },
                                  ),
                                  body: Container(
                                    color: Colors.white,
                                    child: SfCartesianChart(
                                        legend: Legend(isVisible: true),
                                        onLegendItemRender: (args) {
                                          // Setting color for the series legend based on its index.
                                          if (args.seriesIndex == 0) {
                                            args.color = Colors.amberAccent;
                                          }
                                        },
                                        // plotAreaBackgroundColor: Colors.white,
                                        backgroundColor: Colors.white,
                                        zoomPanBehavior: ZoomPanBehavior(
                                            enablePinching: true,
                                            enableDoubleTapZooming: true,
                                            enableSelectionZooming: true,
                                            selectionRectBorderColor:
                                                Colors.red,
                                            selectionRectBorderWidth: 2,
                                            selectionRectColor:
                                                Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                            enablePanning: true,
                                            zoomMode: ZoomMode.x,
                                            enableMouseWheelZooming: true,
                                            maximumZoomLevel: 0.7),
                                        primaryXAxis: CategoryAxis(),
                                        //primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                                        tooltipBehavior:
                                            TooltipBehavior(enable: true),
                                        series: <ChartSeries<Data, String>>[
                                          ColumnSeries<Data, String>(
                                            dataSource: widget.shipping!,
                                            xValueMapper: (Data data, _) =>
                                                data.date,
                                            yValueMapper: (Data data, _) =>
                                                data.pack,
                                            name: name,
                                            color: Colors.blue,
                                          )
                                        ]),
                                  ),
                                )));
                  },
                  icon: Icon(
                    Icons.fullscreen_exit,
                    size: 50,
                    color: Colors.grey,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class CreditLog extends StatefulWidget {
  final List<Datas>? creditLog;
  CreditLog({
    Key? key,
    required this.creditLog,
  }) : super(key: key);

  @override
  State<CreditLog> createState() => _CreditLogState();
}

class _CreditLogState extends State<CreditLog> {
  String name = 'ค่าขนส่ง';
  bool isRotate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: [
            SfCartesianChart(
                backgroundColor: Colors.white,
                zoomPanBehavior: ZoomPanBehavior(
                    enablePinching: true,
                    enableDoubleTapZooming: true,
                    enableSelectionZooming: true,
                    selectionRectBorderColor: Colors.red,
                    selectionRectBorderWidth: 2,
                    selectionRectColor: Colors.grey,
                    enablePanning: true,
                    zoomMode: ZoomMode.x,
                    enableMouseWheelZooming: true,
                    maximumZoomLevel: 0.7),
                primaryXAxis: CategoryAxis(),
                //primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<Datas, String>>[
                  ColumnSeries<Datas, String>(
                    dataSource: widget.creditLog!,
                    xValueMapper: (Datas data, _) => data.date,
                    yValueMapper: (Datas data, _) => data.credit,
                    name: name,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  )
                ]),
            Positioned(
                top: 0,
                right: 16,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  appBar: CustomAppBar(
                                    title: name,
                                    backArrow: true,
                                    onPressArrow: () async {
                                      await SystemChrome
                                          .setPreferredOrientations([
                                        DeviceOrientation.portraitUp,
                                        DeviceOrientation.portraitDown,
                                      ]);
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                        Icons.stay_current_landscape_sharp),
                                    addButton: false,
                                    onPress: () async {
                                      setState(() {
                                        isRotate = !isRotate;
                                        print(isRotate);
                                      });
                                      if (isRotate == false) {
                                        await SystemChrome
                                            .setPreferredOrientations([
                                          DeviceOrientation.portraitUp,
                                          DeviceOrientation.portraitDown,
                                        ]);
                                      } else {
                                        await SystemChrome
                                            .setPreferredOrientations([
                                          DeviceOrientation.landscapeRight,
                                          DeviceOrientation.landscapeLeft,
                                        ]);
                                      }
                                    },
                                  ),
                                  body: SfCartesianChart(
                                      legend: Legend(isVisible: true),
                                      onLegendItemRender: (args) {
                                        // Setting color for the series legend based on its index.
                                        if (args.seriesIndex == 0) {
                                          args.color = Colors.amberAccent;
                                        }
                                      },
                                      backgroundColor: Colors.white,
                                      zoomPanBehavior: ZoomPanBehavior(
                                          enablePinching: true,
                                          enableDoubleTapZooming: true,
                                          enableSelectionZooming: true,
                                          selectionRectBorderColor: Colors.red,
                                          selectionRectBorderWidth: 2,
                                          selectionRectColor: Colors.grey,
                                          enablePanning: true,
                                          zoomMode: ZoomMode.x,
                                          enableMouseWheelZooming: true,
                                          maximumZoomLevel: 0.7),
                                      primaryXAxis: CategoryAxis(),
                                      //primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                                      tooltipBehavior:
                                          TooltipBehavior(enable: true),
                                      series: <ChartSeries<Datas, String>>[
                                        ColumnSeries<Datas, String>(
                                            dataSource: widget.creditLog!,
                                            xValueMapper: (Datas data, _) =>
                                                data.date,
                                            yValueMapper: (Datas data, _) =>
                                                data.credit,
                                            name: name,
                                            color: Colors.blue)
                                      ]),
                                )));
                  },
                  icon: Icon(
                    Icons.fullscreen_exit,
                    size: 50,
                    color: Colors.grey,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
