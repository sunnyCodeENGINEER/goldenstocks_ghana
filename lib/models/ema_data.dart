import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EmaData {
  final String symbol;
  final String indicator;
  final String lastRefreshed;
  final String interval;
  final int timePeriod;
  final String seriesType;
  final String timeZone;
  final double ema;

  EmaData({
    required this.symbol,
    required this.indicator,
    required this.lastRefreshed,
    required this.interval,
    required this.timePeriod,
    required this.seriesType,
    required this.timeZone,
    required this.ema,
  });

  // Factory method to create an EmaData object from a JSON response
  factory EmaData.fromJson(Map<String, dynamic> json) {
    final metaData = json['Meta Data'];
    final technicalAnalysis = json['Technical Analysis: EMA'];

    // Extract the most recent date
    final mostRecentDate = technicalAnalysis.keys.first;
    final mostRecentEma = double.parse(technicalAnalysis[mostRecentDate]['EMA']);

    return EmaData(
      symbol: metaData['1: Symbol'],
      indicator: metaData['2: Indicator'],
      lastRefreshed: metaData['3: Last Refreshed'],
      interval: metaData['4: Interval'],
      timePeriod: int.parse(metaData['5: Time Period']),
      seriesType: metaData['6: Series Type'],
      timeZone: metaData['7: Time Zone'],
      ema: mostRecentEma,
    );
  }
}


Future<EmaData?> fetchEMA(String symbol) async {
  final apiKey = '411R7YWZSJWPGO78';
  // const apiKey = 'MY31M0AP3TAN5NI8';
  final url =
      'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    try {
      return EmaData.fromJson(jsonResponse);
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