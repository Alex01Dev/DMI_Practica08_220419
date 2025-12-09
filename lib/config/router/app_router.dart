import 'package:go_router/go_router.dart';
import 'package:cinemapedia_220419/presentation/screens/movies/movie_screen.dart';
import 'package:cinemapedia_220419/presentation/screens/screens.dart'; // Asumiendo que HomeScreen está aquí
import 'package:cinemapedia_220419/presentation/screens/splash_screen.dart'; // <--- ¡Importa tu Splash Screen!

final appRouter = GoRouter(
  initialLocation: '/splash', // <--- ¡Ahora el splash es la ubicación inicial!
  routes: [
    // 1. Ruta del Splash Screen (será la primera en mostrarse)
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),

    // 2. Ruta principal (después del splash, la app irá aquí)
    GoRoute(
      path: '/', // Esta será la ruta de tu HomeScreen
      name:
          HomeScreen
              .name, // El nombre de tu HomeScreen (opcional, pero buena práctica)
      builder: (context, state) => const HomeScreen(),
      routes: [
        // 3. Ruta de detalle de película (anidada bajo la principal)
        // El 'id' es un parámetro de ruta, no se llama '/'
        GoRoute(
          path:
              'movie/:id', // <--- ¡Ruta corregida para el detalle de la película!
          name: MovieScreen.name, // El nombre de tu MovieScreen
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),
        // Puedes agregar más rutas anidadas aquí, por ejemplo:
        // GoRoute(
        //   path: 'series',
        //   builder: (context, state) => const SeriesScreen(),
        // ),
      ],
    ),

    // Opcional: Si tienes otras rutas de nivel superior que no son anidadas a Home, las pondrías aquí
    // GoRoute(
    //   path: '/settings',
    //   builder: (context, state) => const SettingsScreen(),
    // ),
  ],
);
