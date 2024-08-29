
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMovieProvider = StateProvider<String>((ref) => '',);

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(moviesRepositoryProvider);
  return SearchedMoviesNotifier(ref: ref, searchMovies: movieRepository.searchMovies);
},);

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>>{
  SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.ref,
    required this.searchMovies,
  }):super([]);

  Future <List<Movie>> searchMoviesByQuery(String query) async {
    
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchMovieProvider.notifier).update((state) => query,);

    state = movies;
    return movies;
  }
}