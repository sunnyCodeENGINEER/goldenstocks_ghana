import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/pages/predict_page.dart';

class StocksPage extends StatefulWidget {
  const StocksPage({super.key});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  final List<String> items = List<String>.generate(10, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title: Text(item),
            onTap: () {
              // Handle item tap if needed
              Navigator.push((context),
                  MaterialPageRoute(builder: (context) => const PredictPage()));
            },
          );
        },
      )
      // return Dismissible(
      //   key: Key(item),
      //   direction: DismissDirection.endToStart,
      //   onDismissed: (direction) {
      //     setState(() {
      //       items.removeAt(index);
      //     });

      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text('$item dismissed'),
      //       ),
      //     );
      //   },
      //   background: Container(
      //     color: Colors.red,
      //     alignment: Alignment.centerRight,
      //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //     child: const Icon(
      //       Icons.delete,
      //       color: Colors.white,
      //     ),
      //   ),
      //   child: ListTile(
      //     title: Text(item),
      //   ),
      // );
      ,
    );
  }
}
