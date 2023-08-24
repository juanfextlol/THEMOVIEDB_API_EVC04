import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../../domain/datasources/movies_datasources.dart';
import '../../domain/entities/movie.dart';
import '../mappers/movie_mapper.dart';
import '../models/movideDB/movidedb_response.dart';

class MovideDbDataSource extends MovieDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movideBDkey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final moviedbResponse = MovideDbResponse.fromJson(json);

    final List<Movie> movies = moviedbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMappers.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }
  //todo: primero especificamos  la 1 pagina
  //todo: luego nuestro retorno sera un future de una lista de MOVIE que son nuestras ent

  //*GET NOW PLAYING
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  //*GET POPULAR

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  //*GET TOP RATED

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  //*GET UP COMING

  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
        final response = await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);

  }
}
