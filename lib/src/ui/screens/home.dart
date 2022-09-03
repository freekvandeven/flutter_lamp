import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static final String _loremText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
      'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
      ' Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
      'nisi ut aliquip ex ea commodo consequat. ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // fill entire screen with lorem ipsum
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          _loremText *
              (MediaQuery.of(context).size.height ~/
                  _calculateTextSize(context)),
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  double _calculateTextSize(BuildContext context) {
    return (TextPainter(
      text: TextSpan(
        text: _loremText,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width))
        .size
        .height;
  }
}
