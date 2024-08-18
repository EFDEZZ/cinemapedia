import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/number_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}


class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;

      if((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }
    },);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          if(widget.title != null || widget.subtitle != null)
          _Title(title: widget.title, subtitle: widget.subtitle,),
          const SizedBox(height: 7,),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _Slide(movie: widget.movies[index],),
              )
            ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*Imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                fit: BoxFit.cover,
                movie.posterPath, 
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null){
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2,)),
                    );
                  }
                  
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: FadeInRight(child: child));
                },
                ),
              )
            ),
          
            const SizedBox(height: 5,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   //* Titulo
              SizedBox(
                width: 150,
                child: Text(
                  movie.title,
                  maxLines: 2,
                  style: titleStyle.titleSmall,
                ),
              ),
              
              // *Rating
              SizedBox(
                width: 150,
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 15,),
                  child: Row(
                    children: [
                      Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                      const SizedBox(width: 5,),
                      // Text('${movie.voteAverage}', style: TextStyle(color: Colors.yellow.shade800),),
                      Text(NumberFormats.numberRounded(movie.voteAverage), style: TextStyle(color: Colors.yellow.shade900),),
                      const Spacer(),
                      const Icon(Icons.thumb_up_outlined, color: Color.fromARGB(255, 12, 82, 139),),
                      const SizedBox(width: 5,),
                      Text(NumberFormats.humanFormatNumber(movie.popularity))
                      // Text('${movie.popularity}')
                    ],
                  ),
                ),
              )
                ],
              ),
            ),
      
        ],
      ), 
      );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          if(title != null)
          Text(title!, style: titleStyle,),

          const Spacer(),

          if(subtitle != null)
          FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            onPressed: (){}, 
            child: Text(subtitle!,)),
            
        ],
      ),
    );
  }
}