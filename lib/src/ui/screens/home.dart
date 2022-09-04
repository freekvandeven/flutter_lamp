import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static final String _loremText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
      'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOn = false;
  Offset position = Offset.zero;

  @override
  void initState() {
    super.initState();
    // set initial offset to center of screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        position = Offset(MediaQuery.of(context).size.width / 2, 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // fill entire screen with lorem ipsum
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Text(
              HomeScreen._loremText *
                  (MediaQuery.of(context).size.height ~/
                      _calculateTextSize(context)),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            Positioned(
              left: position.dx,
              top: position.dy,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isOn = !_isOn;
                      });
                    },
                    child: Image.asset(
                      _isOn
                          ? 'assets/images/bright_bulb.png'
                          : 'assets/images/bulb.png',
                      height: size.height * 0.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTextSize(BuildContext context) {
    return (TextPainter(
      text: TextSpan(
        text: HomeScreen._loremText,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width))
        .size
        .height;
  }
}
