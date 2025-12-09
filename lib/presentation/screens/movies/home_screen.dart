import 'package:cinemapedia_220419/presentation/providers/movies/initialLoading_provider.dart';
import 'package:cinemapedia_220419/presentation/providers/providers.dart'; 
import 'package:cinemapedia_220419/presentation/widgets/shared/full_screen_loader.dart'; 
import 'package:cinemapedia_220419/presentation/widgets/widgets.dart' hide FullscreenLoader;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
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

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(getTopRatedMoviesProvider.notifier).loadNextPage();
    ref.read(getMexicanMoviesProvider.notifier).loadNextPage();
    ref.read(getUpcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) {
      return const FullscreenLoader(); 
    }

    final nowPlaying = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popular = ref.watch(popularMoviesProvider);
    final mejorClificados = ref.watch(getTopRatedMoviesProvider);
    final mexican = ref.watch(getMexicanMoviesProvider);
    final upcoming = ref.watch(getUpcomingMoviesProvider);

    final now = DateTime.now();

    final formatoCompleto = DateFormat('EEEE d \'de\' MMMM y', 'es_MX');
    final formatoMesAnio = DateFormat('MMMM y', 'es_MX');

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    MoviesSlideshow(movies: slideShowMovies),
                    MovieHorizontalListview(
                      movies: nowPlaying,
                      title: 'En cines',
                      subTitle: formatoCompleto.format(now),
                      loadNextPage:
                          () =>
                              ref
                                  .read(nowPlayingMoviesProvider.notifier)
                                  .loadNextPage(),
                    ),
                    MovieHorizontalListview(
                      movies: upcoming,
                      title: 'Próximamente',
                      subTitle: formatoMesAnio.format(now).toUpperCase(),
                      loadNextPage:
                          () =>
                              ref
                                  .read(getUpcomingMoviesProvider.notifier)
                                  .loadNextPage(),
                    ),
                    MovieHorizontalListview(
                      movies: popular,
                      title: 'Populares',
                      subTitle: 'Películas populares',
                      loadNextPage:
                          () =>
                              ref
                                  .read(popularMoviesProvider.notifier)
                                  .loadNextPage(),
                    ),
                    MovieHorizontalListview(
                      movies: mejorClificados,
                      title: 'Mejor calificados',
                      subTitle: 'Mejor calificadas',
                      loadNextPage:
                          () =>
                              ref
                                  .read(getTopRatedMoviesProvider.notifier)
                                  .loadNextPage(),
                    ),
                    MovieHorizontalListview(
                      movies: mexican,
                      title: 'Mexicanas',
                      subTitle: 'Mejores películas mexicanas',
                      loadNextPage:
                          () =>
                              ref
                                  .read(getMexicanMoviesProvider.notifier)
                                  .loadNextPage(),
                    ),
                  ],
                ),
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
