import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220419/presentation/providers/movies/initial_loading_provider.dart';

class FullscreenLoader extends ConsumerWidget {
  const FullscreenLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double progress = ref.watch(initialLoadingProgressProvider);
    final String progressText = (progress * 100).toStringAsFixed(0);

    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.movie_filter_outlined,
              size: 120,
              color: colors.primary,
            ),
            const SizedBox(height: 40),

            Text(
              'CINEMAPEDIA',
              style: textStyles.headlineMedium?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: colors.primary.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colors.primary,
                      ),
                    ),
                  ),
                  
                  Text(
                    '$progressText%',
                    style: textStyles.headlineSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Text(
              'Preparando el estreno...',
              style: textStyles.titleMedium?.copyWith(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}