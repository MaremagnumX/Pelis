import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis/presentation/provider/providers.dart';

import 'package:pelis/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayinMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayinMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.all(0),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: moviesSlideshow),
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subtitle: 'Lunes 20',
                    loadNextPage: () => ref
                        .read(nowPlayinMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: upComingMovies,
                    title: 'Proximamente',
                    subtitle: 'En este mes',
                    loadNextPage: () => ref
                        .read(upComingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    subtitle: 'De todos los tiempos',
                    loadNextPage: () => ref
                        .read(topRatedMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    //subtitle: 'En este mes',
                    loadNextPage: () =>
                        ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),
                  const SizedBox(height: 10)
                ],
              );
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}
