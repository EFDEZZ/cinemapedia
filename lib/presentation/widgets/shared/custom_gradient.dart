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
              stops: [0.8, 1],
              colors: [Colors.transparent, Colors.black87])),
    ));
  }
}

class BackArrowGradient extends StatelessWidget {
  const BackArrowGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
        child: DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, stops: [
        0.0,
        0.3
      ], colors: [
        Colors.black87,
        Colors.transparent,
      ])),
    ));
  }
}

class CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const CustomGradient(
      {super.key,
      this.begin = Alignment.centerLeft,
      this.end = Alignment.centerRight,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin, 
            end: end,
            stops: stops, 
            colors: colors,
          )
        ),
    ));
  }
}
