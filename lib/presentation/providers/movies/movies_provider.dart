import 'package:cinemapedia_220419/domain/entities/movie.dart';
import 'package:cinemapedia_220419/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


typedef MovieCallback = Future<List<Movie>> Function({int page});


final nowPlayingMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(
  () =>
      MoviesNotifier((ref) => ref.watch(movieRepositoryProvider).getNowPlaying),
);


final popularMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(
  () => MoviesNotifier((ref) => ref.watch(movieRepositoryProvider).getPopular),
);

final getTopRatedMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(
  () => MoviesNotifier((ref) => ref.watch(movieRepositoryProvider).getTopRated),
);

final getMexicanMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(
  () => MoviesNotifier((ref) => ref.watch(movieRepositoryProvider).getMexican),
);

final getUpcomingMoviesProvider = NotifierProvider<MoviesNotifier, List<Movie>>(
  () => MoviesNotifier((ref) => ref.watch(movieRepositoryProvider).getUpcoming),
);

final getMovieById = NotifierProvider<MoviesNotifier, List<Movie>>(
  () => MoviesNotifier((ref) => ref.watch(movieRepositoryProvider).getMovieById),
);


class MoviesNotifier extends Notifier<List<Movie>> {
  final MovieCallback Function(Ref ref) _callbackBuilder;

  late final MovieCallback fetchMoreMovies;

  MoviesNotifier(this._callbackBuilder);

  int currentPage = 0;

  bool isLoading = false;

  @override
  List<Movie> build() {
    fetchMoreMovies = _callbackBuilder(ref);

    return [];
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;

    currentPage++;

    final movies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));

    isLoading = false;
  }
}
