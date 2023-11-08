import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis/infrastructure/datasources/themoviedb_datasource.dart';
import 'package:pelis/infrastructure/repositories/movie_repository_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(TheMovieDbDatasource());
});
