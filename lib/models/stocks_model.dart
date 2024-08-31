class StockQuote {
  final double currentPrice;
  final double highPrice;
  final double lowPrice;
  final double openPrice;
  final double previousClose;

  StockQuote({
    required this.currentPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.openPrice,
    required this.previousClose,
  });

  factory StockQuote.fromJson(Map<String, dynamic> json) {
    return StockQuote(
      currentPrice: json['c'].toDouble(),
      highPrice: json['h'].toDouble(),
      lowPrice: json['l'].toDouble(),
      openPrice: json['o'].toDouble(),
      previousClose: json['pc'].toDouble(),
    );
  }
}
