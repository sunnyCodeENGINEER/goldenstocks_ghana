import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/historical_data_model.dart';

class StockChart extends StatelessWidget {
  final Map<String, TimeSeries> timeSeries;

  const StockChart({super.key, required this.timeSeries});

  @override
  Widget build(BuildContext context) {
    // Prepare data for the last 5 days
    final List<FlSpot> openSpots = [];
    final List<FlSpot> highSpots = [];
    final List<FlSpot> lowSpots = [];
    final List<FlSpot> closeSpots = [];

    // Get the last 5 days of data
    final sortedDates = timeSeries.keys.toList()..sort();
    final lastFiveDates = sortedDates.take(5).toList().reversed.toList();

    for (var i = 0; i < lastFiveDates.length; i++) {
      final date = lastFiveDates[i];
      final series = timeSeries[date]!;
      final x = i.toDouble(); // X axis position
      openSpots.add(FlSpot(x, double.parse(series.open)));
      highSpots.add(FlSpot(x, double.parse(series.high)));
      lowSpots.add(FlSpot(x, double.parse(series.low)));
      closeSpots.add(FlSpot(x, double.parse(series.close)));
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          // gridData: const FlGridData(show: false),

          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                final date = lastFiveDates[value.toInt()];
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      date,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                );
              },
            )),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    value.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            )),
          ),
          // borderData: FlBorderData(show: true),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
              right: BorderSide.none, // Remove the right border
              top: BorderSide.none, // Remove the top border
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: openSpots,
              isCurved: true,
              // color: [Colors.blue],
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              color: Colors.blue,
              isStrokeCapRound: true,
              curveSmoothness: 0.1,
            ),
            LineChartBarData(
              spots: highSpots,
              isCurved: true,
              // colors: [Colors.green],
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              color: Colors.green,
              isStrokeCapRound: true,
              curveSmoothness: 0.1,
            ),
            LineChartBarData(
              spots: lowSpots,
              isCurved: true,
              // colors: [Colors.red],
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              color: Colors.red,
              isStrokeCapRound: true,
              curveSmoothness: 0.1,
            ),
            LineChartBarData(
              spots: closeSpots,
              isCurved: true,
              // colors: [Colors.orange],
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              color: Colors.orange,
              isStrokeCapRound: true,
              curveSmoothness: 0.1,
            ),
          ],
          lineTouchData: const LineTouchData(enabled: false),
        ),
      ),
    );
  }
}
