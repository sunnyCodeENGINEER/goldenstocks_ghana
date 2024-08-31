import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/pages/predict_page.dart';
import 'package:goldenstocks_ghana/pages/stocks_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: SearchBar(
                hintText: 'Search for stock ...',
              )),
              SizedBox(
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
                        builder: (context) => const StocksPage()));
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
        Navigator.push((context),
            MaterialPageRoute(builder: (context) => const PredictPage()));
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
