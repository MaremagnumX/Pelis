import 'package:dio/dio.dart';
import 'package:pelis/config/constants/environment.dart';
import 'package:pelis/domain/datasources/movies_datasource.dart';
import 'package:pelis/domain/entities/movie.dart';

class TheMovieDbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movideDbKey,
        'language': 'es-CO'
      }));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final reponse = await dio.get('/movie/now_playing');
    final List<Movie> movies = [];
    
    return [];
  }
}
