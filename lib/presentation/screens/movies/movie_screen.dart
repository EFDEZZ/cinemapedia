import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/number_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_gradient.dart';

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
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    // final movies = ref.watch(movieInfoProvider);
    // final movie = movies[widget.movieID];

    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieID];

    if (movie == null) {
      return const Scaffold(
          body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliver(
            movie: movie,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(
                        movie: movie,
                      ),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*Imagen
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      movie.posterPath,
                      width: size.width * 0.30,
                    ),
                  ),
                  //*Rating
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.3,
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_half_outlined,
                          color: Colors.yellow.shade800,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          NumberFormats.numberRounded(movie.voteAverage),
                          style: TextStyle(color: Colors.yellow.shade900),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.thumb_up_outlined,
                          color: Color.fromARGB(255, 12, 82, 139),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(NumberFormats.humanFormatNumber(movie.popularity))
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                width: 10,
              ),

              //* Titulo y Sinopsis
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${movie.title} (${movie.releaseDate.toString().substring(0,4)})',
                      style: textStyle.titleLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      movie.overview,
                    )
                  ],
                ),
              ),
              
            ],
          ),
        ),

        //Generos
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
              ),)
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, bottom: 5),
          child: Text('Actores:', textAlign: TextAlign.start ,style: textStyle.titleMedium,)),

        //Actores
        _ActorsByMovie(movieID: movie.id.toString()),




        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieID;
  const _ActorsByMovie({required this.movieID});

  @override
  Widget build(BuildContext context, ref) {
    final actorByMovie = ref.watch(actorsByMovieProvider);

    if(actorByMovie[movieID] == null) return const CircularProgressIndicator(strokeWidth: 2,);

    final actors = actorByMovie[movieID]!;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo actor
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                      ),
                  ),
                ),
                // Nombre de actor
                Text(actor.name, maxLines: 2,),
                Text(
                  '(${actor.character})', 
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                  ),
                

              ],
              ),
          );
        },),
    );
  }
}

final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
},);
class _CustomSliver extends ConsumerWidget {
  final Movie movie;
  const _CustomSliver({required this.movie});

  @override
  Widget build(BuildContext context, ref) {
    
    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      actions: [
        IconButton(onPressed: (){
      
          ref.watch(localStorageRepositoryProvider).toggleFavorite(movie);
          ref.invalidate(isFavoriteProvider);
    
        }, icon: isFavoriteFuture.when(
          data: (isFavorite) => isFavorite
          ? const Icon(Icons.favorite, color: Colors.red,)
          : const Icon(Icons.favorite_border_rounded), 
          error: (error, stackTrace) => throw UnimplementedError(), 
          loading: () => const CircularProgressIndicator(strokeWidth: 2,),
          ),
        )
        // 
        //const Icon(Icons.favorite_border_outlined))
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20, color: Colors.white),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            // PosterGradient
            const CustomGradient(
                begin: Alignment.topCenter, 
                end: Alignment.bottomCenter, 
                stops: [0.7, 1], 
                colors: [
                Colors.transparent, 
                Colors.black87
                ]
              ),
              // BackArrow Gradient
            const CustomGradient(
                begin: Alignment.topLeft, 
                stops: [0.0, 0.3], 
                colors: [
                  Colors.black,
                  Colors.transparent,
                ]
              ),
              // FavoriteButton Gradient
            const CustomGradient(
                begin: Alignment.topRight, 
                end: Alignment.bottomLeft,
                stops: [0.0, 0.25], 
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ]
              ),
          ],
        ),
      ),
    );
  }
}
