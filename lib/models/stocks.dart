import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';

import 'offline_model.dart';
import 'stocks_model.dart';
import 'package:http/http.dart' as http;

class Stocks {
  List<Future<StockQuote>> stocks = [];

  void fetchStocks() {
    List<String> symbols = ['AAPL'];

    for (String symbol in symbols) {
      Future<StockQuote> stock = fetchStockQuote(symbol);
      stocks.add(stock);
      print(stock);
    }
  }

  Future<StockQuote> fetchStockQuote(String symbol) async {
    const String apiKey = 'cr9eg5pr01qkt06p2kh0cr9eg5pr01qkt06p2khg';
    final String url =
        'https://finnhub.io/api/v1/quote?symbol=$symbol&token=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the JSON response and map it to the StockQuote model
      final Map<String, dynamic> json = jsonDecode(response.body);
      return StockQuote.fromJson(json);
    } else {
      // Handle the error
      throw Exception('Failed to load stock quote');
    }
  }
}

Future<StockQuote> fetchStockQuote(String symbol) async {
    const String apiKey = 'cr9eg5pr01qkt06p2kh0cr9eg5pr01qkt06p2khg';
    final String url =
        'https://finnhub.io/api/v1/quote?symbol=$symbol&token=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the JSON response and map it to the StockQuote model
      final Map<String, dynamic> json = jsonDecode(response.body);
      return StockQuote.fromJson(json);
    } else {
      // Handle the error
      throw Exception('Failed to load stock quote');
    }
  }

Future<Map<String, StockQuote>> fetchStockQuotes(List<String> symbols) async {
  final String apiKey = 'cr9eg5pr01qkt06p2kh0cr9eg5pr01qkt06p2khg';
  Map<String, StockQuote> quotes = {};

  for (String symbol in symbols) {
    final String filename = '$symbol.json';
    final String url = 'https://finnhub.io/api/v1/quote?symbol=$symbol&token=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        // Save data to local file
        await saveDataToFile(filename, json);

        quotes[symbol] = StockQuote.fromJson(json);
      } else {
        throw Exception('Failed to load stock quote for $symbol');
      }
    } on SocketException {
      // No internet connection
      Fluttertoast.showToast(msg: "No internet connection. Loading local data for $symbol...");

      final localData = await readDataFromFile(filename);
      if (localData != null) {
        quotes[symbol] = StockQuote.fromJson(localData);
      } else {
        throw Exception('No local data available for $symbol');
      }
    } catch (e) {
      throw Exception('Error for $symbol: $e');
    }
  }

  return quotes;
}

