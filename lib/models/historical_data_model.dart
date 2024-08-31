import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class HistoricalStockData {
  final MetaData metaData;
  final Map<String, TimeSeries> timeSeries;

  HistoricalStockData({required this.metaData, required this.timeSeries});

  factory HistoricalStockData.fromJson(Map<String, dynamic> json) {
    return HistoricalStockData(
      metaData: MetaData.fromJson(json['Meta Data']),
      timeSeries: (json['Time Series (Daily)'] as Map<String, dynamic>).map(
        (date, data) => MapEntry(date, TimeSeries.fromJson(data)),
      ),
    );
  }
}

class MetaData {
  final String information;
  final String symbol;
  final String lastRefreshed;
  final String outputSize;
  final String timeZone;

  MetaData({
    required this.information,
    required this.symbol,
    required this.lastRefreshed,
    required this.outputSize,
    required this.timeZone,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      information: json['1. Information'],
      symbol: json['2. Symbol'],
      lastRefreshed: json['3. Last Refreshed'],
      outputSize: json['4. Output Size'],
      timeZone: json['5. Time Zone'],
    );
  }
}

class TimeSeries {
  final String open;
  final String high;
  final String low;
  final String close;
  final String volume;

  TimeSeries({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory TimeSeries.fromJson(Map<String, dynamic> json) {
    return TimeSeries(
      open: json['1. open'],
      high: json['2. high'],
      low: json['3. low'],
      close: json['4. close'],
      volume: json['5. volume'],
    );
  }
}

Future<HistoricalStockData?> fetchHistoricalStockData(String symbol) async {
  final apiKey = '411R7YWZSJWPGO78';
  // const apiKey = 'MY31M0AP3TAN5NI8';
  final url =
      'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    try {
      return HistoricalStockData.fromJson(jsonResponse);
    } catch (e) {
      // print(e);
      // print(url);
      // print(response.body);
      Fluttertoast.showToast(
        msg: 'Total API call limit reached for today',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } else {
    print('Failed to load historical data');
    return null;
  }
}

// void main() async {
//   HistoricalStockData? stockData = await fetchStockData('AAPL');

//   if (stockData != null) {
//     print('Stock Symbol: ${stockData.metaData.symbol}');
//     print('Last Refreshed: ${stockData.metaData.lastRefreshed}');

//     // Iterate over time series data
//     stockData.timeSeries.forEach((date, data) {
//       print('Date: $date, Open: ${data.open}, Close: ${data.close}');
//     });
//   }
// }

Future<void> fetchHistoricalData(String symbol) async {
  const apiKey = '411R7YWZSJWPGO78';
  final url =
      'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Historical Data: $data');
  } else {
    print('Failed to load historical data');
  }
}
