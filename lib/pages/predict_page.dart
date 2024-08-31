// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/pages/result_page.dart';

import '../models/stock_symbols.dart';

class PredictPage extends StatelessWidget {
  final String symbol;
  const PredictPage({
    super.key,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
                'Enter current closing price for ${getKeyFromValue(symbol)}($symbol)'),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter closing price',
                  labelStyle: const TextStyle(
                    color: Colors.blue, // Label color
                    fontSize: 16.0, // Label font size
                  ),
                  hintText: 'Type something...',
                  hintStyle: const TextStyle(
                    color: Colors.grey, // Hint text color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue, // Border color when not focused
                      width: 2.0, // Border width when not focused
                    ),
                    borderRadius: BorderRadius.circular(10.0), // Border radius
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.green, // Border color when focused
                      width: 2.0, // Border width when focused
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.text_fields,
                    color: Colors.blue, // Icon color
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      // Clear the text field
                    },
                  ),
                  filled: true,
                  fillColor: Colors.lightBlueAccent
                      .withOpacity(0.1), // Background color of the text field
                ),
                style: const TextStyle(
                  color: Colors.black, // Text color
                  fontSize: 18.0, // Text size
                ),
                cursorColor: Colors.blue, // Cursor color
                maxLines: 1, // Number of lines
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => ResultPage(
                                symbol: symbol,
                              )));
                },
                child: const Text('Predict'))
          ],
        ),
      ),
    );
  }
}
