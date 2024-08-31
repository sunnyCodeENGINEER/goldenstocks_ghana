import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/theme_data.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}

// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemeData _themeData = lightTheme;

//   ThemeProvider() {
//     loadTheme();
//   }

//   ThemeData get themeData => _themeData;

//   void setTheme(ThemeData theme) async {
//     _themeData = theme;
//     notifyListeners();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('theme', theme.toString());
//   }

//   void loadTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? themeName = prefs.getString('theme');

//     if (themeName != null) {
//       if (themeName == 'lightTheme') {
//         _themeData = lightTheme;
//       } else if (themeName == 'darkTheme') {
//         _themeData = darkTheme;
//       } else {
//         _themeData = customTheme;
//       }
//     }
//     notifyListeners();
//   }
// }


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          ListTile(
            title: const Text('Light Theme'),
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).setTheme(lightTheme);
            },
          ),
          ListTile(
            title: const Text('Dark Theme'),
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).setTheme(darkTheme);
            },
          ),
          ListTile(
            title: const Text('Custom Theme'),
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).setTheme(customTheme);
            },
          ),
        ],
      ),
    );
  }
}
