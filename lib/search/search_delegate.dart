
import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/providers/movies_provaider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar';

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      }, 
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('data');
  }

  Widget _emtyContainer(){
     return Container(
        child: Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.black)
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    if( query.isEmpty ){
      return _emtyContainer();
    }

    final providers = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: providers.searchMovie(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot){
        if( !snapshot.hasData ) return _emtyContainer();

        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movies[index])
        );
      }
    );
  }
  
}


class _MovieItem extends StatelessWidget {

  final Movie movie;
  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage('lib/assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.cover
        ),
      ),
      title:Text(
        '${movie.title}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
            // textAlign: TextAlign.center,
      ),
      subtitle: Text(
        '${movie.overview}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        // textAlign: TextAlign.center,
      ),
      onTap: () => Navigator.pushNamed(context,'details',arguments:movie),
    );
  }
}