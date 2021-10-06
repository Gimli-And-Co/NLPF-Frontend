import 'dart:convert';
import 'package:flutter/services.dart';

const String _REGIONS_FILE_PATH = 'regions.json';

Future<Map<String, dynamic>> loadRegionsFile() async {
  String jsonString = await rootBundle.loadString(_REGIONS_FILE_PATH);
  return jsonDecode(jsonString) as Map<String, dynamic>;
}
