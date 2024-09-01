// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/models/historical_data_model.dart';
import 'package:goldenstocks_ghana/pages/stock_candlestick_page.dart';

import '../models/stock_symbols.dart';
import 'stock_chart_page.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Predicted Price for '),
                Text('${getKeyFromValue(symbol)}($symbol):',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24))
              ],
            ),
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
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shadowColor: const Color.fromARGB(255, 123, 174, 215),
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red)),
                onPressed: () {
                  // fetchHistoricalData('AAPL');
                  print(fetchHistoricalStockData('AAPL'));

                  Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) =>
                            StockChartPage(
                              symbol: symbol,
                            ),
                            // StockCandlestickPage(symbol: symbol),
                            ),
                  );
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
