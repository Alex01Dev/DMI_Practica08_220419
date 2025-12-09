// Archivo: package:movies/infrastructure/models/moviedb/movie_moviedb.dart

class MovieMovieDB {
  MovieMovieDB({
    required this.adult,
    this.backdropPath, // ¡Ahora es opcional!
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    this.overview, // ¡Ahora es opcional!
    required this.popularity,
    this.posterPath, // ¡Ahora es opcional!
    this.releaseDate, // ¡Ahora es opcional!
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath; // Tipo nullable
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String? overview; // Tipo nullable
  final double popularity;
  final String? posterPath; // Tipo nullable
  final DateTime? releaseDate; // Tipo nullable
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieMovieDB.fromJson(Map<String, dynamic> json) => MovieMovieDB(
    adult: json["adult"] ?? false,
    backdropPath:
        json["backdrop_path"], // Asignar directamente (puede ser null)
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"], // Asignar directamente (puede ser null)
    popularity:
        json["popularity"]?.toDouble() ?? 0.0, // Valor por defecto si es null
    posterPath: json["poster_path"], // Asignar directamente (puede ser null)
    releaseDate:
        (json['release_date'] != null &&
                json['release_date']
                    .toString()
                    .isNotEmpty) // Corregido 'release_data' a 'release_date'
            ? DateTime.tryParse(json['release_date'])
            : null, // Si es inválido o nulo, asigna null
    title: json["title"],
    video: json["video"],
    voteAverage:
        json["vote_average"]?.toDouble() ?? 0.0, // Valor por defecto si es null
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath, // Puede ser null
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview, // Puede ser null
    "popularity": popularity,
    "poster_path": posterPath, // Puede ser null
    "release_date":
        releaseDate != null
            ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"
            : null, // Manejar null en toJson también
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
