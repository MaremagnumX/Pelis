import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pelis/config/helpers/huma_formats.dart';
import 'package:pelis/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate({required this.searchMovies, required this.initialMovies})
      : super(
            searchFieldLabel: 'Buscar películas',
            textInputAction: TextInputAction.search);

  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  Widget _buildResultsAndSugestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              }),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.refresh_rounded),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear_outlined),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
      onPressed: () {
        clearStreams();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsAndSugestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _buildResultsAndSugestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyle.titleMedium,
                  ),
                  (movie.overview.length > 100)
                      ? Text(
                          "${movie.overview.substring(0, 100)}...",
                        )
                      : Text(
                          movie.overview,
                        ),
                  const SizedBox(width: 5),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyle.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
