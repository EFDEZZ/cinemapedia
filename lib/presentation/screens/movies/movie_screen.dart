import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  final String movieID;
  const MovieScreen({super.key, required this.movieID});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: ${widget.movieID}'),
      ),
    );
  }
}