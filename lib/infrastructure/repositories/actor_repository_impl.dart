import 'package:pelis/domain/datasources/actors_datasource.dart';
import 'package:pelis/domain/entities/actor.dart';
import 'package:pelis/domain/repositories/actors_repository.dart';

class ActorRespositoryImpl extends ActorsRepository {
  final ActorsDataSource datasource;

  ActorRespositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
