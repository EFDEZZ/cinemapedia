import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';


class HomeScreen extends StatelessWidget {
  // static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomnavigation(),
      body: _HomeView(),
    );
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
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

    if(slideShowMovies.isEmpty) return const Center(child: CircularProgressIndicator(strokeWidth: 2,));

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
            movies: nowPlayingMovies,
            title: 'Próximamente',
            subtitle: 'En este mes',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
          MovieHorizontalListview(
            movies: popularMovies,
            title: 'Populares',
            // subtitle: 'En este mes',
            loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Mejor Calificadas',
            subtitle: 'Todos Los Tiempos',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(height: 15,)
      
        ],
      );
      
        },
        childCount: 1
        ))
      ]
    );
  }
}