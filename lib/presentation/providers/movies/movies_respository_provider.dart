

import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../infrastructure/datasources/moviedb_datasource.dart';
import '../../../infrastructure/repositories/movie_respositories_imple.dart';


//ESTE REPOSITORIO ES INMUTABLE
final movieRepositoryProvider = Provider((ref) {
    //ESTO ES NUESTRA INSTANCIA DE  MovieRpositoryImpl
  return MovieRpositoryImpl(MovideDbDataSource());

});