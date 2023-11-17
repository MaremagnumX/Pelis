import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis/domain/entities/actor.dart';
import 'package:pelis/presentation/provider/actors/actors_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRespository = ref.watch(actorsRepositoryProvider);
  return ActorByMovieNotifier(getActors: actorsRespository.getActorsByMovie);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;
  ActorByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
