import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/historical_data_model.dart';

class StockCandlestickChart extends StatelessWidget {
  final Map<String, TimeSeries> timeSeries;

  const StockCandlestickChart({super.key, required this.timeSeries});

  @override
  Widget build(BuildContext context) {
    // Prepare data for the last 5 days
    final List<CandleData> chartData = [];

    // Get the last 5 days of data
    final sortedDates = timeSeries.keys.toList()..sort();
    final lastFiveDates = sortedDates.take(5).toList().reversed.toList();

    for (var i = 0; i < lastFiveDates.length; i++) {
      final date = lastFiveDates[i];
      final series = timeSeries[date]!;
      chartData.add(CandleData(
        x: DateTime.parse(date),
        open: double.parse(series.open),
        high: double.parse(series.high),
        low: double.parse(series.low),
        close: double.parse(series.close),
      ));
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: SfCartesianChart(
        primaryXAxis:  DateTimeAxis(
          // dateFormat: DateFormat.Md(), // Format the date axis
          intervalType: DateTimeIntervalType.days,
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis:  NumericAxis(
          majorGridLines: MajorGridLines(width: 0.5),
          axisLine: AxisLine(width: 0.5),
        ),
        series: <CandleSeries<CandleData, DateTime>>[
          CandleSeries<CandleData, DateTime>(
            dataSource: chartData,
            xValueMapper: (CandleData data, _) => data.x,
            lowValueMapper: (CandleData data, _) => data.low,
            highValueMapper: (CandleData data, _) => data.high,
            openValueMapper: (CandleData data, _) => data.open,
            closeValueMapper: (CandleData data, _) => data.close,
          )
        ],
      ),
    );
  }
}

class CandleData {
  final DateTime x;
  final double open;
  final double high;
  final double low;
  final double close;

  CandleData({
    required this.x,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
}
