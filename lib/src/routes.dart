import 'package:flutter/material.dart';
import 'package:flutter_lamp/src/flutterroute.dart';
import 'package:flutter_lamp/src/ui/screens/home.dart';

Map<String, WidgetBuilder> getRoutes(RouteSettings settings) {
  return {
    FlutterRoute.homeScreen.route: (context) => const HomeScreen(),
  };
}
