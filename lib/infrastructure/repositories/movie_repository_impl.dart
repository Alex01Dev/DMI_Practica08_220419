import 'package:cinemapedia_220419/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_220419/domain/entities/movie.dart';
import 'package:cinemapedia_220419/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getMexican({int page = 1}) {
    return datasource.getMexican(page: page);
  }

  @override
  Future<List<Movie>> getMovieById({int page = 1}) {
    return datasource.getMovieById(page: page);
  }
}
