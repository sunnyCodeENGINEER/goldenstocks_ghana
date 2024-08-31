import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/models/stock_symbols.dart';
import 'package:goldenstocks_ghana/pages/predict_page.dart';
import 'package:goldenstocks_ghana/pages/stocks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController query = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [Spacer(), Text('GoldenStock Ghana'), Spacer()],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: SearchBar(
                controller: query,
                hintText: 'Search for stock ...',
              )),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (query.text.isNotEmpty) {
                      // String symb = getStockSymbolOrName(query.text);
                      List<String> symb = getMatchingStocks(query.text);
                      // if (symb == 'Input not found in stock symbols') return;
                      if (symb.isEmpty) return;

                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) => StocksPage(
                                    symbols: symb,
                                  )));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20)),
                  child: const Icon(Icons.search)),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const Spacer(),
          const StockOfTheDayBanner(),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) =>
                            StocksPage(symbols: getValues())));
              },
              child: const Text('View all Stocks')),
          const Spacer(),
        ],
      ),
    );
  }
}

class StockOfTheDayBanner extends StatelessWidget {
  const StockOfTheDayBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            (context),
            MaterialPageRoute(
                builder: (context) => const PredictPage(
                      symbol: 'AAPL',
                    )));
      },
      child: Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Column(
          children: [
            Text(
              'Stock of the day',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
