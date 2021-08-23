import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/providers/movies_provaider.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {


  final int movieId;

  const CastingCard( this.movieId) ;

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);
      // print(moviesProvider.getCreditsMovie(movieId));
    return FutureBuilder(
      future: moviesProvider.getCreditsMovie(movieId),
      builder: ( _ , AsyncSnapshot<List<Cast>> snapshot){
        if( !snapshot.hasData ){
          return Container(
            constraints: BoxConstraints(maxWidth: 150), 
            height: 180,
            child: CircularProgressIndicator()
          );

        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          // color: Colors.red,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (_, int index) => _CastCard(cast[index]),
          )
        );
      },
    );

    
  }
}

class _CastCard extends StatelessWidget {

  final Cast cast;


  const _CastCard(
     this.cast
  );
    
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(cast.fullProfilePath), 
              placeholder: AssetImage('lib/assets/no-image.jpg'),
              height: 140,
              width: 100,
              fit: BoxFit.cover
            )
          ),
          SizedBox(height: 5),
          Text(
            '${cast.name}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}