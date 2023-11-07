import 'dart:math';
import 'package:flutter/material.dart';

class FadeInDemo extends StatefulWidget {
  const FadeInDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {
  double opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 120)),
        TextButton(
          child: const Text(
            '透明度变化',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () => setState(() {
            if (opacity == 0.0) {
              opacity = 1;
            } else {
              opacity = 0.0;
            }
          }),
        ),
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(seconds: 2),
          child: const Icon(Icons.access_alarm, size: 200),
        )
      ],
    );
  }
}

double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  late Color color;
  late double borderRadius;
  late double margin;

  @override
  void initState() {
    super.initState();
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();
  }

  void change() {
    setState(() {
      color = randomColor();
      borderRadius = randomBorderRadius();
      margin = randomMargin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 120)),
        TextButton(
            child: const Text(
              'change',
              style: TextStyle(color: Colors.blueAccent),
            ),
            onPressed: () => change()),
        SizedBox(
          width: 128,
          height: 128,
          child: AnimatedContainer(
            margin: EdgeInsets.all(margin),
            duration: const Duration(seconds: 2),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius)),
            curve: Curves.easeInOutBack,
          ),
        )
      ],
    );
  }
}
