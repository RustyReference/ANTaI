import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../components/analysis_graph.dart';

class AnalyticsTab extends StatelessWidget {

  const AnalyticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _chart1(),
          ],
        ),
      ),
    );
  }

  Widget _chart1() {
    return SizedBox(
      height: 300,
      width: 300,
      child: AnalysisGraph(
        data: [
          FlSpot(1, 1),
          FlSpot(2, 2),
          FlSpot(3, 3),
          FlSpot(4, 4),
          FlSpot(5, 5),
          FlSpot(6, 6),
        ],
      ),
    );
  }
}
