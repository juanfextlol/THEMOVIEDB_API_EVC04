import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../domain/entities/movie.dart';
import 'movies_respository_provider.dart';

  final nowPlayingMoviesProvider =
  StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
    );
});

  final popularMoviesProvider =
  StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
    );
});

  final topRatedMoviesProvider =
  StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
    );
});
  final upComingMoviesProvider =
  StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
    );
});


typedef MovieCallBack = Future Function({int page});


//* ESTE ES EL CONTROLADOR
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isloading = false;
  MovieCallBack fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadnextPage() async {
    if (isloading) return;
    isloading = true;
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 400));
    isloading = false;
  }
}
