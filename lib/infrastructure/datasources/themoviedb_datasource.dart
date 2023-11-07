import 'package:dio/dio.dart';
import 'package:pelis/config/constants/environment.dart';
import 'package:pelis/domain/datasources/movies_datasource.dart';
import 'package:pelis/domain/entities/movie.dart';
import 'package:pelis/infrastructure/mappers/movie_mapper.dart';
import 'package:pelis/infrastructure/models/moviedb/moviedb_response.dart';

class TheMovieDbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movideDbKey,
        'language': 'es-CO'
      }));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntitie(moviedb))
        .toList();

    return movies;
  }
}
