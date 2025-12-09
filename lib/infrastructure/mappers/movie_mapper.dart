import 'package:cinemapedia_220419/domain/entities/movie.dart';
import 'package:cinemapedia_220419/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia_220419/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {

  // --- FUNCIÓN 1 (Ya la tienes bien) ---
  static Movie movieDBToEntity(MovieMovieDB movieDb) => Movie(
        adult: movieDb.adult,
        backdropPath: (movieDb.backdropPath != null && movieDb.backdropPath!.isNotEmpty)
            ? 'https://image.tmdb.org/t/p/w500/${movieDb.backdropPath}'
            : 'https://via.placeholder.com/1280x720.png?text=No+Backdrop',
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview ?? 'No description available',
        popularity: movieDb.popularity,
        posterPath: (movieDb.posterPath != null && movieDb.posterPath!.isNotEmpty)
            ? 'https://image.tmdb.org/t/p/w500/${movieDb.posterPath}'
            : 'https://via.placeholder.com/182x273.png?text=No+Poster',
        
        // Esta línea está correcta:
        releaseDate: movieDb.releaseDate, 
        
        title: movieDb.title,
        video: movieDb.video,
        voteAverage: movieDb.voteAverage,
        voteCount: movieDb.voteCount,
        classification: movieDb.adult ? 'R' : 'PG-13',
      );

  // --- FUNCIÓN 2 (Aquí está el error, en la línea 60+) ---
  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: (moviedb.backdropPath != null && moviedb.backdropPath!.isNotEmpty)
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://via.placeholder.com/1280x720.png?text=No+Backdrop',
        genreIds: moviedb.genres.map((e) => e.name).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview ?? 'No description available',
        popularity: moviedb.popularity,
        posterPath: (moviedb.posterPath != null && moviedb.posterPath!.isNotEmpty)
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'https://via.placeholder.com/182x273.png?text=No+Poster',
        
        // --- ¡ARREGLA ESTA LÍNEA TAMBIÉN! ---
        // Borra todo el 'tryParse' y déjalo así:
        releaseDate: moviedb.releaseDate, 
        // ---------------------------------
        
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
        classification: moviedb.adult ? 'R' : 'PG-13',
      );
}