class FlutterRoute {
  const FlutterRoute(this.route);

  static const homeScreen = FlutterRoute('/home');

  final String route;

  @override
  String toString() => route;
}
