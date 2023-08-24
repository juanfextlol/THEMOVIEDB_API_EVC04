import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../providers/movies/initial_loading_provider.dart';
import '../../providers/movies/movies_providers.dart';
import '../../providers/movies/movies_slideshow_provider.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: _HomeView(), bottomNavigationBar: CustomNavigationBar());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadnextPage();
    ref.read(popularMoviesProvider.notifier).loadnextPage();
    ref.read(topRatedMoviesProvider.notifier).loadnextPage();
    ref.read(upComingMoviesProvider.notifier).loadnextPage();
    
  }

  @override
  Widget build(BuildContext context)  {
      
    final initialLoading = ref.watch(initialLoadingProvider) ;
    
    if(initialLoading)return const FullScreenLoader();

    //*PETICIONES
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
     final popularMovies = ref.watch(popularMoviesProvider);
     final topRatedMovies = ref.watch(topRatedMoviesProvider);
     final upComingMovies = ref.watch(upComingMoviesProvider);
     //*MOVIES
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);


    return CustomScrollView(
      slivers: [
          const SliverAppBar(
          
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                // const CustomAppBar(),
                MoviesSlideShow(movies: moviesSlideShow),
                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'En Cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadnextPage();
                  },
                ),
                MovieHorizontalListView(
                  movies: popularMovies,
                  title: 'Populares',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    ref.read(popularMoviesProvider.notifier).loadnextPage();
                  },
                ),
                MovieHorizontalListView(
                  movies: topRatedMovies,
                  title: 'Mejores Calificadas',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    ref.read(topRatedMoviesProvider.notifier).loadnextPage();
                  },
                ),
                MovieHorizontalListView(
                  movies: upComingMovies,
                  title: 'Proximamente',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    ref.read(upComingMoviesProvider.notifier).loadnextPage();
                  },
                ),
              ],
            );
          },
          childCount: 1,
        ))
      ],
    );
  }
}
