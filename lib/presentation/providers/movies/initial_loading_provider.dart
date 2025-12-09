import 'package:flutter_riverpod/flutter_riverpod.dart';
// Importa tus providers de películas (ajusta la ruta si es necesario)
import 'package:cinemapedia_220419/presentation/providers/movies/movies_provider.dart'; 

/// Este provider calculará el progreso de la carga inicial (0.0 a 1.0)
final initialLoadingProgressProvider = Provider<double>((ref) {
  
  const int totalLoadingSteps = 3; // (nowPlaying, popular, upcoming)
  int completedSteps = 0;

  if (ref.watch(nowPlayingMoviesProvider).isNotEmpty) {
    completedSteps++;
  }
  
  if (ref.watch(popularMoviesProvider).isNotEmpty) {
    completedSteps++;
  }
  
  if (ref.watch(getUpcomingMoviesProvider).isNotEmpty) {
    completedSteps++;
  }

  // 3. Calcula y devuelve el progreso
  if (completedSteps == 0) return 0.0;
  
  return completedSteps / totalLoadingSteps;
});