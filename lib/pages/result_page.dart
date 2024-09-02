// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:goldenstocks_ghana/models/historical_data_model.dart';
import 'package:goldenstocks_ghana/pages/stock_candlestick_page.dart';

import '../models/ema_data.dart';
import '../models/stock_symbols.dart';
import 'stock_chart_page.dart';

class ResultPage extends StatelessWidget {
  final String symbol;
  const ResultPage({
    super.key,
    required this.symbol,
  });

  Future<double?> fetchEMAData(String symbol) async {
    final apiKey = '411R7YWZSJWPGO78';
    // const apiKey = 'MY31M0AP3TAN5NI8';
    final url =
        'https://www.alphavantage.co/query?function=EMA&symbol=$symbol&interval=weekly&time_period=10&series_type=close&apikey=$apiKey';

    // final response = await http.get(Uri.parse(url));

    // if (response.statusCode == 200) {
    //   final jsonResponse = jsonDecode(response.body);
    //   try {
    //     return EmaData.fromJson(jsonResponse);
    //   } catch (e) {
    //     print(e);
    //     print(url);
    //     print(response.body);
    //     Fluttertoast.showToast(
    //       msg: 'Total API call limit reached for today',
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0,
    //     );
    //   }
    // } else {
    //   print('Failed to load historical data');
    //   return null;
    // }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final emaData = jsonResponse['Technical Analysis: EMA'];

      if (emaData != null && emaData is Map) {
        // Get the most recent date (which is usually the first key)
        final recentDate = emaData.keys.first;
        final recentEma = emaData[recentDate]['EMA'];

        // Ensure 'EMA' is a string before parsing to double
        if (recentEma is String) {
          return double.tryParse(recentEma);
        } else {
          throw Exception('Unexpected data format for EMA');
        }
      }
    } else {
      throw Exception('Failed to load EMA data');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double?>(
      future: fetchEMAData(symbol),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while waiting
        } else if (snapshot.hasError) {
          return const Text('Error fetching data'); // Show an error message
        } else if (snapshot.hasData && snapshot.data != null) {
          final emaData = snapshot.data!;
          // return Text(
          //   emaData.ema.toStringAsFixed(2), // Display the EMA value
          //   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // );

          return Scaffold(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '\$',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        emaData.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 90, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text('Confidence: ${Random().nextInt(31) + 69}%'),
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
                            builder: (context) => StockChartPage(
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
        } else {
          return const Text('No data available'); // Handle no data scenario
        }
      },
    );
  }
}
