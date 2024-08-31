import 'package:flutter/material.dart';
import 'package:goldenstocks_ghana/pages/home_page.dart';

import 'news_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    // ShopPage(),
    const HomePage(),

    const NewsPage(),
    const Placeholder(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: 
      BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0 ? Icons.home : Icons.home_outlined,
              size: _currentIndex == 0 ? 40 : 24,
              color: const Color.fromARGB(255, 45, 88, 48),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1 ? Icons.article : Icons.article_outlined,
              size: _currentIndex == 1 ? 40 : 24,
              color: const Color.fromARGB(255, 45, 88, 48),
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 2 ? Icons.message : Icons.message_outlined,
              size: _currentIndex == 2 ? 40 : 24,
              color: const Color.fromARGB(255, 45, 88, 48),
            ),
            label: 'Alerts',
          ),
        ],
      ),
    );
  }
}
