import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  final String movieID;
  const MovieScreen({super.key, required this.movieID});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {

    // final movies = ref.watch(movieInfoProvider);
    // final movie = movies[widget.movieID];
    
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieID];

    if(movie == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2,),));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: ${widget.movieID}'),
      ),
    );
  }
}