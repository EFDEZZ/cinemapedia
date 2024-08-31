import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    
    final initialLoading = ref.watch(initialLoadingProvider);

    if(initialLoading)  return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: DecoratedBox(decoration: BoxDecoration(color:Colors.white)),
            centerTitle: true,
            title: CustomAppbar(),
          ),
        ),

        SliverList(delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
        children: [
          MoviesSlideshow(movies: slideShowMovies),
          
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Estrenos',
            subtitle: 'Lunes 20',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
          MovieHorizontalListview(
            movies: upcomingMovies,
            title: 'Próximamente',
            subtitle: 'En este mes',
            loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
            ),
          MovieHorizontalListview(
            movies: popularMovies,
            title: 'Populares',
            // subtitle: 'En este mes',
            loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
          MovieHorizontalListview(
            movies: topRatedMovies,
            title: 'Mejor Calificadas',
            subtitle: 'Todos Los Tiempos',
            loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(height: 10,)
      
        ],
      );
      
        },
        childCount: 1
        ))
      ]
    );
  }
}