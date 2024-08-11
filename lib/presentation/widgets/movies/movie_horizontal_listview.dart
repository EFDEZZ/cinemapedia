import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/number_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieHorizontalListview extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if(title != null || subtitle != null)
          _Title(title: title, subtitle: subtitle,),

          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _Slide(movie: movies[index],),
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
      child: Expanded(
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
                    
                    return FadeInRight(child: child);
                  },
                  ),
                )
              ),
            
              const SizedBox(height: 5,),
            
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
                  margin: const EdgeInsets.only(left: 5, right: 15),
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

          if(title != null)
          FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            onPressed: (){}, 
            child: Text(subtitle!,))
        ],
      ),
    );
  }
}