import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home_page.dart';
import 'news_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: const Color.fromARGB(255, 181, 48, 38),
              tabBackgroundColor: const Color.fromARGB(255, 34, 34, 34),
              gap: 8,
              padding: const EdgeInsets.all(16),
              onTabChange: _onTabTapped,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  style: GnavStyle.google,
                ),
                GButton(
                  icon: Icons.article,
                  text: 'News',
                ),
                GButton(
                  icon: Icons.message,
                  text: 'Alerts',
                )
              ]),
        ),
      ),
    );
  }
}
