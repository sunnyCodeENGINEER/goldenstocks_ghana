import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/models/stock_symbols.dart';
import 'package:goldenstocks_ghana/models/stocks.dart';
import 'package:goldenstocks_ghana/pages/stocks_page.dart';
import 'package:lottie/lottie.dart';

import '../models/stocks_model.dart';
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
        title: const Row(
          children: [
            SizedBox(
              width: 60,
            ),
            Spacer(),
            Text(
              'Stocks',
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            SizedBox(
              width: 30,
              // child:
              // ElevatedButton(
              //     onPressed: () {},
              //     child: const Icon(
              //       Icons.settings,
              //       color: Colors.red,
              //     )),
            ),
            SizedBox(
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
                hintStyle: const WidgetStatePropertyAll(
                    TextStyle(color: Colors.red, fontSize: 19)),
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
                  child: const Icon(
                    Icons.search,
                    color: Colors.red,
                  )),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const Spacer(),
          const StockOfTheDayBanner(),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shadowColor: const Color.fromARGB(255, 123, 174, 215),
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red)),
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
      onTap: () async {
        StockQuote stock = await fetchStockQuote('AAPL');
        Navigator.push(
            (context),
            MaterialPageRoute(
                builder: (context) => PredictPage(
                      symbol: 'AAPL',
                      closingPrice: stock.previousClose.toString(),
                    )));
      },
      child: Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 123, 174, 215),
                offset: Offset(-5, -5),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Colors.red,
                offset: Offset(10, 10),
                blurRadius: 10,
              )
            ]),
        child: Column(
          children: [
            const Text(
              'Stock of the day: \nApple (AAPL)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 90,
              width: 200,
              child: Lottie.asset('assets/splash.json'),
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
