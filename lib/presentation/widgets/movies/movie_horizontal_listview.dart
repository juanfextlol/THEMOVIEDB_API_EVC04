import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../config/helpers/format_numbers.dart';
import '../../../domain/entities/movie.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListView> createState() => _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {

  final ScrollController scrollController = ScrollController();
  bool isloading = false;
  bool ismounting = false;

@override
  void initState() {
    super.initState();
    scrollController.addListener(() {
     if(widget.loadNextPage==null)return;
     if(scrollController.position.pixels+200
      >= scrollController.position.maxScrollExtent){
      
        widget.loadNextPage!();
      }
    });
  }
  @override
  void dispose() {
   scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          //* Title
        if (widget.title != null || widget.subTitle != null)
          _Title(
            title: widget.title,
            subTitle: widget.subTitle,
          ),
          //*Separador
            const  SizedBox(height: 5,),

            //* Images Horizontal
        Expanded(
            child: ListView.builder(
              controller: scrollController,
          itemCount: widget.movies.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return FadeInRight(
              child: _Slide(
                movie: widget.movies[index],
              ),
            );
          },
        ))
      ]),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
     final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ));
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          //*---------- Imagen Terminada-------
          const SizedBox(
            height: 5,
          ),
          //* Title
           SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall ,
              ),
          //child: ,
          ),
            //* Votaciones
          Row(
            children: [
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    const Icon(Icons.star_half_outlined, color: Colors.amber,),
                    const SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style:textStyle.bodyMedium?.copyWith(color: Colors.amber),),
                    const Spacer(),
                    Text(
                      FormatNumbers.formatNumbers(movie.popularity), style: textStyle.bodyMedium, 
                     )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              '$title',
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text('$subTitle'),
            )
        ],
      ),
    );
  }
}
