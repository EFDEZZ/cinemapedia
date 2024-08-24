
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/credits_response.dart';

class ActorMapper{
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: cast.profilePath != null 
    ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
    : 'https://secdatacom.no/wp-content/uploads/sites/3/2019/10/blank-profile-male.jpg', 
    character: cast.character
    );
}