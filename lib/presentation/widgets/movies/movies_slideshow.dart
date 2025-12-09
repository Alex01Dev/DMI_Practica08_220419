import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia_220419/domain/entities/movie.dart';
import 'package:intl/intl.dart'; // Importa intl para formatear la fecha

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 10)),
      ],
    );

    // Formateador de fecha
    final DateFormat formatter = DateFormat('dd \'de\' MMMM \'de\' y', 'es_MX');
    final String releaseDateString =
        movie.releaseDate != null
            ? formatter.format(movie.releaseDate!)
            : 'Próximamente';

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // --- Imagen de Fondo ---
              SizedBox.expand(
                child: Image.network(
                  movie.backdropPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black12),
                      );
                    }
                    return child;
                  },
                ),
              ),

              // --- Degradado inferior ---
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0], // Ajusta el degradado
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),

              // --- NUEVO: Título y Fecha de Estreno ---
              Positioned(
                bottom: 20,
                left: 20,
                right: 20, // Agregamos right para evitar overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:
                      MainAxisSize.min, // Para que la columna no ocupe todo
                  children: [
                    // Título
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Fecha de Estreno
                    Text(
                      releaseDateString,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // --- NUEVO: Chip de Clasificación ---
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white54, width: 1),
                  ),
                  child: Text(
                    movie.classification, // 'R' o 'PG-13'
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
