import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/movie_details.dart';
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
      : 'https://th.bing.com/th/id/OIP.T1uutxkFTHvSswa1emt5HAAAAA?w=126&h=189&c=7&r=0&o=5&dpr=1.3&pid=1.7',
      title: movieDB.title,
      id: movieDB.id,
      voteCount: movieDB.voteCount,
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      popularity: movieDB.popularity,
      releaseDate: movieDB.releaseDate != null ? movieDB.releaseDate!: DateTime.now(),
      voteAverage: movieDB.voteAverage);

  static Movie movieDetailsToEntity(MovieDetails movieDB) => Movie(
    adult: movieDB.adult,
      video: movieDB.video,
      backdropPath: (movieDB.backdropPath!='')
      ?'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
      : 'https://res.cloudinary.com/teepublic/image/private/s--UNm73W6m--/t_Preview/b_rgb:191919,c_limit,f_auto,h_630,q_90,w_630/v1606803184/production/designs/16724220_0.jpg',
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: (movieDB.overview != '')
      ? movieDB.overview
      : "Sinopsis no disponible",
      posterPath: (movieDB.posterPath != '') 
      ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
      : 'https://res.cloudinary.com/teepublic/image/private/s--UNm73W6m--/t_Preview/b_rgb:191919,c_limit,f_auto,h_630,q_90,w_630/v1606803184/production/designs/16724220_0.jpg',
      title: movieDB.title,
      id: movieDB.id,
      voteCount: movieDB.voteCount,
      genreIds: movieDB.genres.map((e) => e.name).toList(),
      popularity: movieDB.popularity,
      releaseDate: movieDB.releaseDate,
      voteAverage: movieDB.voteAverage);
}
