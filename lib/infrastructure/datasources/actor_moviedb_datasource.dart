import 'package:dio/dio.dart';
import 'package:pelis/config/constants/environment.dart';
import 'package:pelis/domain/datasources/actors_datasource.dart';
import 'package:pelis/domain/entities/actor.dart';
import 'package:pelis/infrastructure/mappers/actor_mapper.dart';
import 'package:pelis/infrastructure/models/moviedb/credits_response.dart';

class ActorMoviedbDatasource extends ActorsDataSource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.movideDbKey,
    'language': 'es-CO',
  }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    if (response.statusCode != 200) {
      throw Exception('Credits with $movieId not found');
    }

    final movieCredits = CreditstResponse.fromJson(response.data);

    List<Actor> actors = movieCredits.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
