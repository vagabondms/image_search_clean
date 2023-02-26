import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_search/app.dart';
import 'package:image_search/bloc_observer.dart';

void main() async {
  await dotenv.load(fileName: "assets/config/.env");
  Bloc.observer = const GlobalBlocObserver();

  runApp(const AppView());
}
