
import 'package:isar/isar.dart';

part 'movie.g.dart';

@Collection()
class Movie{

  Id isarId = Isar.autoIncrement;

  final bool adult;
  final bool video;
  final String backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String title;
  final int id;
  final int voteCount;
  final List<String> genreIds;
  final double popularity;
  final DateTime releaseDate;
  final double voteAverage;

  Movie({
    required this.adult, 
    required this.video, 
    required this.backdropPath, 
    required this.originalLanguage, 
    required this.originalTitle, 
    required this.overview, 
    required this.posterPath, 
    required this.title, 
    required this.id, 
    required this.voteCount, 
    required this.genreIds, 
    required this.popularity, 
    required this.releaseDate, 
    required this.voteAverage});
}