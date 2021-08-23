import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/widgets/widgets.dart';

class DetailScreens extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie.title, movie.fullbackdropImg),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie),
              _Overview(movie.overview),
              CastingCard(movie.id)
            ])
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final String title;
  final String backdrop;

  const _CustomAppBar(
    this.title,
    this.backdrop
  ); 

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.purple,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width:double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right:10),
          color:Colors.black12,
          child: Text(
            title,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          )
        ),
        background: FadeInImage(
          placeholder: AssetImage('lib/assets/loading.gif'),
          image: NetworkImage('${this.backdrop}'),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(
    this.movie
  );

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius:BorderRadius.circular(30),
              child: FadeInImage(
                placeholder:AssetImage('lib/assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 200,
                // width: 110
              )
            ),
          ),

          SizedBox(width: 20),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              children:[
                Text('${movie.title}',style: textTheme.headline5, overflow:TextOverflow.ellipsis, maxLines: 2),
                Text('${movie.originalTitle}',style: textTheme.subtitle2, overflow:TextOverflow.ellipsis, maxLines: 2),
                Row(
                  children:[
                    Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    SizedBox(width:5),
                    Text('${movie.voteAverage}', style: textTheme.caption)
                  ]
                )
              ]
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(top:20),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;

  const _Overview( this.overview) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Text(
        this.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}