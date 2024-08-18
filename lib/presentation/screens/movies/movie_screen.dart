import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  final String movieID;
  const MovieScreen({super.key, required this.movieID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: $movieID'),
      ),
    );
  }
}