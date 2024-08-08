import 'package:dio/dio.dart';

import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource{
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.themovieDbKey,
      'language': 'es-MX',
    }
    

  ));



  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final movieDBResponse = MovieDBResponse.fromJson(response.data);


    final List<Movie> movies = movieDBResponse.results
    .where((movieDB) => movieDB.posterPath!= 'no-poster',)
    .map(
      (movieDB) => MovieMapper.movieDBToEntity(movieDB),).toList();

    return movies;
  }

}