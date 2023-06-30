import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/dashboard_graph_model.dart';
import 'custom_appbar.dart';

// class DashboardChart extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;

//   DashboardChart(this.seriesList, {required this.animate});

//   factory DashboardChart.withSampleData() {
//     return DashboardChart(
//       _createSampleData(),
//       animate: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildChart('COD Waiting', 0),
//         _buildChart('COD Success', 1),
//       ],
//     );
//   }

//   Widget _buildChart(String title, int index) {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: charts.BarChart(
//         [seriesList[index]],
//         animate: animate,
//         vertical: false,
//         barRendererDecorator: charts.BarLabelDecorator<String>(),
//         domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
//         primaryMeasureAxis: charts.NumericAxisSpec(
//           renderSpec: charts.GridlineRendererSpec(
//             labelStyle: charts.TextStyleSpec(
//               color: charts.MaterialPalette.white,
//             ),
//             lineStyle: charts.LineStyleSpec(
//               color: charts.MaterialPalette.gray.shade400,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   static List<charts.Series<DashboardData, String>> _createSampleData() {
//     final data = [
//       DashboardData('COD Waiting', 0),
//       DashboardData('COD Success', 100),
//     ];

//     return [
//       charts.Series<DashboardData, String>(
//         id: 'DashboardData',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (DashboardData data, _) => data.title,
//         measureFn: (DashboardData data, _) => data.value,
//         data: data,
//         labelAccessorFn: (DashboardData data, _) => '${data.title}: ${data.value}',
//       ),
//     ];
//   }
// }
