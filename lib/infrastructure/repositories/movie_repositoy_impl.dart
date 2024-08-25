
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoyImpl extends MoviesRepository{
  final MoviesDatasource datasource;

  MovieRepositoyImpl({required this.datasource});



  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated();
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming();
  }
  
  @override
  Future<Movie> getMovieDetails(String id) {
    return datasource.getMovieDetails(id);
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasource.searchMovies(query);
  }
  
}