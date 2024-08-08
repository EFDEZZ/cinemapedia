import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/movie_from_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieFromMovieDB movieDB) => Movie(
      adult: movieDB.adult,
      video: movieDB.video,
      backdropPath: (movieDB.backdropPath!='')
      ?'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
      : 'https://res.cloudinary.com/teepublic/image/private/s--UNm73W6m--/t_Preview/b_rgb:191919,c_limit,f_auto,h_630,q_90,w_630/v1606803184/production/designs/16724220_0.jpg',
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      posterPath: (movieDB.posterPath != '') 
      ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
      : 'no-poster',
      title: movieDB.title,
      id: movieDB.id,
      voteCount: movieDB.voteCount,
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      popularity: movieDB.popularity,
      releaseDate: movieDB.releaseDate,
      voteAverage: movieDB.voteAverage);
}
