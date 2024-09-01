// import 'package:flutter/material.dart';

// import '../components/candlestick_chart.dart';
// import '../models/historical_data_model.dart';

// class StockCandlestickPage extends StatelessWidget {
//   final String symbol;
//   const StockCandlestickPage({super.key, required this.symbol});

//   @override
//   Widget build(BuildContext context) {
//    return FutureBuilder<HistoricalStockData?>(
//       future: fetchHistoricalStockData(symbol),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError || !snapshot.hasData) {
//           return const Center(child: Text('Error fetching data'));
//         } else {
//           final stockData = snapshot.data!;
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Stock Prices For $symbol'),
//             ),
//             body: Column(
//               children: [
//                 SizedBox(
//                     height: 400,
//                     child: StockCandleChart(timeSeries: stockData.timeSeries, stockQuotes: [],)),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildLegend(color: Colors.blue, label: 'Open'),
//                     const SizedBox(width: 10),
//                     _buildLegend(color: Colors.green, label: 'High'),
//                     const SizedBox(width: 10),
//                     _buildLegend(color: Colors.red, label: 'Low'),
//                     const SizedBox(width: 10),
//                     _buildLegend(color: Colors.orange, label: 'Close'),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }

//   Widget _buildLegend({required Color color, required String label}) {
//     return Row(
//       children: [
//         Container(
//           width: 20,
//           height: 20,
//           color: color,
//         ),
//         const SizedBox(width: 5),
//         Text(label),
//       ],
//     );
//   }
// }