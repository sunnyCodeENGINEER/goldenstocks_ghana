import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const Text('Predicted Price:'),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'GHs',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  '999.99',
                  style: TextStyle(fontSize: 90, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Text('Confidence: 100%'),
            const Spacer(),
            ElevatedButton(
                onPressed: () {}, child: const Text('View Historical Data')),
            const Spacer(),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
