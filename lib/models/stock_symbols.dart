import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Map<String, String> stockSymbols = {
  'Apple Inc.': 'AAPL',
  'Microsoft Corporation': 'MSFT',
  'Amazon.com, Inc.': 'AMZN',
  'Alphabet Inc. (Google)': 'GOOGL',
  'Facebook, Inc. (Meta Platforms)': 'META',
  'Tesla, Inc.': 'TSLA',
  'Berkshire Hathaway Inc.': 'BRK.B',
  'Johnson & Johnson': 'JNJ',
  'JPMorgan Chase & Co.': 'JPM',
  'Visa Inc.': 'V',
  'NVIDIA Corporation': 'NVDA',
  'Procter & Gamble Co.': 'PG',
  'Mastercard Incorporated': 'MA',
  'Walmart Inc.': 'WMT',
  'Home Depot, Inc.': 'HD',
  'UnitedHealth Group Incorporated': 'UNH',
  'Pfizer Inc.': 'PFE',
  'Coca-Cola Company': 'KO',
  'PepsiCo, Inc.': 'PEP',
  'Intel Corporation': 'INTC',
  'Cisco Systems, Inc.': 'CSCO',
  'Netflix, Inc.': 'NFLX',
  'Adobe Inc.': 'ADBE',
  'PayPal Holdings, Inc.': 'PYPL',
  'Salesforce.com, Inc.': 'CRM',
  'Walt Disney Company': 'DIS',
  'Exxon Mobil Corporation': 'XOM',
  'AT&T Inc.': 'T',
  'Verizon Communications Inc.': 'VZ',
  'Chevron Corporation': 'CVX',
  'AbbVie Inc.': 'ABBV',
  'Merck & Co., Inc.': 'MRK',
  'Boeing Company': 'BA',
  'McDonald\'s Corporation': 'MCD',
  'Starbucks Corporation': 'SBUX',
  'Ford Motor Company': 'F',
  'General Motors Company': 'GM',
  'IBM Corporation': 'IBM',
  '3M Company': 'MMM',
  'Qualcomm Incorporated': 'QCOM',
  'American Express Company': 'AXP',
  'Goldman Sachs Group, Inc.': 'GS',
  'Morgan Stanley': 'MS',
  'Bristol-Myers Squibb Company': 'BMY',
  'Caterpillar Inc.': 'CAT',
  'Costco Wholesale Corporation': 'COST',
  'Nike, Inc.': 'NKE',
  'Texas Instruments Incorporated': 'TXN',
  'Thermo Fisher Scientific Inc.': 'TMO',
};

String getStockSymbolOrName(String input) {
  // Check if the input is a key in the dictionary
  if (stockSymbols.containsKey(input)) {
    return stockSymbols[input]!;
  }

  // Check if the input is a value in the dictionary
  if (stockSymbols.containsValue(input)) {
    return input;
  }

  // If the input is neither a key nor a value, return a message or handle accordingly
  Fluttertoast.showToast(
    msg: 'Input not found in stock symbols',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
  return 'Input not found in stock symbols';
}

List<String> getMatchingStocks(String input) {
  List<String> matchingStocks = [];

  if (stockSymbols.containsKey(input)) {
    return [stockSymbols[input]!];
  }

  for (String key in stockSymbols.keys) {
    if (key.toLowerCase().startsWith(input.toLowerCase())) {
      matchingStocks.add(stockSymbols[key]!);
    }
  }

  if (matchingStocks.isEmpty) {
    Fluttertoast.showToast(
      msg: 'No stocks found starting with "$input"',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  return matchingStocks;
}

// Function to get the key from a value
String? getKeyFromValue(String value) {
  return stockSymbols.entries
      .firstWhere(
        (entry) => entry.value == value,
        orElse: () => MapEntry('', ''),
      )
      .key;
}

List<String> getValues() {
  List<String> valuesList = stockSymbols.values.toList();

  return valuesList;
}
