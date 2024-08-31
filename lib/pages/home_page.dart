import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/models/stock_symbols.dart';
import 'package:goldenstocks_ghana/pages/stocks_page.dart';

import 'predict_page.dart';

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
        // leading: Container(),
        title: Row(
          children: [
            const SizedBox(
              width: 60,
            ),
            const Spacer(),
            const Text('GoldenStock Ghana'),
            const Spacer(),
            SizedBox(
              width: 30,
              child: ElevatedButton(
                  onPressed: () {}, child: const Icon(Icons.settings)),
            ),
            const SizedBox(
              width: 30,
            )
          ],
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
        width: 300,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.black),
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

// class StockOfTheDayBanner extends StatelessWidget {
//   const StockOfTheDayBanner({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const PredictPage(
//               symbol: 'AAPL',
//             ),
//           ),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         color: Colors.blue,
//         child: Row(
//           children: const [
//             Icon(Icons.show_chart, color: Colors.white),
//             SizedBox(width: 8),
//             Text(
//               'Stock of the day',
//               style: TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

