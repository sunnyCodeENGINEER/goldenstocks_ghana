// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/models/ema_data.dart';
import 'package:goldenstocks_ghana/pages/result_page.dart';

import '../models/stock_symbols.dart';

class PredictPage extends StatefulWidget {
  final String symbol;
  final String closingPrice;
  const PredictPage({
    super.key,
    required this.symbol,
    required this.closingPrice,
  });

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.closingPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Text(
              '${getKeyFromValue(widget.symbol)}\n(${widget.symbol})',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 60,
              ),
            ),
            const Text('Enter previous closing price'),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter closing price',
                  labelStyle: const TextStyle(
                    color: Colors.red, // Label color
                    fontSize: 16.0, // Label font size
                  ),
                  hintText: 'Type something...',
                  hintStyle: const TextStyle(
                    color: Colors.grey, // Hint text color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red, // Border color when not focused
                      width: 2.0, // Border width when not focused
                    ),
                    borderRadius: BorderRadius.circular(10.0), // Border radius
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue, // Border color when focused
                      width: 2.0, // Border width when focused
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.text_fields,
                    color: Colors.red, // Icon color
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
                  color: Colors.white, // Text color
                  fontSize: 18.0, // Text size
                ),
                cursorColor: Colors.blue, // Cursor color
                maxLines: 1, // Number of lines
              ),
            ),
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
                          builder: (context) => ResultPage(
                                symbol: widget.symbol,
                                current: _controller.text,
                              )));
                },
                child: const Text('Predict')),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
