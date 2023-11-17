import 'package:pelis/domain/entities/actor.dart';

abstract class ActorsDataSource {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
