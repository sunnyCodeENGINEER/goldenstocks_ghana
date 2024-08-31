import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> _getLocalFile(String filename) async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/$filename');
}

Future<void> saveDataToFile(String filename, Map<String, dynamic> data) async {
  final file = await _getLocalFile(filename);
  await file.writeAsString(jsonEncode(data));
}

Future<Map<String, dynamic>?> readDataFromFile(String filename) async {
  try {
    final file = await _getLocalFile(filename);
    if (await file.exists()) {
      final contents = await file.readAsString();
      return jsonDecode(contents);
    }
  } catch (e) {
    print('Error reading file: $e');
  }
  return null;
}
