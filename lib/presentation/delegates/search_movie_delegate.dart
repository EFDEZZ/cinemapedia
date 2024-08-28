
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/number_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>>Function(String query);
class SearchMovieDelegate extends SearchDelegate<Movie?>{
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

  @override
  String get searchFieldLabel => 'Buscar Película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return[

      // if(query.isNotEmpty)
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: (){
            query = '';
        }, icon: const Icon(Icons.clear)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query), 
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieSearchItem(
              movie: movies[index], 
              onMovieSelected: close,);
            // final movie = movies[index];
            // return ListTile(
            //   title: Text(movie.title),
            // );
          },
        );

      },
    );
  }

}

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieSearchItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
  final textStyle = Theme.of(context).textTheme;
  final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
          //* Imagen
          SizedBox(
            width: size.width*0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                )),
          ),
          const SizedBox(width: 10,),
          
          //* Descripcion
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${movie.title} (${movie.releaseDate.toString().substring(0,4)})', style: textStyle.titleMedium,),
                (movie.overview.length > 100)
                ? Text('${movie.overview.substring(0, 100)}...')
                : Text(movie.overview),
      
                Row(
                  children: [
                    Icon(Icons.star_half_rounded, color: Colors.yellow.shade800,),
                    Text(
                      NumberFormats.numberRounded(movie.voteAverage),
                      style: textStyle.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                      ),
                  ],
                )
              ],
            ),
          )
      
          ],
        ),
      ),
    );
  }
}