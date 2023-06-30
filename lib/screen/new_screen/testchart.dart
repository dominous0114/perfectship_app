import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/new_model/dashboard_new_model.dart';

class DashboardChart extends StatelessWidget {
  final DashboardNewModel dashboardData;

  DashboardChart(this.dashboardData);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      series: <ChartSeries>[
        ColumnSeries<Data, String>(
          dataSource: <Data>[
            Data('COD Waiting', double.parse(dashboardData.codWaiting ?? '0')),
            Data('COD Success', double.parse(dashboardData.codSuccess ?? '0')),
          ],
          xValueMapper: (Data data, _) => data.category,
          yValueMapper: (Data data, _) => data.value,
        ),
      ],
    );
  }
}

class Data {
  final String category;
  final double value;

  Data(this.category, this.value);
}
