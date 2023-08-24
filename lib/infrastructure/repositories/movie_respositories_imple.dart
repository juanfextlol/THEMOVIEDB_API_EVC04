

import '../../domain/datasources/movies_datasources.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movies_repositories.dart';

class MovieRpositoryImpl extends MoviesRepository{

  final MovieDataSource dataSource;

  MovieRpositoryImpl(this.dataSource);
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {

    return dataSource.getNowPlaying(page: page);



  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return dataSource.getPopular(page: page);

  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {

    return dataSource.getTopRated(page: page);

  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return dataSource.getUpcoming(page: page);

  }


}