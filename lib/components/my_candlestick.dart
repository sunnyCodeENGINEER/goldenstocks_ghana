// import 'package:flutter/material.dart';

// import '../models/stocks_model.dart';

// class MyCandlestick extends StatefulWidget {
//   const MyCandlestick({super.key});

//   @override
//   State<MyCandlestick> createState() => _MyCandlestickState();
// }

// class _MyCandlestickState extends State<MyCandlestick> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 160,
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         SizedBox(
//           height: 30,
//           child: CustomPaint(
//             size: Size.infinite,
//             painter: StockVolumePainter(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class StockVolumePainter extends CustomPainter {
//   // final StockTimeFramePerformance stockData;
//   final StockQuote? stockData;
//   final Paint _gainPaint;
//   final Paint _lossPaint;

//   StockVolumePainter(
//       {super.repaint,
//       required this.stockData,
//       required Paint gainPaint,
//       required Paint lossPaint})
//       : _gainPaint = Paint()..color = Colors.green.withOpacity(0.5),
//         _lossPaint = Paint()..color = Colors.red.withOpacity(0.5);
//   @override
//   void paint(Canvas canvas, Size size) {
//     // TODO: implement paint
//     if (stockData == null) return;

//     // generate bars
//     List<Bar> bars = _generateBars(size);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     return true;
//   }

//   List<Bar> _generateBars(Size availableSpace) {
//     final pixelsPerTimeWindow = availableSpace.width / 25;
//   }
// }

// class Bar {
//   final double width;
//   final double height;
//   final double centerX;
//   final Paint paint;

//   Bar(
//       {required this.width,
//       required this.height,
//       required this.centerX,
//       required this.paint});
// }
