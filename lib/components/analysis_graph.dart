import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisGraph extends StatelessWidget {
  
  final List<FlSpot> data;
  const AnalysisGraph({super.key, required this.data, });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: LineChart(
          LineChartData(
            gridData: _buildGridData(),
            borderData: _buildBorderData(),
            titlesData: _buildTitlesData(),
            lineBarsData: [
              _buildLineChartBarData(),
            ],
          ),
        ),
      ),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawHorizontalLine: true,
      drawVerticalLine: true, 
    );
  }

  FlBorderData _buildBorderData() {
    return FlBorderData(
      show: true,
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
        )
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        )
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        )
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            return Text("${value.toInt()}");
          },
        )
      ),
    );
  }

  LineChartBarData _buildLineChartBarData() {
    return LineChartBarData(
      spots: data,
      color: Colors.blue,
      barWidth: 2,
      isCurved: true,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.lightBlueAccent,
            Colors.lightBlue,
          ]
        )
      )
    );
  }
}