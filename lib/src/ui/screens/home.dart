import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static final String _loremText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
      'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
  Offset initialPosition(BuildContext context) {
    return Offset(MediaQuery.of(context).size.width / 2, 0);
  }

  @override
  Widget build(BuildContext context) {
    var lampIsOn = useState(false);
    var lampPosition = useState(initialPosition(context));
    var oldLampPosition = useState(initialPosition(context));
    var newLampPosition = useState(initialPosition(context));
    var animationController =
        useAnimationController(duration: const Duration(seconds: 1));
    animationController.addListener(() {
      // move the lamp
      lampPosition.value = Offset.lerp(
        oldLampPosition.value,
        newLampPosition.value,
        animationController.value,
      )!;
    });
    var size = MediaQuery.of(context).size;
    var lampWidth = size.height * 0.05;
    var lampHeight = size.height * 0.1;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) {
            newLampPosition.value = details.localPosition;
            oldLampPosition.value = lampPosition.value;
            animationController.forward(from: 0);
          },
          onDoubleTap: () {
            newLampPosition.value = initialPosition(context);
            oldLampPosition.value = lampPosition.value;
            animationController
              ..duration = const Duration(milliseconds: 500)
              ..forward(from: 0);
          },
          child: Stack(
            children: [
              const SizedBox.expand(),
              if (lampIsOn.value) ...[
                ShaderMask(
                  shaderCallback: (rect) {
                    return RadialGradient(
                      center: Alignment.topLeft,
                      colors: [
                        const Color.fromARGB(255, 210, 204, 159),
                        const Color.fromARGB(255, 78, 74, 45).withOpacity(0.1),
                      ],
                      radius: (size.width > size.height
                              ? size.width / 5
                              : size.height) *
                          0.0005,
                    ).createShader(
                      rect.translate(
                        lampPosition.value.dx,
                        lampPosition.value.dy + lampHeight / 2,
                      ),
                    );
                  },
                  child: Text(
                    HomeScreen._loremText *
                        (MediaQuery.of(context).size.height ~/
                                _calculateTextSize(context) +
                            2),
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              CustomPaint(
                painter: LinePainter(
                  start: Offset(size.width / 2, 0),
                  end: Offset(
                    lampPosition.value.dx,
                    lampPosition.value.dy + lampHeight / 20,
                  ),
                ),
              ),
              Positioned(
                left: lampPosition.value.dx - lampWidth / 2,
                top: lampPosition.value.dy,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        lampIsOn.value = !lampIsOn.value;
                      },
                      child: Image.asset(
                        lampIsOn.value
                            ? 'assets/images/bright_bulb.png'
                            : 'assets/images/bulb.png',
                        width: lampWidth,
                        height: lampHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateTextSize(BuildContext context) {
    var layout = (TextPainter(
      text: TextSpan(
        text: HomeScreen._loremText,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width))
        .size;
    if (layout.width < MediaQuery.of(context).size.width) {
      return layout.height / (MediaQuery.of(context).size.width / layout.width);
    }
    return layout.height;
  }
}

class LinePainter extends CustomPainter {
  const LinePainter({required this.start, required this.end});
  final Offset start;
  final Offset end;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color.fromARGB(255, 185, 175, 85)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
