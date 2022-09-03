import 'package:flutter/material.dart';
import 'package:flutter_lamp/src/config/theme.dart';
import 'package:flutter_lamp/src/flutterroute.dart';
import 'package:flutter_lamp/src/routes.dart';

class FlutterLampApp extends StatelessWidget {
  const FlutterLampApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
      initialRoute: FlutterRoute.homeScreen.route,
      onGenerateRoute: (settings) {
        var routes = getRoutes(settings);
        if (routes.containsKey(settings.name)) {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => routes[settings.name]!(context),
            settings: settings,
          );
        } else {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const Text('Page not found'),
            settings: settings,
          );
        }
      },
    );
  }
}
