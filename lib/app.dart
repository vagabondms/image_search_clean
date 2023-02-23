import 'package:flutter/material.dart';
import 'package:image_search/presentation/photo/photo.dart';
import 'package:image_search/presentation/splash/splash.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<AppView> createState() => _AppState();
}

class _AppState extends State<AppView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (RouteSettings routeSettings) {
          switch (routeSettings.name) {
            case '/':
              return SplashPage.route();
            case '/photo':
              return PhotoPage.route();
            default:
              return SplashPage.route();
          }
        });
  }
}
