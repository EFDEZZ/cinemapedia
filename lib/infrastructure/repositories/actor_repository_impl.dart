
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository{
  @override
  Future<List<Actor>> getActorsByMovie(String movieID) {
    // TODO: implement getActorsByMovie
    throw UnimplementedError();
  }

}