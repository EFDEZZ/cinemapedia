import 'package:flutter/material.dart';

class PosterGradient extends StatelessWidget {
  const PosterGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
        child: DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.7, 0.98
          ],
              colors: [
            Colors.transparent,
            Colors.black87
          ])),
    ));
  }
}
