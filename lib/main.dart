import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_search/app.dart';

void main() async {
  await dotenv.load(fileName: "assets/config/.env");

  runApp(AppView());
}
