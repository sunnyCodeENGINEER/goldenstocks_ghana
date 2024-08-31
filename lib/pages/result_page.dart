// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:goldenstocks_ghana/models/historical_data_model.dart';

import '../models/stock_symbols.dart';

class ResultPage extends StatelessWidget {
  final String symbol;
  const ResultPage({
    super.key,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Text('Predicted Price for ${getKeyFromValue(symbol)}($symbol):'),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'GHs',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  '999.99',
                  style: TextStyle(fontSize: 90, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Text('Confidence: 100%'),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  // fetchHistoricalData('AAPL');
                  print(fetchHistoricalStockData(symbol));
                },
                child: const Text('View Historical Data')),
            const Spacer(),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
