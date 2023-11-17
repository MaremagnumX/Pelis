import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:pelis/infrastructure/repositories/actor_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRespositoryImpl(ActorMoviedbDatasource());
});
