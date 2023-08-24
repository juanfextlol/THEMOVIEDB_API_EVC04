//TODO: ESTO SE VA ENCARGAR DE LLAMAR AL DATASOURCES

//todo: ESTO NOS PERMITIRA CAMBIAR EL DATASOURCES

import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRated({ int page = 1 });
  Future<List<Movie>> getUpcoming({ int page = 1 });
}
