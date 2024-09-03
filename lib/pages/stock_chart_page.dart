// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/models/historical_data_model.dart';

import '../components/stock_chart.dart';

// Define your StockData, MetaData, and TimeSeries classes here

class StockChartPage extends StatelessWidget {
  final String symbol;
  const StockChartPage({
    super.key,
    required this.symbol,
  });

  // Future<StockData?> fetchStockData(String symbol) async {
  //   final apiKey = 'YOUR_API_KEY';
  //   final url = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey';

  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(response.body);
  //     return StockData.fromJson(jsonResponse);
  //   } else {
  //     print('Failed to load historical data');
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HistoricalStockData?>(
      future: fetchHistoricalStockData(symbol),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Error fetching data'));
        } else {
          final stockData = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Stock Prices For ($symbol)'),
            ),
            body: Column(
              children: [
                SizedBox(
                    height: 400,
                    child: StockChart(timeSeries: stockData.timeSeries)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegend(color: Colors.blue, label: 'Open'),
                    const SizedBox(width: 10),
                    _buildLegend(color: Colors.green, label: 'High'),
                    const SizedBox(width: 10),
                    _buildLegend(color: Colors.red, label: 'Low'),
                    const SizedBox(width: 10),
                    _buildLegend(color: Colors.orange, label: 'Close'),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildLegend({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
