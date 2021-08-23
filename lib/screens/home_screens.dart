import 'package:flutter/material.dart';
import 'package:movies/providers/movies_provaider.dart';
import 'package:movies/search/search_delegate.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    // print(moviesProvider.onDisplayMovies);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Movies')
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
      ),
      body: SingleChildScrollView(
      child: 
        Column(
          children: [
            //Listado Horizontal de pelis,
            //Tarjetas Principales
            CardSwiper(movies:moviesProvider.onDisplayMovies),

            //Slider de peli
            MovieSlider(
              movie: moviesProvider.popularMovies,
              title: 'Populares', //Opccional
              onNextPage: () => moviesProvider.getPopularesMovie()

            )
          ],
        )
      ),
    );

  }
}