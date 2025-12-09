import 'package:flutter_riverpod/flutter_riverpod.dart';
// Importa tus providers de películas (ajusta la ruta si es necesario)
import 'package:cinemapedia_220419/presentation/providers/movies/movies_provider.dart'; 

/// Este provider calculará el progreso de la carga inicial (0.0 a 1.0)
final initialLoadingProgressProvider = Provider<double>((ref) {
  
  // 1. Define el número total de tareas de carga inicial
  const int totalLoadingSteps = 3; // (nowPlaying, popular, upcoming)
  int completedSteps = 0;

  // 2. Observa (watch) cada provider. Si su lista ya NO está vacía, cuenta como un paso completado.
  // Esto cumple el requisito: "incremente justo cuando la llamada... haya culminado"
  
  if (ref.watch(nowPlayingMoviesProvider).isNotEmpty) {
    completedSteps++;
  }
  
  if (ref.watch(popularMoviesProvider).isNotEmpty) {
    completedSteps++;
  }
  
  if (ref.watch(getUpcomingMoviesProvider).isNotEmpty) {
    completedSteps++;
  }

  // Puedes añadir más providers aquí si los necesitas en la carga inicial
  // solo recuerda aumentar el 'totalLoadingSteps'
  
  // 3. Calcula y devuelve el progreso
  if (completedSteps == 0) return 0.0;
  
  return completedSteps / totalLoadingSteps;
});