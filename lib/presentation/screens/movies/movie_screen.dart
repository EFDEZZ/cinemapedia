import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/shared/poster_gradient.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

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
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliver(movie: movie,),
        ],

      ),
    );
  }
}

class _CustomSliver extends StatelessWidget {
  final Movie movie;
  const _CustomSliver({
    required this.movie
    });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height*0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.start,
          
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                ),
            ),
            const PosterGradient(),
            const BackArrowGradient(),
          ],
        ),
      ),

    );
  }
}