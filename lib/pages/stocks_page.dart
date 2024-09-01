// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/models/stock_symbols.dart';
import 'package:goldenstocks_ghana/models/stocks.dart';
import 'package:goldenstocks_ghana/models/stocks_model.dart';
import 'package:goldenstocks_ghana/pages/predict_page.dart';

class StocksPage extends StatefulWidget {
  final List<String> symbols;
  const StocksPage({
    super.key,
    required this.symbols,
  });

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  final List<String> items = List<String>.generate(10, (i) => "Item ${i + 1}");
  final Stocks stocks = Stocks();

  late Future<StockQuote> futureStockQuote;
  late Future<Map<String, StockQuote>> futureStockQuotes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureStockQuote = fetchStockQuote('AAPL');
    futureStockQuotes = fetchStockQuotes(widget.symbols);
    print(futureStockQuote.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<Map<String, StockQuote>>(
          future: futureStockQuotes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final quotes = snapshot.data!;
              return ListView(
                padding: const EdgeInsets.all(8.0),
                children: quotes.entries.map((entry) {
                  final symbol = entry.key;
                  final quote = entry.value;
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            (context),
                            MaterialPageRoute(
                              builder: (context) => PredictPage(
                                symbol: symbol,
                                closingPrice: quote.previousClose.toString(),
                              ),
                            ));
                      },
                      title: Text(
                        '${getKeyFromValue(symbol)}($symbol)',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                      // titleTextStyle:
                      //     const TextStyle(fontSize: 24, color: Colors.red),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Current Price: ${quote.currentPrice}'),
                          Text('High Price: ${quote.highPrice}'),
                          Text('Low Price: ${quote.lowPrice}'),
                          Text('Open Price: ${quote.openPrice}'),
                          Text('Previous Close: ${quote.previousClose}'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
      // Center(
      //   child: FutureBuilder<StockQuote>(
      //     future: futureStockQuote,
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return CircularProgressIndicator();
      //       } else if (snapshot.hasError) {
      //         return Text('Error: ${snapshot.error}');
      //       } else if (snapshot.hasData) {
      //         final quote = snapshot.data!;
      //         return Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text('Current Price: ${quote.currentPrice}'),
      //             Text('High Price: ${quote.highPrice}'),
      //             Text('Low Price: ${quote.lowPrice}'),
      //             Text('Open Price: ${quote.openPrice}'),
      //             Text('Previous Close: ${quote.previousClose}'),
      //           ],
      //         );
      //       } else {
      //         return Text('No data');
      //       }
      //     },
      //   ),
      // ),

      // ListView.builder(
      //   itemCount: items.length,
      //   itemBuilder: (context, index) {
      //     final item = items[index];

      //     return ListTile(
      //       title: Text(item),
      //       onTap: () {
      //         // Handle item tap if needed
      //         Navigator.push((context),
      //             MaterialPageRoute(builder: (context) => const PredictPage()));
      //       },
      //     );
      //   },
      // )
    );
  }
}
